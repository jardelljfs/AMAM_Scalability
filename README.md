# A Scalability Analysis of a Multi-agent Framework for solving combinatorial optimization via Metaheuristics

This paper addresses the scalability dimension of a multi-agent framework for solving combinatorial optimization problems using metaheuristics. The related literature discusses several properties of multi-agent systems. However, an important property that has received little attention is scalability, which refers to the ability of a system to perform useful work uniformly as the dimension of the system itself increases. This article introduces a methodology for assessing the scalability of multi-agent frameworks using scenarios with one, two, four, eight, ten, fifty, thirty, forty, fifty, and sixty agents. The framework Multi-Agent Architecture for Metaheuristics (AMAM) is the adopted architecture for performing the computational tests, using instances of the Vehicle Routing Problem with Time Windows (VRPTW) and the Unrelated Parallel Machine Scheduling Problem with Sequence-Dependent Setup Times (UPMSP-ST). The proposed methodology uses the obtained values concerning the objective function and the associated runtimes of the instanced problems to perform statistical measurements and tests that revealed an improvement in the framework's performance concerning the quality of solutions despite the slight increase in runtime for the VRPTW case. The results of a linear regression approach concerning the objective function data showed an adequate representation of agent inclusion but, regarding the runtime values, did not demonstrate such precise adjustments. The final results suggest that the adopted framework is scalable and demonstrates a robust response to the increase in the number of agents in its structure.

-------------------------------------------------------------------------------------------------------

## Publication

Maria Amélia Lopes Silva, Jardell Fillipe da Silva, Sérgio Ricardo de Souza e Marcone Jamilson Freitas Souza (2024). UFV - Campus Florestal, CEFET-MG e UFOP 2024

This article was submitted to [Engineering Applications of Artificial Intelligence](https://www.sciencedirect.com/journal/engineering-applications-of-artificial-intelligence) on 12/26/2023.

-------------------------------------------------------------------------------------------------------

## AMAM Framework

The AMAM Framework is available here: [https://github.com/mamelials/AMAM-Multiagente-Architecture-for-Metaheuristics](https://github.com/mamelials/AMAM-Multiagente-Architecture-for-Metaheuristics). The AMAM Framework was implemented in Java, with JDK~8, using IDE Eclipse.

-------------------------------------------------------------------------------------------------------

## Execution

The results were obtained using the computational cluster of the Federal University of Viçosa - UFV, maintained by the Scientific and Technological Development Support Division [https://dct.ufv.br](https://dct.ufv.br). The used computer node has the following configurations: Intel Xeon Silver 4216 processor (22 MB Cache, 2.1 GHz, 16 cores 384 GB RAM), totaling 64 execution cores, with the Linux CentOS operating system. The codes used in this work are available on [GitHub](https://github.com/jardelljfs/AMAM_Scalability).

-------------------------------------------------------------------------------------------------------

## Statistical Analysis

The experiments aim to investigate the performance of the AMAM Framework when the number of agents grows. The objective is to evaluate the structure regarding its scalability. Based on the heterogeneity of the ways of measuring scalability, the experiments assess whether the inclusion of agents in the framework has a direct influence on its performance concerning the quality of the obtained results for the objective function values as well as the obtained runtimes.

Todos as análises estatisticas são apresentadas na pasta [statistical_analysis](statistical_analysis).

The experiments were divided into 4 sessions. To facilitate the interpretation of the analyses, `.R` files were created for each session, as follows:

1. [`computational_results.R`](statistical_analysis/computational_results.R)

2. [`statistical_analysis.R`](statistical_analysis/statistical_analysis.R)

3. [`linear_adjustment.R`](statistical_analysis/linear_adjustment.R)

4. [`single_agent_multi-agent.R`](statistical_analysis/single_agent_multi-agent.R)

To better present the results visually, dynamic files were created for each problem addressed.

1. [VRPTW analysis](https://jardell-jfs.shinyapps.io/vrptw_analysis/)

2. [UPMSP-ST analysis](https://jardell-jfs.shinyapps.io/pmp_analysis/)

The raw data for each problem can be found in the following `.csv` files:

1. VRPTW [`vrp_data.csv`](statistical_analysis/vrp_data.csv)

2. UPMSP-ST [`pmp_data.csv`](statistical_analysis/pmp_data.csv)

## Instances

For the instantiation of the AMAM Framework, the experiments used the following sets of instances available in the literature:

1. VRPTW: the set of $56$ instances with $100$ clients proposed by Solomon (1987), avaiable at [https://www.sintef.no/projectweb/top/vrptw/100-customers/](https://www.sintef.no/projectweb/top/vrptw/100-customers/), which is a benchmark for this problem. These instances present three different customer sets (C-Cluster, R-Random, and RC-Random-Cluster) according to the considered geographic distribution. The geographic positions of customers are grouped in problem sets C1 and C2, randomly generated in problem sets R1 and R2, and a mixture of random and grouped structures in problem sets RC1 and RC2. Additionally, the problem sets C1, R1, and RC1 have narrow time windows, while the problem sets C2, R2, and RC2 have large time windows;

2. UPMSP-ST: the set of instances proposed by Vallada (2011), available at [http://soa.iti.es/problem-instances](http://soa.iti.es/problem-instances}). To evaluate AMAM, we chose $16$ instances of this data set, involving combinations of $50$ jobs, with $10$, $15$, $20$ and $25$ machines.
\end{enumerate}

All used instances are available in folder [instances](instances).

## Parameters

The parameters for the methods used are found in folder [parameters](parameters).

The parameters for the experiments are found in folder [tests](tests).
