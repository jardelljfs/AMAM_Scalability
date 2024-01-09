package VNS;

import Cooperation.Cooperation;
import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Parameters.Parameters;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2019 Silva, M.A.L.
 * Function: One of the elements of a ILS Method. Used by Design Pattern Builder.  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public interface VNSGeneratesNeighbor {
	
	public abstract Solution generatesNeighbor(int k, Solution s, Element e, int id_agent, Cooperation cooperation, Parameters parameters, Problem p);

}
