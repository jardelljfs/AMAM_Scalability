package Environment_PM;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Specialized class for the Solution of the Parallel Machines Problem  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

import java.io.IOException;

import Construct_PM.PMConstructElement;
import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Function_Package.WriterInFile;

public class PMSolution extends Solution{

	private Machine machines[];
	private int machine_number;
	
	public PMSolution(int receiver_size, Problem p) {
		super(receiver_size, p.getDimension());	
		// TODO Auto-generated constructor stub
		
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		this.machine_number = pm.getMachinesNumber();
		//RETIRAR
		this.machines = new Machine[pm.getMachinesNumber()];
		for(int i = 0; i < pm.getMachinesNumber(); i++) {
			this.machines[i] = new Machine(pm.getNumberOfTasks());
		}
	}
		
	/* OVERRIDE METHODS */
	@Override
	/* Description: o valor da função objetivo é o tempo da máquina que conclui as tarefas
	 * em maior tempo
	 */
	public void calculateObjectiveFunction(Problem p) {
		// TODO Auto-generated method stub
		
		PMProblem pm = null;
		if(p instanceof PMProblem){
			pm = (PMProblem) p;
		}
		
		int makespan = this.machines[0].getTotalTime();
		
		for(int i = 1; i < pm.getMachinesNumber(); i++) {
			if(this.machines[i].getTotalTime() > makespan) {
				makespan = this.machines[i].getTotalTime();
			}
		}
		this.setObjectiveFunctionI(0, makespan);
	}
	
	public int searchMakespanMachine(Problem p) {
		// TODO Auto-generated method stub
		
		PMProblem pm = null;
		if(p instanceof PMProblem){
			pm = (PMProblem) p;
		}
		
		int makespan = this.machines[0].getTotalTime();
		int i_makespan = 0;
		
		for(int i = 1; i < pm.getMachinesNumber(); i++) {
			if(this.machines[i].getTotalTime() > makespan) {
				makespan = this.machines[i].getTotalTime();
				i_makespan = i;
			}
		}
		return i_makespan;
	}
	
	@Override
	public void calculateFitnessFunction(double gama, Problem p) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void copyValuesSolution(Solution s, Problem p) {
		// TODO Auto-generated method stub
		PMSolution pm_sol = null;
		if(s instanceof PMSolution){
			pm_sol = (PMSolution) s;
		}
		
		PMProblem pm = null;
		if(p instanceof PMProblem){
			pm = (PMProblem) p;
		}
		
		for(int i = 0; i < p.getDimension(); i++) {
			this.setObjectiveFunctionI(i, pm_sol.getObjectiveFunctionI(i));
		}
		this.setCostWithoutPenalty(pm_sol.getCostWithoutPenalty());
		this.setFitnessFunction(pm_sol.getFitnessFunction());
		this.setFitnessLearning(pm_sol.getFitnessLearning());
		this.getSender().copyValuesSender(pm_sol.getSender());
		this.getReceiver().copyValuesReceiver(pm_sol.getReceiver());
		this.setSearchTime(pm_sol.getSearchTime());
		
		for(int i = 0; i < p.getDimension(); i++) {
			this.setObjectiveFunctionI(i, pm_sol.getObjectiveFunctionI(i));
		}
		for(int i = 0; i < pm.getMachinesNumber(); i++) {
			this.machines[i].copyValuesMachine(pm_sol.machines[i]);
		}
	}

	@Override
	public void showSolution(Problem p) {
		// TODO Auto-generated method stub
		
		PMProblem pm = null;
		if(p instanceof PMProblem){
			pm = (PMProblem) p;
		}
		
		System.out.println("\n\n**SOLUTION**");
		for(int i = 0; i < p.getDimension(); i++) {
			System.out.print("Objective Function: " + this.getObjectiveFunctionI(i));
		}
		for(int i = 0; i < pm.getMachinesNumber(); i++) {
			System.out.println("\nMachine " + i);
			this.machines[i].showMachine();
		}
		System.out.print("\nSearch Time: " + this.getSearchTime());
	}
	
	@Override
	public void showOFAndFitness(Problem p) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void writeSolution(Problem p, WriterInFile fw) throws IOException{
		// TODO Auto-generated method stub
		PMProblem pm = null;
		if(p instanceof PMProblem){
			pm = (PMProblem) p;
		}
		
		fw.writerTextFile("\n\n**SOLUTION**");
		for(int i = 0; i < p.getDimension(); i++) {
			fw.writerTextFile("Objective Function: " + this.getObjectiveFunctionI(i));
		}
		fw.writerTextFile("Cost Without Penalty: " + this.getCostWithoutPenalty());
		fw.writerTextFile("Fitness Function: " + this.getFitnessFunction());
		fw.writerTextFile("Sender:\nid: " + this.getSender().getIdSender() + " - time: " + this.getSender().getTimeSender()/1000.0 + "s");
		fw.writerTextFile("Receiver: ");
		for(int i = 0; i < pm.getMachinesNumber(); i++) {
			fw.writerTextFile("\nMachine " + i);
			this.machines[i].writeMachine(fw);
		}
	}

