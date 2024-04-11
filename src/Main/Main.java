package Main;

import java.text.SimpleDateFormat;

/** AMAM - Multi-agent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: This class implement the 
 * @author Maria Am�lia Lopes Silva <mamelia@ufv.br> <mamelials@gmail.com>
 * 
 *  This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class Main {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub

		String instance;
		String prob;
		String experiment_text_file;
		Experiment experiment;
		//prob = "PM_";
		
		prob = args[3];
		
		//System.out.println("Executando...");
		
		//------------------VRP-------------------
		
		instance = args[0];
		/*instance = "I_50_10_S_1-9_1";
		 * 
		
		
		//ONE AGENT -----------------------------------
		experiment_text_file = prob + instance + "_TwoAgent";
		
		//LOADS ALL PARAMETERS AND PROBLEM DATA
		experiment = new Experiment(experiment_text_file, "");
		
		//RUN THE EXPERIMENT
		experiment.runExperiment(prob + "TwoAgent", 2);
		experiment.runExperiment(prob + "TwoAgent", 3);*/
		
		
		experiment_text_file = prob + instance + "_" + args[1];
				
		//LOADS ALL PARAMETERS AND PROBLEM DATA
		experiment = new Experiment(experiment_text_file, "");
				
		//RUN THE EXPERIMENT
		experiment.runExperiment(prob + args[1], Integer.parseInt(args[2]));
		
		//System.out.println("\n\nEND EXPERIMENT!");	
	}
}
