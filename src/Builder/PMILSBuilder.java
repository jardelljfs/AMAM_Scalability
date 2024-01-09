package Builder;

import Construction.Construction;
import Cooperation.Cooperation;
import Environment.Problem;
import Environment.Solution;
import Environment_PM.PMSolution;
import Function_Package.AcceptationCriteria;
import Function_Package.StopCondition;
import ILS.ILSPerturbation;
import ILS_PM.PMILSAcceptationCriteriaOF;
import ILS_PM.PMILSElement;
import ILS_PM.PMILSPerturbationInLevels;
import ILS_PM.PMILSStopConditionIterations;
import Local_Search.AdaptiveLocalSearch_QLearning;
import Local_Search.LocalSearch;
import Methods.Method;
import Parameters.Parameters;

public class PMILSBuilder extends ILSBuilder{

	@Override
	public Method building(int id_method, Parameters parameters, Cooperation cooperation, Problem p) {
		// TODO Auto-generated method stub
		
		Solution so = new PMSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		this.getIls().setSo(so);
		
		Solution s = new PMSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		this.getIls().setS(s);
		
		Solution improve_solution = new PMSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		this.getIls().setImproveSolution(improve_solution);
		
		Solution perturb_solution = new PMSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		this.getIls().setPerturbSolution(perturb_solution);
		
		Solution best_solution = new PMSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		this.getIls().setBestSolution(best_solution);
		
		PMILSElement e = new PMILSElement();
		e.setIterationsNumber(0);
		e.setMaxIterations(parameters.getMethodParametersI(id_method).getMaxIterations());   
		e.setLevelPerturb(1);
		e.setMaxLevelPerturb(parameters.getMethodParametersI(id_method).getMaxLevelsPerturbation());
		e.setMaxTime(parameters.getMethodParametersI(id_method).getMaxTime());
		
		e.setBestOF(parameters.getExperimentParameters().getBestOF());
		
		this.getIls().setElement(e);
		
		this.getIls().setParameters(parameters);
		
		Method construction = new Construction();
		construction = this.getConstructBuilder().building(id_method, parameters, cooperation, p);
		this.getIls().setConstruction(construction);

		//Method local_search = new AdaptiveLocalSearch_QLearning(); 
		Method local_search; //= new LocalSearch(); //LocalSearch();
		local_search = this.getLsBuilder().building(id_method, parameters, cooperation, p);
		this.getIls().setLocalSearch(local_search);
				
		//StopCondition condition = new PMILSStopConditionTime();
		StopCondition condition = new PMILSStopConditionIterations();
		this.getIls().setCondition(condition);
				
		ILSPerturbation perturb = new PMILSPerturbationInLevels();
		this.getIls().setPerturb(perturb);
				
		AcceptationCriteria criteria = new PMILSAcceptationCriteriaOF();
		this.getIls().setCriteria(criteria);
				
		this.getIls().setCooperation(cooperation);
		
		return this.getIls();
	}

}
