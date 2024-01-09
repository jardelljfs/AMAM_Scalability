package Local_Search_MKP;

import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Function_Package.AcceptationCriteria;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that implements the AcceptationCriteria Class.  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPLocalSearchAcceptationCriteriaFOMO implements AcceptationCriteria{

	@Override
	public boolean acceptationCriteria(Solution s1, Solution s2, Element e,
			Problem p) {
		// TODO Auto-generated method stub
		
		/*
		 * gama = 0.5
		 */
		
		double fitness_function1 = 0;
		double fitness_function2 = 0;
		
		for(int i = 0; i < p.getDimension(); i++) {
			fitness_function1 = fitness_function1 + (0.5 * s1.getObjectiveFunctionI(i));
			fitness_function2 = fitness_function2 + (0.5 * s2.getObjectiveFunctionI(i));
		}
		
		//maximization
		if(fitness_function1 > fitness_function2) {
			return true;
		}
		else {
			return false;
		}
	}

}
