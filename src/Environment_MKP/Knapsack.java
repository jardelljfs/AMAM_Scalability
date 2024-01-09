package Environment_MKP;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Component of the solution of Multi-objective Backpack Problem  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

import Environment.Problem;

public class Knapsack {
	
	private int items[];
	private int items_number;
	private int total_weight[]; //for each objective (dimension)
	
	public Knapsack(Problem p) {
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		this.items = new int[mkp.getNumberOfItems()];
		this.total_weight = new int[p.getDimension()];
		
		this.items_number = 0;
		for(int i = 0; i < p.getDimension(); i++) {
			this.total_weight[i] = 0;
		}
	}
	
	public void copyValuesKnapsack(Knapsack k, Problem p) {
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		for(int i = 0; i < mkp.getNumberOfItems(); i ++){
			this.setItems(i, k.getItems(i));
		}
		this.items_number = k.items_number;
		
		for(int j = 0; j < p.getDimension(); j++) {
			this.total_weight[j] = k.total_weight[j];
		}
	}
	
	public void showKnapsack(Problem p) {
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		System.out.println("Items Number: " + this.items_number);
		for(int j = 0; j < p.getDimension(); j++) {
			System.out.println("Total Weight - dimension " + j + ": " + this.total_weight[j]);
		}
			
		for(int i = 0; i < mkp.getNumberOfItems(); i ++){
			System.out.print(this.getItems(i) + ", ");
		}
		
	}
	
	public int getItems(int i) {
		return items[i];
	}
	
	public void setItems(int i, int item) {
		this.items[i] = item;
	}
	
	public int getItemsNumber() {
		return items_number;
	}
	
	public void setItemsNumber(int items_number) {
		this.items_number = items_number;
	}
	
	public int getTotalWeightI(int k) {
		return total_weight[k];
	}
	
	public void setTotalWeight(int k, int total_weight) {
		this.total_weight[k] = total_weight;
	}

}
