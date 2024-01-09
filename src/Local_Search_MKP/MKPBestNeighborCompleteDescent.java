package Local_Search_MKP;

import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Environment_MKP.MKProblem;
import Environment_MKP.MKSolution;
import Environment_MKP_Movements.MKPMovementElement;
import Function_Package.AcceptationCriteria;
import Local_Search.BestNeighbor;
import Local_Search.MoveNeighborhood;
import Parameters.Parameters;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that implements the BestNeighbor Class.  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPBestNeighborCompleteDescent implements BestNeighbor{

	private MKSolution s_initial;
	private MKSolution best_neighbor;
	private MKSolution s_line;
	
	private MKPMovementElement element;
	
	@Override
	public Solution bestNeighbor(int neighborhood, MoveNeighborhood movement_neighborhood, 
			AcceptationCriteria criteria, Solution so, Parameters parameters, 
			Element e, Problem p) {
		// TODO Auto-generated method stub
		
		int k = neighborhood;
		
		this.s_initial = null;
		if(so instanceof MKSolution) {
			this.s_initial = (MKSolution) so;
		}		
		
		this.element = null;
		if(e instanceof MKPMovementElement) {
			this.element = (MKPMovementElement) e;
		}
		
		this.best_neighbor = new MKSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		this.s_line = new MKSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		
		this.best_neighbor.copyValuesSolution(this.s_initial, p);
		this.s_line.copyValuesSolution(this.s_initial, p);
		
		
		if(movement_neighborhood.getList().getMoveI(k).getMoveType() == "flipmo") {
			this.bestNeighborFlipMO(k, movement_neighborhood, criteria, parameters, e, p);
		}
		if(movement_neighborhood.getList().getMoveI(k).getMoveType() == "addmo") {
			this.bestNeighborAddMO(k, movement_neighborhood, criteria, parameters, e, p);
		}
		if(movement_neighborhood.getList().getMoveI(k).getMoveType() == "twomo") {
			this.bestNeighborExchangeTwoItem(k, movement_neighborhood, criteria, parameters, e, p);
		}
		
		return this.best_neighbor;
	}

	public void bestNeighborAddMO(int neighborhood, MoveNeighborhood movement_neighborhood,
			AcceptationCriteria criteria, Parameters parameters, Element e, Problem p) {
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		this.element.nullBestCurrentSolution();
		
		for(int i = 0; i < mkp.getNumberOfItems(); i++) {
		
			if(this.s_line.getKnapsacks(0).getItems(i) == 0) {
			
				this.element.setItem1(i);
				//implementa o movimento de acordo com a vizinhança "neighborhood"
				this.s_line.copyValuesSolution(movement_neighborhood.moveNeighborhood(neighborhood, 
					this.s_line, parameters, element, p), p);
							
				if(this.element.isValid()) {
					if(criteria.acceptationCriteria(this.s_line, this.best_neighbor, element, p)) {
						this.best_neighbor.copyValuesSolution(this.s_line, p);
					}	
				}
				else {
					//atribuir penalidade por solução não válida
					for(int l = 0; l < p.getDimension(); l++) {
						this.s_line.setObjectiveFunctionI(l, this.s_line.getObjectiveFunctionI(l)/2);
						this.s_line.calculateFitnessFunction(parameters.getExperimentParameters().getGamaMO(), mkp);
					}
				}
						
				if(this.element.getBestCurrentSolution() == null) {
					this.element.newBestCurrentSolution(new MKSolution(parameters.getExperimentParameters().getReceiverSize(), p));
					this.element.setBestCurrentSolution(this.s_line, p);
				}
				else {
					if(criteria.acceptationCriteria(this.s_line, this.element.getBestCurrentSolution(), element, p)) {
						this.element.setBestCurrentSolution(this.s_line, p);
					}
				}
				
				this.s_line.copyValuesSolution(this.s_initial, p);
			}
		}
	}
		
	public void bestNeighborFlipMO(int neighborhood, MoveNeighborhood movement_neighborhood,
			AcceptationCriteria criteria, Parameters parameters, Element e, Problem p) {
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		this.element.nullBestCurrentSolution();
		
		for(int i = 0; i < mkp.getNumberOfItems(); i++) {
			this.element.setItem1(i);;
					
			//implementa o movimento de acordo com a vizinhança "neighborhood"
			this.s_line.copyValuesSolution(movement_neighborhood.moveNeighborhood(neighborhood, 
				this.s_line, parameters, element, p), p);
						
			if(this.element.isValid()) {
				if(criteria.acceptationCriteria(this.s_line, this.best_neighbor, element, p)) {
					this.best_neighbor.copyValuesSolution(this.s_line, p);
				}	
			}
			else {
				//atribuir penalidade por solução não válida
				for(int l = 0; l < p.getDimension(); l++) {
					this.s_line.setObjectiveFunctionI(l, this.s_line.getObjectiveFunctionI(l)/2);
				}
			}
					
			if(this.element.getBestCurrentSolution() == null) {
				this.element.newBestCurrentSolution(new MKSolution(parameters.getExperimentParameters().getReceiverSize(), p));
				this.element.setBestCurrentSolution(this.s_line, p);
			}
			else {
				if(criteria.acceptationCriteria(this.s_line, this.element.getBestCurrentSolution(), element, p)) {
					this.element.setBestCurrentSolution(this.s_line, p);
				}
			}
					
			this.s_line.copyValuesSolution(this.s_initial, p);
		}
	}
	
	public void bestNeighborExchangeTwoItem(int neighborhood, MoveNeighborhood movement_neighborhood,
			AcceptationCriteria criteria, Parameters parameters, Element e, Problem p) {
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		this.element.nullBestCurrentSolution();
		
		for(int i = 0; i < mkp.getNumberOfItems(); i++) {
			for(int j = i+1; j < mkp.getNumberOfItems(); j++) {
			
				this.element.setItem1(i);
				this.element.setItem2(j);
					
				//implementa o movimento de acordo com a vizinhança "neighborhood"
				this.s_line.copyValuesSolution(movement_neighborhood.moveNeighborhood(neighborhood, 
					this.s_line, parameters, element, p), p);
						
				if(this.element.isValid()) {
					if(criteria.acceptationCriteria(this.s_line, this.best_neighbor, element, p)) {
						this.best_neighbor.copyValuesSolution(this.s_line, p);
					}	
				}
				else {
					//atribuir penalidade por solução não válida
					for(int l = 0; l < p.getDimension(); l++) {
						this.s_line.setObjectiveFunctionI(l, this.s_line.getObjectiveFunctionI(l)/2);
					}
				}
					
				if(this.element.getBestCurrentSolution() == null) {
					this.element.newBestCurrentSolution(new MKSolution(parameters.getExperimentParameters().getReceiverSize(), p));
					this.element.setBestCurrentSolution(this.s_line, p);
				}
				else {
					if(criteria.acceptationCriteria(this.s_line, this.element.getBestCurrentSolution(), element, p)) {
						this.element.setBestCurrentSolution(this.s_line, p);
					}
				}
						
				this.s_line.copyValuesSolution(this.s_initial, p);
			}
		}
	}
	
}
