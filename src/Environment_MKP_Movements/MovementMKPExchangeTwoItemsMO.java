package Environment_MKP_Movements;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that extends the Movement class.
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Environment_MKP.MKSolution;
import Environment_Movements.Movement;

public class MovementMKPExchangeTwoItemsMO extends Movement{

	public MovementMKPExchangeTwoItemsMO(String move_type) {
		super(move_type);
		// TODO Auto-generated constructor stub
	}

	@Override
	public Solution movement(Solution s, int receiver_size, Element element,
			Problem p) {
		// TODO Auto-generated method stub
		
		MKSolution sol = null;
		if(s instanceof MKSolution) {
			sol = (MKSolution) s;
		}
		
		MKPMovementElement mkp_e = null;
		if(element instanceof MKPMovementElement) {
			mkp_e = (MKPMovementElement) element;
		}
		
		mkp_e.setValid(sol.exchangeTwoItemsMO(mkp_e.getItem1(), mkp_e.getItem2(), p, mkp_e.getGama()));
		
		return sol;
	}

}
