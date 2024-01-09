package Construct_MKP;

import java.util.Random;

import Construction.NextCandidate;
import Environment.Element;
import Environment.Problem;
import Environment.Solution;
import Environment_MKP.MKProblem;

/** AMAM - Multiagent architecture for metaheuristics
 * 
 * Copyright (C) 2013-2018 Silva, M.A.L.
 * Function: Class that implements the NextCandidate class  
 * @author Maria Amélia Lopes Silva <mamelia@ufv.br>
 **/

public class MKPNextCandidate implements NextCandidate{

	private int rcl[];
	private int rcl_size;
	
	@Override
	public void nextCandidate(Solution s, Element e, Problem p, String function_type, int receiver_size) {
		// TODO Auto-generated method stub
			
		switch(function_type) {
			
			case "greedy":
				this.greedyFunctionMK(s, e, p, receiver_size);
				break;
			case "greedy_random":
				this.greedyRandomFunctionMK(s, e, p, receiver_size);
				break;
			case "random":
				this.randomFunctionMK(s, e, p);
				break;
			default:
				System.out.println("Invalid Function!");
		}
	}
		
	private void greedyFunctionMK(Solution s, Element e, Problem p, int receiver_size) {
		
		MKPConstructElement e_mkp = null;
		if(e instanceof MKPConstructElement) {
			e_mkp = (MKPConstructElement) e;
		}
			
		e_mkp.setPosCandidate(e_mkp.getCount());
		e_mkp.setNextCandidate(e_mkp.getCandidateI(e_mkp.getPosCandidate()));
		
	}

	private void greedyRandomFunctionMK(Solution s, Element e, Problem p, int receiver_size) {
		
		int cand, pos_rcl, current_size;
		
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		MKPConstructElement e_mkp = null;
		if(e instanceof MKPConstructElement) {
			e_mkp = (MKPConstructElement) e;
		}
		
		this.rcl = new int[this.rcl_size];
		
		Random generator = new Random();
		
		int i = 0;
		int j = 0;
		while((i < this.rcl_size) && (j < mkp.getNumberOfItems())) {
			if(e_mkp.getCandidateI(j) != -1) {
				this.rcl[i] = e_mkp.getCandidateI(j);
				i++;
			}
			j++;
		}
		current_size = i;
		pos_rcl = generator.nextInt(current_size); 
		cand = this.rcl[pos_rcl];
		e_mkp.setPosCandidate(this.searchPositionCandidate(cand, e_mkp, mkp));
		
		e_mkp.setNextCandidate(cand);
	
	}

	public int searchPositionCandidate(int cand, MKPConstructElement e, MKProblem p) {
		for(int i = 1; i < p.getNumberOfItems(); i++) {
			if(e.getCandidateI(i) == cand) {
				return i;
			}
		}
		return 0;
	}

	private void randomFunctionMK(Solution s, Element e, Problem p) {
			
		MKProblem mkp = null;
		if(p instanceof MKProblem) {
			mkp = (MKProblem) p;
		}
		
		MKPConstructElement mk_e= null;
		if(e instanceof MKPConstructElement) {
			mk_e = (MKPConstructElement) e;
		}
		
		Random generator = new Random();		
		int item;
		
		do {
			item = generator.nextInt(mkp.getNumberOfItems());
		} while(mk_e.getCandidateI(item) == -1);
		
		mk_e.setNextCandidate(mk_e.getCandidateI(item));
		mk_e.setPosCandidate(item);
		
	}

	public int getRclSize() {
		return rcl_size;
	}

	public void setRclSize(int rcl_size) {
		this.rcl_size = rcl_size;
	}
	
}