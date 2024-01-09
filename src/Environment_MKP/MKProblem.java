package Environment_MKP;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Specialized class for the Multi-objective Backpack Problem  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Random;
import java.util.StringTokenizer;

import Environment.Problem;

public class MKProblem extends Problem{

	/* ATTRIBUTES */
	private int number_of_knapsack;
	private int number_of_items;
	private int profit[][]; //item X mochila/dimensão - lucro do item i na mochila j
	private int weight[][]; //item X mochila/dimensão - peso do item i na mochila j
	private int capacity[]; //capacidade de cada mochila
	
	public MKProblem(String instance, String problem_description, String problem_type[], int dimension) throws Exception {
		
		super(instance, problem_description, problem_type, dimension);
		
		// TODO Auto-generated constructor stub
		
		this.readProblem(this.getInstanceName(), this.getDimension());
	}
	
	/* OVERRIDE */
	@Override
	public void readProblem(String instance, int dimension) throws Exception {
		// TODO Auto-generated method stub
		
		String text, c;
		FileReader file = new FileReader(this.getInstanceName() + ".txt");
		BufferedReader buffer = new BufferedReader(file);
		
		System.out.println("**MultiObjective Knapsack Problem**");
		
		String line = buffer.readLine();
		StringTokenizer token = new StringTokenizer(line," ");
		
		text = new String(token.nextToken());
		text = new String(token.nextToken());
		text = new String(token.nextToken());
		text = new String(token.nextToken());
		c = text.substring(1, 2);//charAt(1);
		this.setDimension(Integer.parseInt(c));
		text = new String(token.nextToken());
		this.setNumberOfItems(new Integer(token.nextToken()).intValue());
		
		this.profit = new int[this.getNumberOfItems()][this.getDimension()];
		this.weight = new int[this.getNumberOfItems()][this.getDimension()];
		this.capacity = new int[this.getDimension()];
		
		line = buffer.readLine( );
		for(int k = 0; k < this.getDimension(); k++) {
			line = buffer.readLine( );
			System.out.println("\n" + line + "\n");
			line = buffer.readLine( );
			System.out.println(line);
			token = new StringTokenizer(line," ");
			text = new String(token.nextToken());
			
			this.setCapacity(k, new Integer(token.nextToken()).intValue());
			
			for(int i = 0; i < this.getNumberOfItems(); i++) {
				line = buffer.readLine( );
				System.out.println(line);
				
				line = buffer.readLine( );
				System.out.println(line);
				token = new StringTokenizer(line," ");
				text = new String(token.nextToken());
				this.setWeight(k, i, new Integer(token.nextToken()).intValue());
				
				line = buffer.readLine( );
				System.out.println(line);
				token = new StringTokenizer(line," ");
				text = new String(token.nextToken());
				this.setProfitI(k, i, new Integer(token.nextToken()).intValue());
			}
			line = buffer.readLine( );
		}
		
		buffer.close();
		
		this.setNumberOfKnapsack(1); //PROBLEMA MULTIOBJETIVO - vários objetivos, só uma mochila
	}

	@Override
	public void copyValuesProblem(Problem p) {
		// TODO Auto-generated method stub
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		this.setNumberOfItems(mkp.getNumberOfItems());
		this.setNumberOfKnapsack(mkp.getNumberOfKnapsack());
		this.setInstanceName(mkp.getInstanceName());
		this.setProblemDescription(mkp.getProblemDescription());
		this.setDimension(mkp.getDimension());
		
		for(int k = 0; k < this.getDimension(); k++) {
			this.setCapacity(k, mkp.getCapacity(k));
			for(int i = 0; i < this.getNumberOfItems(); i++) {
				this.setProfitI(k, i, mkp.getProfitIJ(k, i));
				this.setWeight(k, i, mkp.getWeight(k, i));
			}
		}
	}
	
	public int randomItem() {
		int item;
		
		Random generator = new Random();
		item = generator.nextInt(this.getNumberOfItems());
		
		return item;
	}

	@Override
	public void showProblem() {
		// TODO Auto-generated method stub
		
		/*IMPLEMENTADO NO READ PROBLEM*/
		
	}
	
	/* SETS AND GETS */
	public int getNumberOfKnapsack() {
		return number_of_knapsack;
	}

	public void setNumberOfKnapsack(int number_of_knapsack) {
		this.number_of_knapsack = number_of_knapsack;
	}
	
	public int getNumberOfItems() {
		return number_of_items;
	}

	public void setNumberOfItems(int number_of_items) {
		this.number_of_items = number_of_items;
	}

	public int getProfitIJ(int k, int i) {
		return profit[i][k];
	}

	public void setProfitI(int k, int i, int profit) {
		this.profit[i][k] = profit;
	}

	public int getWeight(int k, int i) {
		return weight[i][k];
	}

	public void setWeight(int k, int i, int weight) {
		this.weight[i][k] = weight;
	}

	public int getCapacity(int j) {
		return capacity[j];
	}

	public void setCapacity(int j, int capacity) {
		this.capacity[j] = capacity;
	}

}
