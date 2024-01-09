package Reinforcement_Learning;

import java.util.Random;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Elements of Reinforcement Learning.  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class ReinforcementLearning_Old {

	private double experience_reinforce[][]; //w(i,j) = w(i,j) + reinforcement
	//private double reinforcement_factor1; //the agent improves its best found solution
	//private double reinforcement_factor2; //the agent improves the best know solution 
	
	private double roulette[];
	private double roulette_total;
	private double total[];
	private double fraction_roulette[];
	private double weight;
	private int k;
	private int k_1;
	private int max_size_roulette;
	
	private double epsilon;
	
	public ReinforcementLearning_Old(int max, double epsilon) {
		
		double aux;
		
		this.roulette_total = 100;
		this.epsilon = epsilon;
		
		this.setTotal(new double[max]);
		for(int i = 0; i < max; i++) {
			this.total[i] = 100;
		}
		
		double percentage = this.roulette_total/(max); //antes max-1
		this.setMaxSizeRoulette(max);
		
		this.setRoulette(new double[max]);
		this.setFractionRoulette(new double[max]);
		
		for(int i = 0; i < max; i++) {
			aux = (percentage * (i+1));
			this.setRouletteI(i, aux);
			this.setFractionRouletteI(percentage, i);
		}
		
		this.setExperienceReinforce(new double[max][max]);
		
		for(int i = 0; i < max; i++) {
			for(int j = 0; j < max; j++) {
				if(i != j){
					if(j < i) 
						aux = (percentage * (j+1));
					else
						aux = (percentage * (j));
				}
				else
					if(j == 0)
						aux = 0;
					else
						aux = this.getExperienceReinforceIJ(i, j-1);
				this.setExperienceReinforceIJ(aux, i, j);
			}
		}
		
		this.weight = this.getRouletteTotal() * 0.05; // 5% do total inicial
	}
	
	public void updateExperienceReinforce(int i, int j) {
	
		this.setTotalI(this.getRouletteTotal() + this.getWeight(), i);
		
		for(int l = j; l < this.getMaxSizeRoulette(); l++) {
			this.setExperienceReinforceIJ((this.getExperienceReinforceIJ(i, l) + this.getWeight()), i, l);
		}
		
	}
	
	public void updateRoulette(int i) {
		//atualizando a fração do elemento i da roleta
		this.fraction_roulette[i] = this.fraction_roulette[i] + this.getWeight();
		
		double below = 0;
		int cont = 0;
		for(int j = 0; j < this.getMaxSizeRoulette(); j++) {
			if(j != i) {
				if(fraction_roulette[j] < 5) {   //a probabilidade mínima é 5
					cont++;
					below = below + fraction_roulette[j];
				}
			}
		}
		
		if(!(fraction_roulette[i] + below > 100)) { 
		
			double sub = this.getWeight() / (this.max_size_roulette - 1 - cont); // retira dos demais o que foi dado a vizinhança i
		
			//atualizando a fração dos demais elementos em função de i
			for(int j = 0; j < this.getMaxSizeRoulette(); j++) {
				if(!(fraction_roulette[j] < 5)) {
					if(j != i) {
						fraction_roulette[j] = fraction_roulette[j] - sub;
					}
				}
				//atualizo a roleta com as novas frações
				if(j == 0) {
	 				this.roulette[j] = fraction_roulette[j];
				}
				else {
					this.roulette[j] = roulette[j-1] + fraction_roulette[j];
				}
			}
		}
		else
			this.fraction_roulette[i] = this.fraction_roulette[i] - this.getWeight();
		
	}
	
	public void decreasesReinforcement(int i) {
		//atualizando a fração do elemento i da roleta
		
		if(!(this.fraction_roulette[i] < this.getWeight())) {
			
			this.fraction_roulette[i] = this.fraction_roulette[i] - this.getWeight();
			double test = 0;
			for(int j = 0; j < this.getMaxSizeRoulette(); j++) {
				test = test + this.fraction_roulette[j];
			}
			double sum = this.getWeight() / (this.max_size_roulette - 1); // devolve aos demais o que foi dado a vizinhança i
			
			//atualizando a fração dos demais elementos em função de i
			for(int j = 0; j < this.getMaxSizeRoulette(); j++) {
				if(j != i) {
					fraction_roulette[j] = fraction_roulette[j] + sum;
				}
				//atualizo a roleta com as novas frações
				if(j == 0) {
	 				this.roulette[j] = fraction_roulette[j];
				}
				else {
					this.roulette[j] = roulette[j-1] + fraction_roulette[j];
				}
			}
		}
	}
	
	public int rouletteWheelRL(int i) {
		
		Random generator = new Random();
		
		double value_rl;
		
		value_rl = generator.nextFloat() * this.getTotalI(i);
		
		int pos = 0;
		int j = 0;
		while (this.experience_reinforce[i][j] <= value_rl) {
			pos = j + 1;
			j++;
		}
		return pos;
	
	}
	
	//roleta russa no vetor
	public int rouletteWheel() {
		
		Random generator = new Random();
		
		double value_roulette;
		
		value_roulette = generator.nextFloat() * this.getRouletteTotal();
		//System.out.println("Roulette!");
		int pos = 0;
		int i = 0;
		while (roulette[i] <= value_roulette) {
			i++;
			pos = i;
			if(i == 8)
				System.out.println("aqui");
		}
		return pos;
	
	}
	
	//roleta russa no vetor
	public int maxRoulette() {
		
		double max_roulette = fraction_roulette[0];
		int pos = 0;
		//System.out.println("Max Roulette!");
		for(int i = 1; i < this.getMaxSizeRoulette(); i++) {
			if(fraction_roulette[i] > max_roulette) {
				max_roulette = fraction_roulette[i];
				pos = i;
			}
		}
		return pos;
	}
	
	//Desta forma não vai chamar epsilon greedy
	public int epsilonGreedyAL(int no_improvement) {
		int action;
		//Random generator = new Random();
		//double random = generator.nextDouble();
		//if(random <= this.epsilon) {
		if(no_improvement != 0) {
			action = this.rouletteWheel();
		}
		else{
			action = maxRoulette();
		}
		return action;
	}
	
	public double[] getRoulette() {
		return roulette;
	}

	public void setRoulette(double roulette[]) {
		this.roulette = roulette;
	}
	
	public double getRouletteI(int i) {
		return roulette[i];
	}

	public void setRouletteI(int i, double value) {
		this.roulette[i] = value;
	}

	public double[][] getExperienceReinforce() {
		return experience_reinforce;
	}

	public void setExperienceReinforce(double experience_reinforce[][]) {
		this.experience_reinforce = experience_reinforce;
	}

	public double getExperienceReinforceIJ(int i, int j) {
		return experience_reinforce[i][j];
	}

	public void setExperienceReinforceIJ(double reinforce, int i, int j) {
		this.experience_reinforce[i][j] = reinforce;
	}

	public double[] getFractionRoulette() {
		return fraction_roulette;
	}

	public void setFractionRoulette(double fraction_roulette[]) {
		this.fraction_roulette = fraction_roulette;
	}
	
	public double getFractionRouletteI(int i) {
		return fraction_roulette[i];
	}

	public void setFractionRouletteI(double fraction, int i) {
		this.fraction_roulette[i] = fraction;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public double getRouletteTotal() {
		return roulette_total;
	}

	public void setRouletteTotal(double routette_total) {
		this.roulette_total = routette_total;
	}

	public int getK() {
		return k;
	}

	public void setK(int k) {
		this.k = k;
	}

	public int getMaxSizeRoulette() {
		return max_size_roulette;
	}

	public void setMaxSizeRoulette(int max_roulette) {
		this.max_size_roulette = max_roulette;
	}

	public int getK_1() {
		return k_1;
	}

	public void setK_1(int k_1) {
		this.k_1 = k_1;
	}

	public double[] getTotal() {
		return total;
	}

	public void setTotal(double total[]) {
		this.total = total;
	}
	
	public double getTotalI(int i) {
		return total[i];
	}

	public void setTotalI(double total, int i) {
		this.total[i] = total;
	}
	
}
