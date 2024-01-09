package Construct_MKP;

import Construction.InitializeSolution;
import Environment.Problem;
import Environment.Solution;
import Environment_MKP.MKProblem;
import Environment_MKP.MKSolution;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that implements the InitializeSolution class  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPInitializeSolution implements InitializeSolution{

	@Override
	public Solution initializeSolution(Problem p, int receiver_size) {
		// TODO Auto-generated method stub
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		MKSolution initial_solution = new MKSolution(receiver_size, mkp);
		
		return initial_solution;
	}

}
