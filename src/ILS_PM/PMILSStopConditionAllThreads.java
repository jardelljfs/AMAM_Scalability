package ILS_PM;

import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Environment_PM.PMSolution;
import Function_Package.StopConditionAllThreads;

public class PMILSStopConditionAllThreads implements StopConditionAllThreads{

	@Override
	public boolean stopConditionAllThreads(Element e, Problem p, Solution s) {
		// TODO Auto-generated method stub
		
		PMILSElement e_pm = null; 
		if(e instanceof PMILSElement) {
			e_pm = (PMILSElement) e;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		if(sol.getObjectiveFunctionI(0) > e_pm.getBestOF()) {
			return false;
		}
		else {
			//System.out.println("\n\nFINAL ITERATIONS: " + e_pm.getIterationsNumber() + "\n");
			return true;
		}
	}

}
