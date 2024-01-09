package Environment_MKP;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Specialized class for the Solution of the Multi-objective Backpack Problem  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

import java.io.IOException;

import Environment.Problem;
import Environment.Solution;
import Function_Package.WriterInFile;

public class MKSolution extends Solution{

	/* ATTRIBUTES */
	private Knapsack knapsacks[];
	
	public MKSolution(int receiver_size, Problem p) {
		// TODO Auto-generated constructor stub
		super(receiver_size, p.getDimension());
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		this.knapsacks = new Knapsack[mkp.getNumberOfKnapsack()];
		for(int i = 0; i < mkp.getNumberOfKnapsack(); i++) {
			this.knapsacks[i] = new Knapsack(mkp);
		}
	}

	/* OVERRIDE */
	@Override
	public void calculateObjectiveFunction(Problem p) {
		// TODO Auto-generated method stub
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		int of;
		
		/*MULTIOBJECTIVE - treated as multidimensional*/
		if((mkp.getDimension() > 1) && (mkp.getNumberOfKnapsack() == 1)) {
			for(int j = 0; j < p.getDimension(); j++) { //number of goals
				of = 0;
				for(int i = 0; i < mkp.getNumberOfItems(); i++) { //items
					of = of + (mkp.getProfitIJ(j, i) * this.getKnapsacks(0).getItems(i));
				}
				this.setObjectiveFunctionI(j, of);
			}
		}
		/*else*/
		/*INCLUIR OS OUTRAS VARIAÇÕES DO PROBLEMA DA MOCHILA*/
		
	}

	@Override
	public void calculateFitnessFunction(double gama, Problem p) {
		// TODO Auto-generated method stub
		double fitness_function = 0;
		for(int j = 0; j < p.getDimension(); j++) {
			fitness_function = fitness_function + ( gama * this.getObjectiveFunctionI(j));
		}
		this.setFitnessFunction(fitness_function);
	}

	@Override
	public void copyValuesSolution(Solution s, Problem p) {
		// TODO Auto-generated method stub
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		MKSolution mks = null;
		if(s instanceof MKSolution) {
			mks = (MKSolution) s;
		}
		
		this.setCostWithoutPenalty(mks.getCostWithoutPenalty());
		this.setFitnessFunction(mks.getFitnessFunction());
		
		for(int i = 0; i < p.getDimension(); i++) {
			this.setObjectiveFunctionI(i, mks.getObjectiveFunctionI(i));
		}
		
		for(int j = 0; j < mkp.getNumberOfKnapsack(); j++) {
			this.knapsacks[j].copyValuesKnapsack(mks.getKnapsacks(j), mkp);
		}
	}

	@Override
	public void showSolution(Problem p) {
		// TODO Auto-generated method stub
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		System.out.println("\n\n**SOLUTION**");
		for(int i = 0; i < p.getDimension(); i++) {
			System.out.println("Objective Function " + i + ": " + this.getObjectiveFunctionI(i));
		}
		System.out.println("Fitness Function: " + this.getFitnessFunction());
		for(int j = 0; j < mkp.getNumberOfKnapsack() ; j++) {
			System.out.println("\nKnapsack " + j);
			this.getKnapsacks(j).showKnapsack(p);
		}
		
	}
	
	@Override
	public void showOFAndFitness(Problem p) {
		// TODO Auto-generated method stub
		for(int i =0; i < p.getDimension(); i++) {
			System.out.println("Objective Function(" + i + "): " + this.getObjectiveFunctionI(i) );
		}
		System.out.print("Objective Function: " + this.getFitnessFunction());
	}


	@Override
	public void writeSolution(Problem p, WriterInFile fw) throws IOException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void writeReduceSolution(Problem p, WriterInFile fw)
			throws IOException {
		// TODO Auto-generated method stub
		
	}
	
	/*MOVEMENTS*/
	
	//update of, weight, items_number
	public boolean addItemMO(int i, Problem p, double gama) {
		boolean valid = true;
		
		if(this.knapsacks[0].getItems(i) == 0) {	
			MKProblem mkp = null;
			if(p instanceof MKProblem) {
				mkp = (MKProblem) p;
			}
		
			this.knapsacks[0].setItems(i, 1);
			this.knapsacks[0].setItemsNumber(this.knapsacks[0].getItemsNumber() + 1);
			
			for(int j = 0; j < mkp.getDimension(); j++) {
				this.knapsacks[0].setTotalWeight(j, this.knapsacks[0].getTotalWeightI(j) + mkp.getWeight(j, i));
				//update objective function
				this.setObjectiveFunctionI(j, this.getObjectiveFunctionI(j) + mkp.getProfitIJ(j, i));
				
				if(this.knapsacks[0].getTotalWeightI(j) > mkp.getCapacity(j)) {
					valid = false;
				}
			}
		}
		this.calculateFitnessFunction(gama, p);
		return valid;
	}
	
	//update of, weight, items_number
	public void dropItemMO(int i, Problem p, double gama) {
		if(this.knapsacks[0].getItems(i) == 1) {
			
			MKProblem mkp = null;
			if(p instanceof MKProblem) {
				mkp = (MKProblem) p;
			}
			
			this.knapsacks[0].setItems(i, 0);
			this.knapsacks[0].setItemsNumber(this.knapsacks[0].getItemsNumber() - 1);
			
			for(int j = 0; j < mkp.getDimension(); j++) {
				this.knapsacks[0].setTotalWeight(j, this.knapsacks[0].getTotalWeightI(j) - mkp.getWeight(j, i));
				//update objective function
				this.setObjectiveFunctionI(j, this.getObjectiveFunctionI(j) - mkp.getProfitIJ(j, i));
			}
			this.calculateFitnessFunction(gama, p);
		}
	}
	
	public boolean flipItemMO(int i, Problem p, double gama) {
		
		boolean valid = true;
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		if(this.knapsacks[0].getItems(i) == 1) {
			this.dropItemMO(i, p, gama);
		}
		else {
			this.addItemMO(i, p, gama);
		}
					
		//n restrictions
		for(int j = 0; j < p.getDimension(); j++) {
			if(this.knapsacks[0].getTotalWeightI(j) > mkp.getCapacity(j)) {				
				//System.out.println("\n\nSolução viola a restrição de capacidade da dimensão " + j + "!");
				valid = false;
			}
		}
		return valid;
	}
	
	public boolean exchangeTwoItemsMO(int i, int j, Problem p, double gama) {
		boolean valid = true;
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		//item 1
		if(this.knapsacks[0].getItems(i) == 1) {
			this.dropItemMO(i, p, gama);
		}
		else {
			this.addItemMO(i, p, gama);
		}
		//item 2
		if(this.knapsacks[0].getItems(j) == 1) {
			this.dropItemMO(j, p, gama);
		}
		else {
			this.addItemMO(j, p, gama);
		}
		
		//n restrictions
		for(int l = 0; l < p.getDimension(); l++) {
			if(this.knapsacks[0].getTotalWeightI(l) > mkp.getCapacity(l)) {				
				//System.out.println("\n\nSolução viola a restrição de capacidade da dimensão " + l + "!");
				valid = false;
			}
		}
		
		return valid;
	}
	
	/* SETS AND GETS */
	public Knapsack getKnapsacks(int j) {
		return knapsacks[j];
	}

	public void setKnapsacks(int j, Knapsack knapsacks) {
		this.knapsacks[j] = knapsacks;
	}

	@Override
	public void writeSolutionST(Problem p, WriterInFile fw) throws IOException {
		// TODO Auto-generated method stub
		
	}
	
}
