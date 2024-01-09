package Local_Search;

import java.util.Random;

import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Function_Package.AcceptationCriteria;
import Methods.Method;
import Reinforcement_Learning.ReinforcementLearning_Old;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that defines the structure of a Adaptive Local Search - specific to the publication 
 * in Bracis2015. Defined at run time by Design Pattern Builder.
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

//Local Search and VND - em função de neighborhood_size
public class LocalSearch_AdaptiveBRACIS2015 extends Method{

	private ReinforcementLearning_Old rl;
	
	private AcceptationCriteria criteria;
	private MoveNeighborhood movement_neighborhood;
	private BestNeighbor best_neighbor;
	
	private Element element; //MovementElement
	
	private Solution s_line;
	private Solution best_solution;
	private Solution s;
	
	private int neighborhood_size;
	
	private String function_type;
	
	@Override
	public Solution runMethod(Problem p, Solution so, int id_agent) {
		// TODO Auto-generated method stub
		boolean improved = true;
		int no_improvement = 0;
		int k, k_1; //se usa k_1, avalia a aplicação do par de vizinhanças [k_1,k]
		
		//registra os movimentos sem melhora
		int k_visited[] = new int[this.getReinforcementLearning().getMaxSizeRoulette()];
		for(int i = 0; i < this.getReinforcementLearning().getMaxSizeRoulette(); i++) {
			k_visited[i] = i;
		}
		
		this.s.copyValuesSolution(so, p);
		this.best_solution.copyValuesSolution(so, p);
		
		while ((improved)) {
			
			k = this.getReinforcementLearning().epsilonGreedyAL(no_improvement); //this.getReinforcementLearning().rouletteWheel();
			//System.out.println("K: " + k);
			
			//Best Neighbor
			this.s.copyValuesSolution(this.best_neighbor.bestNeighbor(k, movement_neighborhood, 
					this.criteria, this.s, this.getParameters(), this.element, p), p);
			 
			if(criteria.acceptationCriteria(this.s, this.best_solution, element, p)) {
				this.best_solution.copyValuesSolution(this.s, p);
				improved = true;
				//this.getReinforcementLearning().updateExperienceReinforce(this.getReinforcementLearning().getK_1(), this.getReinforcementLearning().getK());
				this.getReinforcementLearning().updateRoulette(k);
				for(int i = 0; i < this.getReinforcementLearning().getMaxSizeRoulette(); i++) {
					k_visited[i] = i;
				}
				no_improvement = 0;
				//System.out.println("Melhorou!");
			}
			else {
				this.getReinforcementLearning().decreasesReinforcement(k);
				no_improvement++;
				k_visited[k] = -1;
				int cont_visited = 0;
				for(int i = 0; i < this.getReinforcementLearning().getMaxSizeRoulette(); i++) {
					if(k_visited[i] == -1) {
						cont_visited++;
					}
				}
				if(cont_visited == this.getReinforcementLearning().getMaxSizeRoulette()-1) {
					improved = false;
				}
				if(no_improvement == 20) {
					improved = false;
				}
			}
		}
		return this.best_solution;
	}
	
	public AcceptationCriteria getCriteria() {
		return criteria;
	}

	public void setCriteria(AcceptationCriteria criteria) {
		this.criteria = criteria;
	}

	public Element getElement() {
		return element;
	}

	public void setElement(Element element) {
		this.element = element;
	}

	public Solution getS_line() {
		return s_line;
	}

	public void setS_line(Solution s_line) {
		this.s_line = s_line;
	}

	public Solution getBestSolution() {
		return best_solution;
	}

	public void setBestSolution(Solution best_solution) {
		this.best_solution = best_solution;
	}

	public Solution getS() {
		return s;
	}

	public void setS(Solution s) {
		this.s = s;
	}

	public int getNeighborhoodSize() {
		return neighborhood_size;
	}

	public void setNeighborhoodSize(int neighborhood_size) {
		this.neighborhood_size = neighborhood_size;
	}

	public String getFunctionType() {
		return function_type;
	}

	public void setFunctionType(String function_type) {
		this.function_type = function_type;
	}

	public MoveNeighborhood getMovementNeighborhood() {
		return movement_neighborhood;
	}

	public void setMovementNeighborhood(MoveNeighborhood movement) {
		this.movement_neighborhood = movement;
	}

	public BestNeighbor getBestNeighbor() {
		return best_neighbor;
	}

	public void setBestNeighbor(BestNeighbor best_neighbor) {
		this.best_neighbor = best_neighbor;
	}

	public ReinforcementLearning_Old getReinforcementLearning() {
		return rl;
	}

	public void setReinforcementLearning(ReinforcementLearning_Old rl) {
		this.rl = rl;
	}
	
}
