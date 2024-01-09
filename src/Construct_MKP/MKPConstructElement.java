package Construct_MKP;

import Environment.Element;
import Environment.Problem;
import Environment_MKP.MKProblem;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that extends the Element class  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPConstructElement extends Element{

	private int item_ins;
	private int knapsack_ins;
	private int next_candidate;
	private double insertion_cost[];
	private int candidates[];
	private int pos_candidate;
	private int count;  //for candidates
	private int rcl_size;
	
	private double gama; //for multiobjective
	
	public MKPConstructElement(Problem p) {
		super(0);
		// TODO Auto-generated constructor stub
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		this.setItemIns(-1);
		this.setKnapsackIns(-1);
		this.setNextCandidate(-1);
		this.candidates = new int[mkp.getNumberOfItems()];
		this.setCount(0);
		
		this.setInsertionCost(new double[mkp.getNumberOfItems()]);
	}

	public void calculateCostInsertion(double gama, MKProblem p) {
	/*
	 * gama - weight for each objective / dimension
	 */
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		for(int i = 0; i < mkp.getNumberOfItems(); i++) {
			for(int j = 0; j < mkp.getDimension(); j++) {
				this.insertion_cost[i] = this.insertion_cost[i] + (gama * mkp.getProfitIJ(j, i) / mkp.getWeight(j, i));
			}
		}
	}
	
	public void ascendingOrderItems(MKProblem p) {
		int item_aux, j;
		int aux_candidates[] = new int[p.getNumberOfItems()];
		this.candidates[1] = 0;
		
		for(int i = 1; i < p.getNumberOfItems(); i++) {
			item_aux = i;
			j = i-1;
			while(this.insertion_cost[item_aux] < this.insertion_cost[this.candidates[j]]) {
				this.candidates[j+1] = this.candidates[j];
				j = j - 1;
				if(j == -1)
					break;
			}
			this.candidates[j+1] = item_aux;
		}
		
		//inverting
		for(int i = 0; i < p.getNumberOfItems(); i++) {
			aux_candidates[i] = this.candidates[p.getNumberOfItems()-i-1];
		}
		for(int i = 0; i < p.getNumberOfItems(); i++) {
			this.candidates[i] = aux_candidates[i];
		}
		
		System.out.println("\n\nORDER ITENS");
		for(int i = 0; i < p.getNumberOfItems(); i++) {
			System.out.print(this.candidates[i] + " - ");
		}
	}
	
	public void addCount() {
		this.count++;
	}

	/* SETS AND GETS */
	public int getItemIns() {
		return item_ins;
	}

	public void setItemIns(int item_ins) {
		this.item_ins = item_ins;
	}

	public int getKnapsackIns() {
		return knapsack_ins;
	}

	public void setKnapsackIns(int knapsack_ins) {
		this.knapsack_ins = knapsack_ins;
	}

	public int getNextCandidate() {
		return next_candidate;
	}

	public void setNextCandidate(int next_candidate) {
		this.next_candidate = next_candidate;
	}

	public double[] getInsertionCost() {
		return insertion_cost;
	}

	public void setInsertionCost(double insertion_cost[]) {
		this.insertion_cost = insertion_cost;
	}

	public int getCandidateI(int i) {
		return candidates[i];
	}

	public void setCandidateI(int i, int candidates) {
		this.candidates[i] = candidates;
	}

	public int getPosCandidate() {
		return pos_candidate;
	}

	public void setPosCandidate(int pos_candidate) {
		this.pos_candidate = pos_candidate;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getRclSize() {
		return rcl_size;
	}

	public void setRclSize(int rcl_size) {
		this.rcl_size = rcl_size;
	}

	public double getGama() {
		return gama;
	}

	public void setGama(double gama) {
		this.gama = gama;
	}
	
}
