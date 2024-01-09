package Cooperation;

import Environment.Problem;
import Environment.Solution;
import Environment_MKP.MKSolution;
import Methods.Method;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Solution pool class.
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPPoolSolutions extends PoolSolutions{

	public MKPPoolSolutions(int size_max, double radius_niche, Problem p, int receiver_size) {
		super(size_max, radius_niche);
		// TODO Auto-generated constructor stub
		
		for(int i = 0; i < this.getMaxSize(); i++) {
			this.setSolutionInCollection(i, new MKSolution(receiver_size, p), p);
		}
		
		this.setBestSolutionPool(new MKSolution(receiver_size, p));
	}
	
	@Override
	public int calculateDistanceBetweenSolutions(Solution s1, Solution s2,
			Problem p) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Solution getPartialSolution(int portion_size, int receiver_size,
			Problem p) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Solution getSolutionGRASP(Method construction, int portion_size,
			int receiver_size, Problem p) {
		// TODO Auto-generated method stub
		return null;
	}

}
