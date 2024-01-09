package Environment_MKP_Movements;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that extends the Element class  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

import Environment.Element;

public class MKPMovementElement extends Element{
	
	private int item1;
	private int position_item1;
	private int item2;
	private int position_item2;
	private int knapsack1;
	private int knapsack2;
	
	private boolean valid;
	
	private double gama;
	
	public MKPMovementElement() {
		super(0);
		// TODO Auto-generated constructor stub
	}
	
	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	public int getItem1() {
		return item1;
	}

	public void setItem1(int item1) {
		this.item1 = item1;
	}

	public int getPositionItem1() {
		return position_item1;
	}

	public void setPositionItem1(int position_item1) {
		this.position_item1 = position_item1;
	}

	public int getItem2() {
		return item2;
	}

	public void setItem2(int item2) {
		this.item2 = item2;
	}

	public int getPositionItem2() {
		return position_item2;
	}

	public void setPositionItem2(int position_item2) {
		this.position_item2 = position_item2;
	}

	public int getKnapsack1() {
		return knapsack1;
	}

	public void setKnapsack1(int knapsack1) {
		this.knapsack1 = knapsack1;
	}

	public int getKnapsack2() {
		return knapsack2;
	}

	public void setKnapsack2(int knapsack2) {
		this.knapsack2 = knapsack2;
	}

	public double getGama() {
		return gama;
	}

	public void setGama(double gama) {
		this.gama = gama;
	}

}