	@Override
	public void writeReduceSolution(Problem p, WriterInFile fw) throws IOException{
		// TODO Auto-generated method stub
		fw.writerTextFile("\n\n**SOLUTION**");
		for(int i = 0; i < p.getDimension(); i++) {
			fw.writerTextFile("Objective Function: " + this.getObjectiveFunctionI(i));
		}
		fw.writerTextFile("Sender:\nid: " + this.getSender().getIdSender() + " - time: " + this.getSender().getTimeSender()/1000.0 + "s");
		fw.writerTextFile("Receiver: ");
		for(int i = 0; i < this.getReceiver().getSize(); i++) {
			fw.writerTextFile("id: " + this.getReceiver().getIdReceiverI(i) + " - time: " + this.getReceiver().getTimeReceiverI(i)/1000.0 + "s");
		}
	}
	
	@Override
	public void writeSolutionST(Problem p, WriterInFile fw) throws IOException {
		// TODO Auto-generated method stub
		//fw.writerTextFile("\n\n**SOLUTION**");
		for(int i = 0; i < p.getDimension(); i++) {
			fw.writerTextFile(this.getObjectiveFunctionI(i) + "");
		}
		fw.writerTextFile("Cost Without Penalty: " + this.getCostWithoutPenalty());
		fw.writerTextFile("Fitness Function: " + this.getFitnessFunction());
		fw.writerTextFile("Sender:\nid: " + this.getSender().getIdSender() + " - time: " + this.getSender().getTimeSender()/1000.0 + "s");
		fw.writerTextFile("Receiver: ");
		for(int i = 0; i < this.getReceiver().getSize(); i++) {
			fw.writerTextFile("id: " + this.getReceiver().getIdReceiverI(i) + " - time: " + this.getReceiver().getTimeReceiverI(i)/1000.0 + "s");
		}
		fw.writerTextFile(this.getSearchTime()/1000.0 + "");
	}

	//Insere no final da lista de tarefas da máquina
	public void insertTaskInSolutionInLast(int task, int machine, Problem p) {
		
		PMProblem pm = null;
		if(p instanceof PMProblem){
			pm = (PMProblem) p;
		}
		
		int previous_task;
		int setup_time, processing_time;
		
		this.machines[machine].setTasksInMachine(task, this.machines[machine].getTasksNumber());
		
		//updated total time
		if(this.machines[machine].getTasksNumber() == 0) 
			this.machines[machine].setTotalTime(pm.getProcessingTime(task, machine));
		else {
			previous_task = this.machines[machine].getTasksInMachine(this.machines[machine].getTasksNumber() - 1);
			setup_time = pm.getSetupTime(machine, previous_task, task);
			processing_time = pm.getProcessingTime(task, machine);
			this.machines[machine].setTotalTime(this.machines[machine].getTotalTime() + processing_time + setup_time);
		}
		
		this.machines[machine].setTasksNumber(this.machines[machine].getTasksNumber() + 1);
	}
	
	public void insertTaskInSolutionInPosition(int task, int position, int machine, Problem p) {
		
		PMProblem pm = null;
		if(p instanceof PMProblem){
			pm = (PMProblem) p;
		}
		
		int previous_task = 0, next_task;
		int setup_time = 0, processing_time = 0;
		int time_sum = 0;
		int time_sub = 0;
		
		if(position != 0) {
			previous_task = this.machines[machine].getTasksInMachine(position-1);
		}
		
		next_task = this.machines[machine].getTasksInMachine(position);
		if((position < this.machines[machine].getTasksNumber()) && (position != 0)) {
			time_sub = pm.getSetupTime(machine, previous_task , next_task);
		}
		
		int i = this.machines[machine].getTasksNumber();
		if(i == -1)
			System.out.println("Teste");
		while(i > position){
			i--;
			if(i == -1)
				System.out.println("Teste é");
			this.machines[machine].setTasksInMachine(this.machines[machine].getTasksInMachine(i), i+1);
		}
		this.machines[machine].setTasksInMachine(task, i);
		
		//updated total time
		if(this.machines[machine].getTasksNumber() == 0) 
			this.machines[machine].setTotalTime(pm.getProcessingTime(task, machine));
		else {
			if(position != 0) {
				setup_time = pm.getSetupTime(machine, previous_task, task);
			}
			if(position < this.machines[machine].getTasksNumber()) {
				setup_time = setup_time + pm.getSetupTime(machine, task, next_task);
			}
			processing_time = pm.getProcessingTime(task, machine);
			time_sum = setup_time + processing_time;
			this.machines[machine].setTotalTime(this.machines[machine].getTotalTime() + time_sum - time_sub);
		}
		
		this.machines[machine].setTasksNumber(this.machines[machine].getTasksNumber() + 1);
	}
	
