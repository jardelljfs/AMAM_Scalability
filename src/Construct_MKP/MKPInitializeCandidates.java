package Construct_MKP;

import Construction.InitializeCandidates;
import Environment.Element;
import Environment.Problem;
import Environment_MKP.MKProblem;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that implements the InitializeCandidades class  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPInitializeCandidates implements InitializeCandidates {

	@Override
	public void initializeCandidates(Element e, Problem p) {
		// TODO Auto-generated method stub
		
		MKPConstructElement e_mk = null;
		if(e instanceof MKPConstructElement) {
			e_mk = (MKPConstructElement) e;
		}
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		for (int i = 0; i < mkp.getNumberOfItems(); i++) {
			e_mk.setCandidateI(i, i);
		}
	
		e_mk.calculateCostInsertion(e_mk.getGama(), mkp);
		e_mk.ascendingOrderItems(mkp);
		
	}
	
	

}
