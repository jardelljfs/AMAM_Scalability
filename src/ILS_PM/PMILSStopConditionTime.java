package ILS_PM;

import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Environment_PM.PMSolution;
import Function_Package.StopCondition;

public class PMILSStopConditionTime implements StopCondition{

	@Override
	public boolean stopCondition(Element e, Problem p, Solution s) {
		// TODO Auto-generated method stub
		
		PMILSElement e_pm = null; 
		if(e instanceof PMILSElement) {
			e_pm = (PMILSElement) e;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		e_pm.addIterationsNumber();
		
		long final_time = System.currentTimeMillis();
		long total_time = final_time - e_pm.getInitialTime();
		
		total_time = total_time/1000;
		if((total_time) < e_pm.getMaxTime()) { //MaxTime in seconds
		//if(e_pm.getIterationsNumber() <= e_pm.getMaxIterations()){ //|| (s.getCostWithoutPenalty() <= e_pm.getBestOf())) {
			//return true;
			if(sol.getCostWithoutPenalty() > e_pm.getBestOF()) {
				return true;
			}
			else {
				//System.out.println("\n\nFINAL ITERATIONS: " + e_pm.getIterationsNumber() + "\n");
				return false;
			}
		}
		else {
			//System.out.println("\n\nFINAL ITERATIONS: " + e_pm.getIterationsNumber() + "\n");
			return false;
		}
	}

}
