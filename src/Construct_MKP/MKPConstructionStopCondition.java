package Construct_MKP;

import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Environment_MKP.MKProblem;
import Environment_MKP.MKSolution;
import Function_Package.StopCondition;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that implements the StopCondition class  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPConstructionStopCondition implements StopCondition{

	@Override
	public boolean stopCondition(Element e, Problem p, Solution s) {
		// TODO Auto-generated method stub
		
		MKPConstructElement mk_e = null;
		if(e instanceof MKPConstructElement) {
			mk_e = (MKPConstructElement) e;
		}
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		MKSolution mk_sol = null;
		if(s instanceof MKSolution) {
			mk_sol = (MKSolution) s;
		}
		
		boolean capacity = true;
		for(int i = 0; i < mkp.getDimension(); i++) {
			if(mk_sol.getKnapsacks(0).getTotalWeightI(i) > mkp.getCapacity(i)) {
				capacity = false;
			}
		
		}
		
		if(!capacity) {
			//removes the last item inserted
			mk_sol.dropItemMO(mk_e.getNextCandidate(), mkp, mk_e.getGama());
			mk_e.setCount(0);
			return true;   /* hit the stop condition */
		}
		else {
			if(mk_e.getCount() < mkp.getNumberOfItems()) {
				return false;   /* not reached the stop condition */
			}
			else {
				mk_e.setCount(0);
				return true;   /* hit the stop condition */
			}
		}
	}

}
