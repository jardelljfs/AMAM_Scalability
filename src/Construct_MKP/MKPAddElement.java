package Construct_MKP;

import Construction.AddElement;
import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Environment_MKP.MKSolution;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that implements the AddElement class  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPAddElement implements AddElement{

	@Override
	public void addElementInSolution(Solution s, Element e, Problem p) {
		// TODO Auto-generated method stub
		
		MKSolution mk_sol = null;
		if(s instanceof MKSolution) {
			mk_sol = (MKSolution) s;
		}
		
		MKPConstructElement mk_e = null;
		if(e instanceof MKPConstructElement) {
			mk_e = (MKPConstructElement) e;
		}
		
		mk_sol.addItemMO(mk_e.getNextCandidate(), p, mk_e.getGama()); //update of, weight, items_number
		mk_e.addCount();
		
	}

}