	public int searchTask(int task, int machine[], int pos[]) {
		
		for(int i = 0; i < this.machine_number; i++) {
			for(int j = 0; j < this.machines[i].getTasksNumber(); j++) {
				if(this.machines[i].getTasksInMachine(j) == task) {
					machine[0] = i;
					pos[0] = j;
					return 1;
				}
			}
		}
		return 0;
	}
	
	/* remove known task */
	public void removeTaskInSolution(int machine, int position, Problem p) {
		
		int task = this.getTaskInMachines(machine, position);
		
		PMProblem pm = null;
		if (p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		int processing_time, previous_task, next_task;
		int setup_time1 = 0, setup_time2 = 0;
		
		processing_time = pm.getProcessingTime(task, machine);
		
		if(this.getMachineI(machine).getTasksNumber() == 0)
			System.out.println("AQUI");
		
		if (this.machines[machine].getTasksNumber() != 1) {
			if (position  == 0) {
				next_task = this.machines[machine].getTasksInMachine(position + 1);
				setup_time1 = pm.getSetupTime(machine, task, next_task);
			}
			else {
				if (position == (this.machines[machine].getTasksNumber() - 1)) {
					previous_task = this.machines[machine].getTasksInMachine(position - 1);
					setup_time1 = pm.getSetupTime(machine, previous_task, task);
				}
				else {
					previous_task = this.machines[machine].getTasksInMachine(position - 1);
					next_task = this.machines[machine].getTasksInMachine(position + 1);
					setup_time1 = pm.getSetupTime(machine, previous_task, task) + pm.getSetupTime(machine, task, next_task);
					setup_time2 = pm.getSetupTime(machine, previous_task, next_task);
				}
			}
			
			for(int i = position; i < this.machines[machine].getTasksNumber()-1; i++) {
				this.machines[machine].setTasksInMachine(this.machines[machine].getTasksInMachine(i+1), i);
			}
		}
		
		this.machines[machine].setTotalTime(this.machines[machine].getTotalTime() - processing_time - setup_time1 + setup_time2);
		this.machines[machine].setTasksNumber(this.machines[machine].getTasksNumber() - 1);
	}
	
	
	//shift on two machine (only one task)
	public boolean shiftPMInter(int pos_task1, int machine1, int pos_task2, int machine2, PMProblem p) {
		
		int task1 = this.getTaskInMachines(machine1, pos_task1);
		
		//Remove
		this.removeTaskInSolution(machine1, pos_task1, p);
		
		//Insertion
		this.insertTaskInSolutionInPosition(task1, pos_task2, machine2, p);
		
		//Update objective function
		this.calculateObjectiveFunction(p);
		
		return true;
	}
	
	//shift on the same machine (only one task)
	public boolean shiftPMIntra(int pos_task1, int machine1, int pos_task2, PMProblem p) {
		
		int task1 = this.getTaskInMachines(machine1, pos_task1);
		
		if(pos_task1 != pos_task2) {
			//Remove
			this.removeTaskInSolution(machine1, pos_task1, p);
		
			//Insertion
			this.insertTaskInSolutionInPosition(task1, pos_task2, machine1, p);
		
			//Update objective function
			this.calculateObjectiveFunction(p);
		}
		
		return true;
	}
	
	//swap on two machine (only one task)
	public boolean swapPMInter(int pos_task1, int machine1, int pos_task2, int machine2, PMProblem p) {
		
		int task1 = this.getTaskInMachines(machine1, pos_task1);
		int task2 = this.getTaskInMachines(machine2, pos_task2);
				
		//Remove
		this.removeTaskInSolution(machine1, pos_task1, p);
		this.removeTaskInSolution(machine2, pos_task2, p);
		
		//Insertion
		this.insertTaskInSolutionInPosition(task1, pos_task2, machine2, p);
		this.insertTaskInSolutionInPosition(task2, pos_task1, machine1, p);
				
		//Update objective function
		this.calculateObjectiveFunction(p);
		
		return true;
	}
	
	//swap on the same machine (only one task)
	public boolean swapPMIntra(int pos_task1, int machine1, int pos_task2, PMProblem p) {
		
		int task1 = this.getTaskInMachines(machine1, pos_task1);
		int task2 = this.getTaskInMachines(machine1, pos_task2);
		
		if(pos_task1 != pos_task2) {
			//Remove
			this.removeTaskInSolution(machine1, pos_task1, p);
			if(pos_task1 < pos_task2)
				pos_task2--;
			this.removeTaskInSolution(machine1, pos_task2, p);
		
			//Insertion
			if(pos_task1 < pos_task2) {
				this.insertTaskInSolutionInPosition(task2, pos_task1, machine1, p);
				pos_task2++;
				this.insertTaskInSolutionInPosition(task1, pos_task2, machine1, p);
			}
			else {
				this.insertTaskInSolutionInPosition(task1, pos_task2, machine1, p);
				this.insertTaskInSolutionInPosition(task2, pos_task1, machine1, p);
			}
				
			//Update objective function
			this.calculateObjectiveFunction(p);
		}
			
		return true;
	}
	
	public void testBetterTaskPositionGreedyRandom(Solution s, Element e, Problem p, int receiver_size) {
		
		PMConstructElement pm_e = null;
		if(e instanceof PMConstructElement) {
			pm_e = (PMConstructElement) e;
		}
		
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		int pos;
		int machines[] = new int[pm_e.getRclSize()]; 
		int candidates[] = new int[pm_e.getRclSize()]; 
		
		PMConstructElement pm_e_aux = new PMConstructElement(p);
		pm_e_aux.copyValues(pm_e, p);
		
		int total = pm.getNumberOfTasks() - pm_e.getCount();
		
		int i = 0;
		int j = 1;
		while((i < pm_e.getRclSize()) && (j <= total)) {
			this.testBetterTaskPositionForConstruction(s, pm_e_aux, p, receiver_size);
			machines[i] = pm_e_aux.getMachineIns();
			candidates[i] = pm_e_aux.getNextCandidate();
			pm_e_aux.setCandidateI(-1, pm_e_aux.getNextCandidate());
			i++;
			j++;
		}
		
		pos = (int)(Math.random() * i);
		
		pm_e.setMachineIns(machines[pos]);
		pm_e.setNextCandidate(candidates[pos]);
		
	}
	
	//checks the best position for all candidates and returns the next candidate
	//BEST CANDIDATE
	public void testBetterTaskPositionForConstruction(Solution s, Element e, Problem p, int receiver_size) {
		
		PMSolution s_line = new PMSolution(receiver_size, p);
		PMSolution best_solution = new PMSolution(receiver_size, p);
		
		int best_machine = 0, best_task = 0, best_machine_task;
		int best_time_cand = -1;
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMConstructElement pm_e = null;
		if(e instanceof PMConstructElement) {
			pm_e = (PMConstructElement) e;
		}
		
		for(int i = 0; i < pm.getNumberOfTasks(); i++) { //verifica todos os candidatos
			
			if(pm_e.getCandidateI(i) != -1) {  //-1 = candidate already used 
			
				best_machine_task = -1;
				
				for(int j = 0; j < pm.getMachinesNumber(); j++) {
					for(int k = 0; k < sol.getMachineI(j).getTasksNumber()+1; k++) {
					
						s_line.copyValuesSolution(sol, p);
						s_line.insertTaskInSolutionInPosition(pm_e.getCandidateI(i), k, j, pm);
						
						if(best_machine_task == -1) {
							best_machine_task = j;
							best_solution.copyValuesSolution(s_line, pm);
						}
						else {
							if(s_line.getMachineI(j).getTotalTime() < best_solution.getMachineI(best_machine_task).getTotalTime()){
								best_machine_task = j;
								best_solution.copyValuesSolution(s_line, pm);
							}
						}
					}
				}
				
				if((best_time_cand ==  -1) || (best_solution.getMachineI(best_machine_task).getTotalTime() < best_time_cand)) {
					best_time_cand = best_solution.getMachineI(best_machine_task).getTotalTime();
					best_machine = best_machine_task;
					best_task = i;
				}
			}
		}
		pm_e.setMachineIns(best_machine);
		pm_e.setNextCandidate(best_task);
	}
	
	//Search for the best position (machine and position) in the solution for a given task 
	//in relation to the objective function
	public void testBetterTaskPosition(int task, Solution s, Element e, Problem p, int receiver_size) {
		
		PMSolution s_line = new PMSolution(receiver_size, p);
		PMSolution best_solution = new PMSolution(receiver_size, p);
		
		int best_machine = 0, best_position = 0;
		//int best_time_cand = -1;
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMConstructElement pm_e = null;
		if(e instanceof PMConstructElement) {
			pm_e = (PMConstructElement) e;
		}
			 
		best_machine = -1;
				
		for(int k = 0; k < pm.getMachinesNumber(); k++) {
			for(int j = 0; j < sol.getMachineI(k).getTasksNumber()+1; j++) {
					
				s_line.copyValuesSolution(sol, p);
				s_line.insertTaskInSolutionInPosition(task, j, k, pm);
				//Update objective function
				s_line.calculateObjectiveFunction(p);
					
				if(best_machine == -1) {
					best_machine = k;
					best_position = j;
					best_solution.copyValuesSolution(s_line, pm);
				}
				else {
					if(s_line.getObjectiveFunctionI(0) < best_solution.getObjectiveFunctionI(0)){
						best_machine = k;
						best_position = j;
						best_solution.copyValuesSolution(s_line, pm);
					}
				}
			}
		}
			
		pm_e.setMachineIns(best_machine);
		pm_e.setPosIns(best_position);
	}
	
	public void testBetterTaskPositionInMachine(int task, int machine, Solution s, Element e, Problem p, int receiver_size) {
		
		PMSolution s_line = new PMSolution(receiver_size, p);
		PMSolution best_solution = new PMSolution(receiver_size, p);
		
		int best_machine = 0, best_position = 0;
		//int best_time_cand = -1;
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMConstructElement pm_e = null;
		if(e instanceof PMConstructElement) {
			pm_e = (PMConstructElement) e;
		}
			 
		best_machine = -1;
				
		for(int j = 0; j < sol.getMachineI(machine).getTasksNumber()+1; j++) {
					
			s_line.copyValuesSolution(sol, p);
			s_line.insertTaskInSolutionInPosition(task, j, machine, pm);
			//Update objective function
			s_line.calculateObjectiveFunction(p);
					
			if(best_machine == -1) {
				best_machine = machine;
				best_position = j;
				best_solution.copyValuesSolution(s_line, pm);
			}
			else {
				if(s_line.getObjectiveFunctionI(0) < best_solution.getObjectiveFunctionI(0)){
					best_machine = machine;
					best_position = j;
					best_solution.copyValuesSolution(s_line, pm);
				}
			}
		}
		pm_e.setMachineIns(best_machine);
		pm_e.setPosIns(best_position);
	}
	
	//Search for the best position (machine and position) in the solution for a given task 
	//in relation to the objective function
	public void testBetterTaskPosition20percent(int task, Solution s, Element e, Problem p, int receiver_size) {
			
		PMSolution s_line = new PMSolution(receiver_size, p);
		PMSolution best_solution = new PMSolution(receiver_size, p);
		
		//int best_time_cand = -1;
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
			
		PMConstructElement pm_e = null;
		if(e instanceof PMConstructElement) {
			pm_e = (PMConstructElement) e;
		}
		
		int n_position = (int) (0.2 * pm.getNumberOfTasks()); //VOLTAR PRA 20%
		int best_machines[] = new int[n_position];
		int best_positions[] = new int[n_position];
				 
		for(int i = 0; i < n_position; i++) {
			best_machines[i] = -1;
			best_positions[i] = -1;
		}
		
		for(int i = 0; i < n_position; i++) {
			for(int k = 0; k < pm.getMachinesNumber(); k++) {
				for(int j = 0; j < sol.getMachineI(k).getTasksNumber()+1; j++) {
					if (inLists(k, j, n_position, best_machines, best_positions) == 0) {	//if it is not on the list	
						s_line.copyValuesSolution(sol, p);
						s_line.insertTaskInSolutionInPosition(task, j, k, pm);
						//Update objective function
						s_line.calculateObjectiveFunction(p);
								
						if(best_machines[i] == -1) {
							best_machines[i] = k;
							best_positions[i] = j;
							best_solution.copyValuesSolution(s_line, pm);
						}
						else {
							if(s_line.getObjectiveFunctionI(0) < best_solution.getObjectiveFunctionI(0)){
								best_machines[i] = k;
								best_positions[i] = j;
								best_solution.copyValuesSolution(s_line, pm);
							}
						}
					}
				}
			}
		}
					
		int pos = (int)(Math.random() * n_position);
			
		pm_e.setMachineIns(best_machines[pos]);
		pm_e.setPosIns(best_positions[pos]);
	}
	
	public int inLists(int k, int j, int n, int machines[], int positions[]) {
		int in_lists = 0;
		for (int i = 0; i < n; i++) {
			if((machines[i] == k) && (positions[i] == j)) {
				in_lists = 1;
				return in_lists;
			}
		}
		return in_lists;
	}
	
	public int[] ordersMachinesCrescent(PMSolution s) {
		int order_machines[] = new int[s.getMachineNumber()];
		for(int i = 0; i < s.getMachineNumber(); i++) {
			order_machines[i] = -1;
		}
	
		for(int i = 0; i < s.getMachineNumber(); i++) {
			for(int j = 0; j < s.getMachineNumber(); j++)
				if(order_machines[j] == -1) {
					order_machines[j] = i;
					break;
				} else {
					if(s.getMachineI(i).getTotalTime() < s.getMachineI(order_machines[j]).getTotalTime()) { 
						//coloca no vetor
						int l = s.getMachineNumber()-1;
						while(l > j) {
							order_machines[l] = order_machines[l-1];
							l--;
						}
						order_machines[l] = i;
						break;
					}
				}
		}
		return order_machines;
	}
	
	public int[] ordersMachinesDecrescent(PMSolution s) {
		int order_machines[] = new int[s.getMachineNumber()];
		for(int i = 0; i < s.getMachineNumber(); i++) {
			order_machines[i] = -1;
		}
	
		for(int i = 0; i < s.getMachineNumber(); i++) {
			for(int j = 0; j < s.getMachineNumber(); j++)
				if(order_machines[j] == -1) {
					order_machines[j] = i;
					break;
				} else {
					if(s.getMachineI(i).getTotalTime() > s.getMachineI(order_machines[j]).getTotalTime()) { 
						//coloca no vetor
						int l = s.getMachineNumber()-1;
						while(l > j) {
							order_machines[l] = order_machines[l-1];
							l--;
						}
						order_machines[l] = i;
						break;
					}
				}
		}
		return order_machines;
	}
	
	//REMOVAL METHODS AND INSERTION METHODS
	
	//Remove k tasks - This method removes a total of k jobs (tasks) from the current solution at random.
	public Solution removalKRandomTasks(int k, PMSolution s, Problem p, int tasks_removed[]) {
		//tasks_removed = new int[k];
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		for(int i = 0; i < k; i++) {
			int machine, position;
			machine = (int)(Math.random() * sol.getMachineNumber());
			//System.out.println("\nNúmero: "+ sol.getMachineI(machine).getTasksNumber());
			while (sol.getMachineI(machine).getTasksNumber() == 0) {
				machine = (int)(Math.random() * sol.getMachineNumber());
			}
			position = (int)(Math.random() * sol.getMachineI(machine).getTasksNumber());
			tasks_removed[i] = sol.getMachineI(machine).getTasksInMachine(position);
			sol.removeTaskInSolution(machine, position, p);
		}
			
		return sol;
	}
	
	/*Remove k tasks - 
	This method classifies the jobs (tasks) using the sum of processing cost and setup time of allocated 
	jobs in current solution. These values are stored in the set Y. The k most expensive jobs of Y are removed.*/
	public Solution removalKGreedyExpensiveCost(int k, PMSolution s, Problem p, int tasks_removed[]) {
		
		//tasks_removed = new int[k];
		int tasks_cost_removed[] = new int[k];
		int task_cost;
		int inserted;
		
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		int l = -1;
	    for(int i = 0; i < sol.getMachineNumber(); i++) {
	    	for(int j = 0; j < sol.getMachineI(i).getTasksNumber(); j++) {
	    		inserted = 0;
	    		if(j > 0) 
	    		    task_cost = pm.getProcessingTime(sol.getMachineI(i).getTasksInMachine(j), i) + 
	    		                pm.getSetupTime(i, sol.getMachineI(i).getTasksInMachine(j-1), sol.getMachineI(i).getTasksInMachine(j));
	    		else
	    			task_cost = pm.getProcessingTime(sol.getMachineI(i).getTasksInMachine(j), i);
	    		if(l == -1) {
	    			l++;
	    			tasks_cost_removed[l] = task_cost;
	    			tasks_removed[l] = sol.getMachineI(i).getTasksInMachine(j);
	    			inserted = 1;
	    		}
	    		else {
	    			//insere o maior custo já ordenado nas lista tasks_cost_removed
	    			for(int m = 0; m <= l; m++) {
	    				if(task_cost > tasks_cost_removed[m]) {
	    					for(int n = k-1; n > m; n--) {
	    						tasks_cost_removed[n] = tasks_cost_removed[n-1];
	    						tasks_removed[n] = tasks_removed[n-1];
	    					}
	    					tasks_cost_removed[m] = task_cost;
	    					tasks_removed[m] = sol.getMachineI(i).getTasksInMachine(j);
	    					if(l < k-1)
	    						l++;
	    					inserted = 1;
	    					break;
	    				}
	    			}
	    			if((inserted == 0) && (l < k-1)) {
	    				l++;
	    				tasks_cost_removed[l] = task_cost;
    					tasks_removed[l] = sol.getMachineI(i).getTasksInMachine(j);
	    			}
	    		}
	    	}
	    }
	    
	    //removal task in solution
	    int present = 0;
	    int machine[] = new int[1];
	    int pos[] = new int[1];
	    for(int i = 0; i < k; i++) {
	    	present = sol.searchTask(tasks_removed[i], machine, pos);
	    	if(present == 1) {
	    		sol.removeTaskInSolution(machine[0], pos[0], pm);
	    	}
	    }
		
		return sol;
	}
	
	/*Remove 20% - 
	This method is a semi-greedy version of the previous method and it uses the same set Y. 
	In this method k jobs are randomly removed from a subset that contains the jobs with 20% of highest cost.*/
	public Solution removalKSemiGreedyExpensiveCost(int k, PMSolution s, Problem p, int tasks_removed[]) {
		
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
	
		int q = (int) (0.2 * pm.getNumberOfTasks()); 
		int cost[] = new int[q];
		int tasks_cost[] = new int[q];
		int task_cost;
		int inserted;
		
		int l = -1;
	    for(int i = 0; i < sol.getMachineNumber(); i++) {
	    	for(int j = 0; j < sol.getMachineI(i).getTasksNumber(); j++) {
	    		inserted = 0;
	    		if(j > 0) 
	    		    task_cost = pm.getProcessingTime(sol.getMachineI(i).getTasksInMachine(j), i) + 
	    		                pm.getSetupTime(i, sol.getMachineI(i).getTasksInMachine(j-1), sol.getMachineI(i).getTasksInMachine(j));
	    		else
	    			task_cost = pm.getProcessingTime(sol.getMachineI(i).getTasksInMachine(j), i);
	    		if(l == -1) {
	    			l++;
	    			cost[l] = task_cost;
	    			tasks_cost[l] = sol.getMachineI(i).getTasksInMachine(j);
	    			inserted = 1;
	    		}
	    		else {
	    			//insere o maior custo já ordenado nas lista tasks_cost_removed
	    			for(int m = 0; m <= l; m++) {
	    				if(task_cost > cost[m]) {
	    					for(int n = q-1; n > m; n--) {
	    						cost[n] = cost[n-1];
	    						tasks_cost[n] = tasks_cost[n-1];
	    					}
	    					cost[m] = task_cost;
	    					tasks_cost[m] = sol.getMachineI(i).getTasksInMachine(j);
	    					if(l < q-1)
	    						l++;
	    					inserted = 1;
	    					break;
	    				}
	    			}
	    			if((inserted == 0) && (l < q-1)) {
	    				l++;
	    				cost[l] = task_cost;
    					tasks_cost[l] = sol.getMachineI(i).getTasksInMachine(j);
	    			}
	    		}
	    	}
	    }
	    
	    //removal task in solution
	    int present = 0;
	    int machine[] = new int[1];
	    int pos[] = new int[1];
	    for(int i = 0; i < k; i++) {
	    	int random_task = (int)(Math.random() * q); 
	    	present = sol.searchTask(tasks_cost[random_task], machine, pos);
	    	if(present == 1) {
	    		sol.removeTaskInSolution(machine[0], pos[0], pm);
	    		tasks_removed[i] = tasks_cost[random_task]; //tasks removed from the solution
	    		//REMOVE LIST OF ALREADY USED TASK AND DECREASE Q
	    		for(int m = random_task; m < q-1; m++) {
	    			tasks_cost[m] = tasks_cost[m+1];
	    		}
	    		q--;
	    	}
	    }
		return sol;
	}	
	
	/*This method selects a random machine and removes the first q jobs from machine. 
	If the size of this machine is less than q, another machine is selected randomly until k 
	jobs have been removed.*/
	public Solution removalKTaskRandomMachine(int k, PMSolution s, Problem p, int tasks_removed[]) {
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		int i = 0;
		while(i < k) {
			int random_machine = (int)(Math.random() * sol.getMachineNumber());
			while (sol.getMachineI(random_machine).getTasksNumber() == 0) {
				random_machine = (int)(Math.random() * sol.getMachineNumber());
			}
		    while((i < k) && (sol.getMachineI(random_machine).getTasksNumber() > 0)) {
		    	tasks_removed[i] = sol.getMachineI(random_machine).getTasksInMachine(0);
		    	sol.removeTaskInSolution(random_machine, 0, pm);
		    	i++;
		    }
		}
		
		return sol;
	}
	
	/*This method selects a machine with the highest cost and remove the first q jobs from that machine. 
	If the size of this machine is less than q, another machine with higher cost is selected 
	until k jobs have been removed.*/
	public Solution removalKTasksHighestCostMachine(int k, PMSolution s, Problem p, int tasks_removed[]) {
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		int i = 0;
		while(i < k) {
			int machine = sol.highestCostMachine();
		    while((i < k) && (sol.getMachineI(machine).getTasksNumber() > 0)) {
		    	tasks_removed[i] = sol.getMachineI(machine).getTasksInMachine(0);
		    	sol.removeTaskInSolution(machine, 0, pm);
		    	i++;
		    }
		}
		return sol;
	}
	
	public int highestCostMachine() {
		int highest_cost = this.getMachineI(0).getTotalTime();
		int machine = 0;
		for(int i = 0; i < this.getMachineNumber(); i++) {
			if(this.getMachineI(i).getTotalTime() > highest_cost) {
				highest_cost = this.getMachineI(i).getTotalTime();
				machine = i;
			}
		}
		return machine;
	}
	
	/*This method performs the greedy insertion of k jobs in the current solution. 
	 * For each job j belonging k the best position among all machines is searched. 
	 * The best position is the one that provides the lowest cost for the machine. 
	 * Then, the job is allocated in the best position. */
	public Solution insertionKGreedyTasks(int k, PMSolution s, Problem p, int tasks_inserted[], int receiver_size) {
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		PMConstructElement pm_e = new PMConstructElement(p);
		
		for(int i = 0; i < k; i++) {
			sol.testBetterTaskPosition(tasks_inserted[i], sol, pm_e, pm, receiver_size);
			sol.insertTaskInSolutionInPosition(tasks_inserted[i], pm_e.getPosIns(), pm_e.getMachineIns(), pm);
		}
		
		sol.calculateObjectiveFunction(pm);
		return sol;
	}
	
	public Solution insertionKRandomTasks(int k, PMSolution s, Problem p, int tasks_inserted[], int receiver_size) {
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		int pos_ins, machine_ins;
		
		for(int i = 0; i < k; i++) {
			machine_ins = (int)(Math.random() * sol.getMachineNumber());
			pos_ins = (int)(Math.random() * (sol.getMachineI(machine_ins).getTasksNumber()+1));
			sol.insertTaskInSolutionInPosition(tasks_inserted[i], pos_ins, machine_ins, pm);
		}
		
		sol.calculateObjectiveFunction(pm);
		return sol;
	}
		
	/*This method is a semi-greedy version of the previous method. For each job j belonging to q a random position 
	 * between the 20% best positions is chosen. After this, the job j is allocated to this position.
	 */
	public Solution insertionKSemiGreedy(int k, PMSolution s, Problem p, int tasks_inserted[], int receiver_size) {
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		PMConstructElement pm_e = new PMConstructElement(p);
		
		for(int i = 0; i < k; i++) {
			sol.testBetterTaskPosition20percent(tasks_inserted[i], sol, pm_e, pm, receiver_size);
			sol.insertTaskInSolutionInPosition(tasks_inserted[i], pm_e.getPosIns(), pm_e.getMachineIns(), pm);
		}
		
		sol.calculateObjectiveFunction(pm);
		return sol;
	}
	
	public Solution insertionKLambda(int k, Solution s, Problem p, int tasks_inserted[], int receiver_size) {
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		int q1 = (int) (k/2);
		int tasks_inserted_q1[] = new int[q1];
		for(int i = 0; i < q1; i++) {
			tasks_inserted_q1[i] = tasks_inserted[i];
		}
		int q2 = k - q1;
		int tasks_inserted_q2[] = new int[q2];
		int j = q1;
		for(int i = 0; i < q2; i++ ) {
			tasks_inserted_q2[i] = tasks_inserted[j];
			j++;
		}
		
		s = sol.insertionKRandomTasks(q1, sol, pm, tasks_inserted_q1, receiver_size);
		
		sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		s = sol.insertionKGreedyTasks(q2, sol, pm, tasks_inserted_q2, receiver_size);
		
		sol.calculateObjectiveFunction(pm);
		return sol;
	}
	
	public Solution insertionKILS(int k, PMSolution s, Problem p, int tasks_inserted[], int receiver_size) {
		PMProblem pm = null;
		if(p instanceof PMProblem) {
			pm = (PMProblem) p;
		}
		
		PMSolution sol = null;
		if(s instanceof PMSolution) {
			sol = (PMSolution) s;
		}
		
		PMConstructElement pm_e = new PMConstructElement(p);
		int machine_ins;
		
		for(int i = 0; i < k; i++) {
			machine_ins = (int)(Math.random() * sol.getMachineNumber());
			sol.testBetterTaskPositionInMachine(tasks_inserted[i], machine_ins, sol, pm_e, pm, receiver_size);
			if(pm_e.getPosIns() ==-1)
				System.out.println("Deu errado!");
			sol.insertTaskInSolutionInPosition(tasks_inserted[i], pm_e.getPosIns(), machine_ins, pm);
		}
		
		sol.calculateObjectiveFunction(pm);
		return sol;
	}
	
	/* SETS AND GETS */
	public Machine getMachineI(int i) {
		return machines[i];
	}

	public void setMachineI(Machine machines, int i) {
		this.machines[i] = machines;
	}

	public int getTaskInMachines(int machine, int i) {
		return machines[machine].getTasksInMachine(i);
	}

	public void setTaskInMachines(int machine, int i, int task) {
		this.machines[machine].setTasksInMachine(task, i);
	}

	public int getMachineNumber() {
		return machine_number;
	}


	public void setMachineNumber(int machine_number) {
		this.machine_number = machine_number;
	}
	
	public int getTaskNumberMachineI(int machine) {
		return this.getMachineI(machine).getTasksNumber();
	}
	
	public void setTaskNumberMachineI(int machine, int tasks_number) {
		this.getMachineI(machine).setTasksNumber(tasks_number);
	}
	
}
