# A Scalability Analysis of a Multi-agent Framework for solving combinatorial optimization via Metaheuristics

This paper addresses the scalability dimension of a multi-agent framework for solving combinatorial optimization problems using metaheuristics. The related literature discusses several properties of multi-agent systems. However, an important property that has received little attention is scalability, which refers to the ability of a system to perform useful work uniformly as the dimension of the system itself increases. This article introduces a methodology for assessing the scalability of multi-agent frameworks using scenarios with one, two, four, eight, ten, fifty, thirty, forty, fifty, and sixty agents. The framework Multi-Agent Architecture for Metaheuristics (AMAM) is the adopted architecture for performing the computational tests, using instances of the Vehicle Routing Problem with Time Windows (VRPTW) and the Unrelated Parallel Machine Scheduling Problem with Sequence-Dependent Setup Times (UPMSP-ST). The proposed methodology uses the obtained values concerning the objective function and the associated runtimes of the instanced problems to perform statistical measurements and tests that revealed an improvement in the framework's performance concerning the quality of solutions despite the slight increase in runtime for the VRPTW case. The results of a linear regression approach concerning the objective function data showed an adequate representation of agent inclusion but, regarding the runtime values, did not demonstrate such precise adjustments. The final results suggest that the adopted framework is scalable and demonstrates a robust response to the increase in the number of agents in its structure.

-------------------------------------------------------------------------------------------------------

## Publication

Maria Amélia Lopes Silva, Jardell Fillipe da Silva, Sérgio Ricardo de Souza e Marcone Jamilson Freitas Souza (2024). UFV - Campus Florestal, CEFET-MG e UFOP 2024

This article was submitted to [Engineering Applications of Artificial Intelligence](https://www.sciencedirect.com/journal/engineering-applications-of-artificial-intelligence) on 12/26/2023.

-------------------------------------------------------------------------------------------------------

## AMAM Framework

The AMAM Framework is available here: [https://github.com/mamelials/AMAM-Multiagente-Architecture-for-Metaheuristics](https://github.com/mamelials/AMAM-Multiagente-Architecture-for-Metaheuristics) 

The AMAM Framework was implemented in Java, with JDK~8, using IDE Eclipse. The results were obtained using the computational cluster of the Federal University of Viçosa - UFV, maintained by the Scientific and Technological Development Support Division [https://dct.ufv.br](https://dct.ufv.br). The used computer node has the following configurations: Intel Xeon Silver 4216 processor (22 MB Cache, 2.1 GHz, 16 cores 384 GB RAM), totaling 64 execution cores, with the Linux CentOS operating system. The codes used in this work are available on [GitHub](https://github.com/jardelljfs/AMAM_Scalability).

-------------------------------------------------------------------------------------------------------

## Statistical Analysis

The experiments aim to investigate the performance of the AMAM Framework when the number of agents grows. The objective is to evaluate the structure regarding its scalability. Based on the heterogeneity of the ways of measuring scalability, the experiments assess whether the inclusion of agents in the framework has a direct influence on its performance concerning the quality of the obtained results for the objective function values as well as the obtained runtimes.

[statistical_analysis](statistical_analysis)

[VRPTW analysis](https://jardell-jfs.shinyapps.io/vrptw_analysis/)

[UPMSP-ST analysis](https://jardell-jfs.shinyapps.io/pmp_analysis/)

## Instances

[`instances`](instances)

## Parameters

[parameters](parameters)
[tests](tests)

`computational_results.R`

statistical_analysis.R

linear_adjustment.R

single_agent_multi-agent.R

pmp_data.csv

vrp_data.csv

