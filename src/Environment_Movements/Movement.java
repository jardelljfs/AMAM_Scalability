package Environment_Movements;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Abstract class that defines the moviment model for optimization problems in AMAM  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

import Environment.Element;
import Environment.Problem;
import Environment.Solution;

public abstract class Movement {
	
	private String move_type;
	
	public Movement(String move_type) {
		this.move_type = move_type;
	}
	
	public abstract Solution movement(Solution s, int receiver_size, Element element, Problem p);

	public String getMoveType() {
		return move_type;
	}

	public void setMoveType(String move_type) {
		this.move_type = move_type;
	}

}
