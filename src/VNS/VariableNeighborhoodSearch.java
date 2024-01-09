package VNS;

import java.io.IOException;

import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Function_Package.AcceptationCriteria;
import Function_Package.StopCondition;
import Methods.Method;

public class VariableNeighborhoodSearch extends Method{

	private Method construction;
	private Method local_search;
	private StopCondition condition;
	private VNSGeneratesNeighbor generates_neighbor;
	private AcceptationCriteria criteria;
	
	private Element element;
	
	private Solution so;
	private Solution s;
	private Solution improve_solution;
	private Solution perturb_solution;
	private Solution best_solution;
	private int k_max; //number of neighborhood structures
	
	@Override
	public Solution runMethod(Problem p, Solution s, int id_agent) {
		// TODO Auto-generated method stub
		long solution_time;
	    //int it = 1; //iteration number
	    int k; //current neighborhood structure
		
		this.so.copyValuesSolution(this.construction.runMethod(p, so, id_agent), p);
		System.out.print("\n\n--INITIAL SOLUTION--");
		this.so.showSolution(p);
		
		solution_time = System.currentTimeMillis() - this.getParameters().getMethodParametersI(id_agent).getInitialTime();
		this.so.setSearchTime(solution_time);
		
		//ADD IN POOL - INITIAL SOLUTION
		this.getCooperation().getPool().addSolutionInPool_evaluation(this.so, p, 0, solution_time, this.element);
			
		//ESCREVENDO NOS ARQUIVOS
		try {
			this.getParameters().getMethodParametersI(id_agent).getFw().writeSolutionsInTextFile(this.so, solution_time, p, "INITIAL");
			this.getParameters().getMethodParametersI(id_agent).getFwReduced().writeSolutionsInTextFilesReduced(this.so, solution_time, p, "INITIAL");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		this.s.copyValuesSolution(this.so, p);
		
		this.best_solution.copyValuesSolution(this.s, p);
		
		while(this.condition.stopCondition(this.element, p, this.best_solution)) {
			k = 1;
			while(k <= this.k_max) {
				this.perturb_solution.copyValuesSolution(this.generates_neighbor.generatesNeighbor(k, s, this.element, id_agent, this.getCooperation(), this.getParameters(), p), p);
				//System.out.print("\n\n--PERTURB SOLUTION--");
				//this.perturb_solution.showSolution(p);
				
				this.improve_solution.copyValuesSolution(this.local_search.runMethod(p, this.perturb_solution, id_agent), p);
				//System.out.print("\n\n--IMPROVE SOLUTION--");
				//this.improve_solution.showSolution(p);
				
				if(this.criteria.acceptationCriteria(this.improve_solution, this.best_solution, this.element, p)) {
					this.best_solution.copyValuesSolution(this.improve_solution, p);
					//System.out.print("\n\n--BEST SOLUTION--");
					//this.best_solution.showSolution(p);
					this.s.copyValuesSolution(this.best_solution, p);
					
					solution_time = System.currentTimeMillis() - this.getParameters().getMethodParametersI(id_agent).getInitialTime();
					this.best_solution.setSearchTime(solution_time);
					
					//ADD IN POOL
					this.getCooperation().getPool().addSolutionInPool_evaluation(this.best_solution, p, id_agent, solution_time, this.element);
				
					//ESCREVENDO NOS ARQUIVOS
					try {
						this.getParameters().getMethodParametersI(id_agent).getFw().writeSolutionsInTextFile(this.best_solution, solution_time, p, "BEST");
						this.getParameters().getMethodParametersI(id_agent).getFwReduced().writeSolutionsInTextFilesReduced(this.best_solution, solution_time, p, "BEST");
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					k = 1;
				}
				else{
					k++;
				}
			}
		}
		
		return this.best_solution;
	}

}
