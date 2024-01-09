package Builder;

import Construct_PM.PMAddElement;
import Construct_PM.PMConstructElement;
import Construct_PM.PMConstructionStopCondition;
import Construct_PM.PMInitializeCandidates;
import Construct_PM.PMInitializeSolution;
import Construct_PM.PMNextCandidate;
import Construct_PM.PMUpdateCandidates;
import Construction.Construction;
import Cooperation.Cooperation;
import Environment.Problem;
import Methods.Method;
import Parameters.Parameters;

public class PMConstructionBuilder extends MethodBuilder{

	@Override
	public Method building(int id_method, Parameters parameters, Cooperation cooperation, Problem p) {
		// TODO Auto-generated method stub
		
        Construction construction = new Construction();
        
        construction.setFunctionType(parameters.getMethodParametersI(id_method).getConstrType()); //VER SE FICA OU TIRA ESSA PARTE
		
		PMInitializeSolution init_solution = new PMInitializeSolution(); 
		construction.setInitSolution(init_solution);
		
		PMInitializeCandidates init_candidates = new PMInitializeCandidates();
		construction.setInitCandidates(init_candidates);
		
		PMConstructionStopCondition condition = new PMConstructionStopCondition();
		construction.setCondition(condition);
		
		PMAddElement add = new PMAddElement();
		construction.setAdd(add);
		
		PMNextCandidate next = new PMNextCandidate(parameters.getMethodParametersI(id_method).getRclSize());
		construction.setNext(next);
		
		PMUpdateCandidates update_candidates = new PMUpdateCandidates();
		construction.setUpdateCandidates(update_candidates);
		
		PMConstructElement pm_element = new PMConstructElement(p);
		construction.setElement(pm_element);
		
		construction.setFunctionType(this.getFunctionType());

		construction.setParameters(parameters);
		
		construction.setCooperation(cooperation);
		
		return construction;
	}

}
