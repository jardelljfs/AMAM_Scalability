package Construct_MKP;

import Construction.UpdateCandidates;
import Environment.Element;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that implements the UpdateCandidates class  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPUpdateCandidates implements UpdateCandidates{

	@Override
	public void updateCandidates(Element e) {
		// TODO Auto-generated method stub
		
		MKPConstructElement mk_e = null;
		if(e instanceof MKPConstructElement){
			mk_e = (MKPConstructElement) e;
		}
		
		mk_e.setCandidateI(mk_e.getPosCandidate(), -1);
	}

}
