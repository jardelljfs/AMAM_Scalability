package Builder;

import Cooperation.Cooperation;
import Environment.Problem;
import Environment.Solution;
import Environment_PM.PMSolution;
import Environment_PM_Movements.PMMovementElement;
import Local_Search.LocalSearch_AdaptiveBRACIS2015;
import Local_Search.MoveNeighborhood;
import Local_Search_PM.PMBestNeighborCompleteDescent;
import Local_Search_PM.PMLocalSearchAcceptationCriteriaOF;
import Methods.Method;
import Parameters.Parameters;
import Reinforcement_Learning.ReinforcementLearning_Old;

public class PMAdaptiveLocalSearchBuilder_OLD extends MethodBuilder{

	@Override
	public Method building(int id_method, Parameters parameters, Cooperation cooperation, Problem p) {
		// TODO Auto-generated method stub
		
		//AdaptiveLocalSearch_QLearning ls = new AdaptiveLocalSearch_QLearning();
		LocalSearch_AdaptiveBRACIS2015 ls = new LocalSearch_AdaptiveBRACIS2015();

		//inicializa as soluções da busca local
		Solution s1 = new PMSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		ls.setS(s1);
		Solution s2 = new PMSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		ls.setBestSolution(s2);
		Solution s4 = new PMSolution(parameters.getExperimentParameters().getReceiverSize(), p);
		ls.setS_line(s4);
		
		ls.setNeighborhoodSize(parameters.getMethodParametersI(id_method).getNeighborhoodSize());
		ls.setFunctionType(this.getFunctionType());
		
		ls.setParameters(parameters);
		
		ls.setCooperation(cooperation);
		
		ReinforcementLearning_Old rl_ls = new ReinforcementLearning_Old(parameters.getMethodParametersI(id_method).getNeighborhoodSize(), parameters.getMethodParametersI(id_method).getQLearning().getEpsilon());
		ls.setReinforcementLearning(rl_ls);
		
		switch (this.getFunctionType()) {
			case "adaptive_vnd_complete":	
				PMLocalSearchAcceptationCriteriaOF pm_criteria = new PMLocalSearchAcceptationCriteriaOF();
				ls.setCriteria(pm_criteria);
						
				PMBestNeighborCompleteDescent best_neighbor = new PMBestNeighborCompleteDescent();
				ls.setBestNeighbor(best_neighbor);
						
				MoveNeighborhood move_neighborhood = new MoveNeighborhood(parameters.getMethodParametersI(id_method).getNeighborhoodSize());
				for (int i = 0; i < parameters.getMethodParametersI(id_method).getNeighborhoodSize(); i++) {
					move_neighborhood.getList().addMovementI(parameters.getMethodParametersI(id_method).getMovementList().getMoveI(i));
				}
				ls.setMovementNeighborhood(move_neighborhood);
						
				PMMovementElement pm_element = new PMMovementElement();
				ls.setElement(pm_element);
				break;
				
			case "adaptive_vnd_old":	
				pm_criteria = new PMLocalSearchAcceptationCriteriaOF();
				ls.setCriteria(pm_criteria);
						
				best_neighbor = new PMBestNeighborCompleteDescent();
				ls.setBestNeighbor(best_neighbor);
						
				move_neighborhood = new MoveNeighborhood(parameters.getMethodParametersI(id_method).getNeighborhoodSize());
				for (int i = 0; i < parameters.getMethodParametersI(id_method).getNeighborhoodSize(); i++) {
					move_neighborhood.getList().addMovementI(parameters.getMethodParametersI(id_method).getMovementList().getMoveI(i));
				}
				ls.setMovementNeighborhood(move_neighborhood);
						
				pm_element = new PMMovementElement();
				ls.setElement(pm_element);
				break;
				
			case "local_search_vnd":
				pm_criteria = new PMLocalSearchAcceptationCriteriaOF();
				ls.setCriteria(pm_criteria);
						
				best_neighbor = new PMBestNeighborCompleteDescent();
				ls.setBestNeighbor(best_neighbor);
						
				move_neighborhood = new MoveNeighborhood(parameters.getMethodParametersI(id_method).getNeighborhoodSize());
				for (int i = 0; i < parameters.getMethodParametersI(id_method).getNeighborhoodSize(); i++) {
					move_neighborhood.getList().addMovementI(parameters.getMethodParametersI(id_method).getMovementList().getMoveI(i));
				}
				ls.setMovementNeighborhood(move_neighborhood);
						
				pm_element = new PMMovementElement();
				ls.setElement(pm_element);
				break; 
			
			default:
				System.out.println("\nTipo de Busca Local não disponível!");
				break;
		}
		
		return ls;
	}

}
