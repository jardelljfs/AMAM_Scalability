package Environment_Movements;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class responsible for defining set of moviment.  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MovementList {

	private Movement list[];
	private int count;

	public MovementList(int list_size) {
		this.list = new Movement[list_size];
	}
	
	public Movement[] getList() {
		return list;
	}

	public void setList(Movement list[]) {
		this.list = list;
	}
	
	public void addMovementI(Movement move) {
		this.list[count] = move;
		count++;
	}
	
	public Movement getMoveI(int i) {
		return list[i];
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
}
