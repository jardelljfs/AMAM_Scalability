package Main;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import Cooperation.Cooperation;
import Environment.Problem;
import Environment.Solution;
import Factorys.AgentFactory;
import Factorys.SolutionFactory;
import Function_Package.WriterInFile;
import Parameters.Parameters;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that defines a Execution Main Thread.  
 * @author Maria Am�lia Lopes Silva <mamelia@ufv.br>
 **/

public class ExecutionMainThread {

	private int numActiveThreads;
	private int id_execution;	
	private Solution final_solution;
	
	public synchronized void execute(String experiment, Problem p, Parameters parameters, Cooperation cooperation, int id_execution) throws Exception{
	    
		this.numActiveThreads = 0;
		this.setId_execution(id_execution);	
		
        ArrayList<ThreadBase> listListeners = new ArrayList<ThreadBase>(2);
        
        AgentFactory agent_factory = new AgentFactory();
                
        for(int i = 0; i < parameters.getExperimentParameters().getNumberOfMethods(); i++){
        	//OUTPUT FILES
			parameters.getMethodParametersI(i).setFw(new WriterInFile("results/Results" + experiment + "-" + p.getInstanceName() + "-" + id_execution + i + ".txt"));
			parameters.getMethodParametersI(i).setFwReduced(new WriterInFile("results/Results" + experiment + "-" + p.getInstanceName() + "-" + id_execution + i + "-reduced.txt"));
			parameters.getMethodParametersI(i).setFwST(new WriterInFile("results/Results" + experiment + "-" + p.getInstanceName() + "-" + id_execution + i + "-ST.txt"));
			parameters.getMethodParametersI(i).setFwFinalTableQ(new WriterInFile("results/TableFinalQ" + experiment + "-" + p.getInstanceName() + "-" + id_execution + i + ".txt"));
        	
			listListeners.add(agent_factory.createAgent(parameters, cooperation, p, i, id_execution, this));	
        }
        
        Iterator<ThreadBase> it = listListeners.iterator();
        while (it.hasNext()) {
        	Thread thread = it.next();
        	this.numActiveThreads++;
        	thread.start();
        }        
        if (numActiveThreads > 0) this.wait(); //espera enquanto ainda tem thread executando

        //BEST SOLUTION BETWEEN ALL AGENTS
        SolutionFactory solution_factory = new SolutionFactory();
        this.final_solution = solution_factory.createSolution(parameters.getExperimentParameters().getReceiverSize(), p);
        this.final_solution.copyValuesSolution(parameters.getMethodParametersI(0).getBestMethodSolution(), p);
        for(int i = 1; i < parameters.getExperimentParameters().getNumberOfMethods(); i++) {
        	if(parameters.getExperimentParameters().getProblemTypeI(0).equals("min")) {
        		if(parameters.getMethodParametersI(i).getBestMethodSolution().getObjectiveFunctionI(0) < this.final_solution.getObjectiveFunctionI(0)) {
        			this.final_solution.copyValuesSolution(parameters.getMethodParametersI(i).getBestMethodSolution(), p);
        		}
        		else {
        			if(parameters.getMethodParametersI(i).getBestMethodSolution().getObjectiveFunctionI(0) == this.final_solution.getObjectiveFunctionI(0)) {
        				if(parameters.getMethodParametersI(i).getBestMethodSolution().getSearchTime() < this.final_solution.getSearchTime()) {
        					this.final_solution.copyValuesSolution(parameters.getMethodParametersI(i).getBestMethodSolution(), p);
        				}
        			}
        		}
        	}
        	else {
        		if(parameters.getMethodParametersI(i).getBestMethodSolution().getObjectiveFunctionI(0) > this.final_solution.getObjectiveFunctionI(0)) {
        			this.final_solution.copyValuesSolution(parameters.getMethodParametersI(i).getBestMethodSolution(), p);
        		}
        	}
        }
        
        this.final_solution.writeSolutionST(p, parameters.getExperimentParameters().getFwBestSolution());
        //Tempo final de execução 
        parameters.getExperimentParameters().getFwBestSolution().writerTextFile((System.currentTimeMillis() - parameters.getExperimentParameters().getInitialTimeExecution())/1000.0 + "");
        //parameters.getExperimentParameters().getFwBestSolution().writerTextFile(this.final_solution.getSearchTime()/1000.0 + "");
        
        try {
			cooperation.getPool().writePoolSolutionsReduce(p, parameters.getExperimentParameters().getFwPool());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        for(int i = 0; i < parameters.getExperimentParameters().getNumberOfMethods(); i++) {
	        parameters.getMethodParametersI(i).getFw().closeTextFile();
			parameters.getMethodParametersI(i).getFwReduced().closeTextFile();
			parameters.getMethodParametersI(i).getFwSt().closeTextFile();
			parameters.getMethodParametersI(i).getFwFinalTableQ().closeTextFile();
        }
        
        parameters.getExperimentParameters().getFwBestSolution().closeTextFile();
		parameters.getExperimentParameters().getFwPool().closeTextFile();
		parameters.getExperimentParameters().getFwBestSolution().closeTextFile();
		
	}
	
	public synchronized void notifyFinishThread(){
        numActiveThreads--;
        if (numActiveThreads <=0) this.notifyAll();
	}

	public int getId_execution() {
		return id_execution;
	}

	public void setId_execution(int id_execution) {
		this.id_execution = id_execution;
	}
	
}
