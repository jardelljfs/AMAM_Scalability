library(patchwork)
library(ggplot2)
library(magrittr)

#melhor <- read.delim("/home/jardell/Documentos/artigo_escalabilidade/melhor_c");
melhor <- read.delim("melhor_total.txt");
melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo);

#------------1800 x 1800 ------------------

d_1_30 <- data.frame(instancia = character(),
                       tratamento = character(),
                       fo = double(),
                       n = integer(),
                       time = double(),
                       results = double(),
                       gap = double());

d_1_30_m <- data.frame(instancia = character(),
                     tratamento = character(),
                     fo = double(),
                     n = integer(),
                     time = double(),
                     results = double(),
                     gap = double());

d_1_1800 <- data.frame(instancia = character(),
                        tratamento = character(),
                        fo = double(),
                        n = integer(),
                        time = double(),
                        results = double(),
                        gap = double());

d_60_30 <- data.frame(instancia = character(),
                      tratamento = character(),
                      fo = double(),
                      n = integer(),
                      time = double(),
                      results = double(),
                      gap = double());

d_60_1800 <- data.frame(instancia = character(),
                   tratamento = character(),
                   fo = double(),
                   n = integer(),
                   time = double(),
                   results = double(),
                   gap = double());

for(instance in melhor$instancia){
  for(i in 0:59){
    linha <- read.delim(header = FALSE, col.names = c("fo",	"n",	"time"), paste("results_final/Results_NTry-SixtyAgent-30-",instance,"-",i,".txt", sep = ""))
    linha <- data.frame(linha, results = linha$n * 1000 + linha$fo)
    linha <- data.frame(linha, instancia = rep(instance,30))
    linha <- data.frame(linha, tratamento = rep("sixty",30))
    linha <- data.frame(linha, gap =  (linha$results - melhor[melhor$instancia == instance, 5])/melhor[melhor$instancia == instance, 5])
    d_60_1800 <- rbind(d_60_1800, linha)
  }
  
  d_1 <- read.delim(paste("results_final/Results_BestSolutionNTry-OneAgent-1800-",instance,"-.txt", sep = ""))
  d_1 <- data.frame(d_1, results = d_1$n * 1000 + d_1$fo)
  d_1 <- data.frame(d_1, instancia = rep(instance,1800))
  d_1 <- data.frame(d_1, tratamento = rep("one",1800))
  d_1 <- data.frame(d_1, gap = (d_1$results - melhor[melhor$instancia == instance, 5])/melhor[melhor$instancia == instance, 5])
  
  for(i in c(1,	61,	121,	181,	241,	301,	361,	421,	481,	541,	601,	661,	721,	781,	841,	901,	961,	1021,	1081,	1141,	1201,	1261,	1321,	1381,	1441,	1501,	1561,	1621,	1681,	1741)){
    aux <- data.frame(fo = min(d_1[i:(i+59),1]),
                      n = min(d_1[i:(i+59),2]),
                      time = max(d_1[i:(i+59),3]),
                      results = min(d_1[i:(i+59),4]),
                      instancia = instance,
                      tratamento = "one");
    aux = data.frame(aux, gap = (aux$results - melhor[melhor$instancia == instance, 5])/melhor[melhor$instancia == instance, 5])
    d_1_30_m <- rbind.data.frame(d_1_30_m, aux);
  }
  
  d_1_1800 <- rbind(d_1_1800, d_1)
  
  d_60 <- read.delim(paste("results_final/Results_BestSolutionNTry-SixtyAgent-30-",instance,"-.txt", sep = ""))
  d_60 <- data.frame(d_60, results = d_60$n * 1000 + d_60$fo)
  d_60 <- data.frame(d_60, instancia = rep(instance,30))
  d_60 <- data.frame(d_60, tratamento = rep("sixty",30))
  d_60 <- data.frame(d_60, gap = (d_60$results - melhor[melhor$instancia == instance, 5])/melhor[melhor$instancia == instance, 5])
  
  d_60_30 <- rbind(d_60_30, d_60)
  
  linha_1_30 <- data.frame(fo = d_1[1:30,1],
                           n = d_1[1:30,2],
                           time = d_1[1:30,3],
                           results = d_1[1:30,4],
                           instancia = rep(instance, 30),
                           tratamento = rep("one", 30),
                           gap = d_1[1:30,7]);
  
  d_1_30 <- rbind(d_1_30, linha_1_30)
}

d_60_1800 <- rbind.data.frame(d_60_1800, d_1_1800);

d_1_30 <- rbind.data.frame(d_1_30, d_60_30);

d_1800_30 <- rbind.data.frame(d_1_1800, d_60_30);

d_1_30_m <- rbind.data.frame(d_1_30_m, d_60_30);

p = ggplot(d_60_1800, aes(tratamento, gap)) + geom_boxplot() + geom_jitter(width = 0.2, shape=16,size=2) + ggtitle("1800 x 1800 - Função Objetivo gap(%)") +   labs(x = "Numero de agentes", y = "Gap(%) FO")
t = ggplot(d_60_1800, aes(tratamento, time)) + geom_boxplot() + geom_jitter(width = 0.2, shape=16,size=2) + ggtitle("1800 x 1800 - Tempo Médio(s)") +   labs(x = "Numero de agentes", y = "Tempo Médio (s)")

p1 = ggplot(d_1_30, aes(tratamento, gap)) + geom_boxplot() + geom_jitter(width = 0.2, shape=16,size=2) + ggtitle("30 x 30 - Função Objetivo gap(%)") +   labs(x = "Numero de agentes", y = "Gap(%) FO")
t1 = ggplot(d_1_30, aes(tratamento, time)) + geom_boxplot() + geom_jitter(width = 0.2, shape=16,size=2) + ggtitle("30 x 30 - Tempo Médio(s)") +   labs(x = "Numero de agentes", y = "Tempo Médio (s)")

p2 = ggplot(d_1800_30, aes(tratamento, gap)) + geom_boxplot() + geom_jitter(width = 0.2, shape=16,size=2) + ggtitle("1800 x 30 - Função Objetivo gap(%)") +   labs(x = "Numero de agentes", y = "Gap(%) FO")
t2 = ggplot(d_1800_30, aes(tratamento, time)) + geom_boxplot() + geom_jitter(width = 0.2, shape=16,size=2) + ggtitle("1800 x 30 - Tempo Médio (s)") +   labs(x = "Numero de agentes", y = "Tempo Médio (s)")

p3 = ggplot(d_1_30_m, aes(tratamento, gap)) + geom_boxplot() + geom_jitter(width = 0.2, shape=16,size=2) + ggtitle("Máquina 30 x 30 - Função Objetivo gap(%)") +   labs(x = "Numero de agentes", y = "Gap(%) FO")
t3 = ggplot(d_1_30_m, aes(tratamento, time)) + geom_boxplot() + geom_jitter(width = 0.2, shape=16,size=2) + ggtitle("Máquina 30 x 30 - Tempo Médio (s)") +   labs(x = "Numero de agentes", y = "Tempo Médio (s)")

p = ggplot(d_60_1800, aes(tratamento, gap)) + geom_boxplot() + #ggtitle("1800 x 1800 - Objective Function") +   
  labs(x = "number of agents", y = "gap(%)")
t = ggplot(d_60_1800, aes(tratamento, time)) + geom_boxplot() + #ggtitle("1800 x 1800 - Computational Time") +   
  labs(x = "number of agents", y = "time(s)")

p1 = ggplot(d_1_30, aes(tratamento, gap)) + geom_boxplot() + #ggtitle("30 x 30 - Objective Function") +   
  labs(x = "number of agents", y = "gap(%)")
t1 = ggplot(d_1_30, aes(tratamento, time)) + geom_boxplot() + #ggtitle("30 x 30 - Computational Time") +   
  labs(x = "number of agents", y = "time(s)")

p2 = ggplot(d_1800_30, aes(tratamento, gap)) + geom_boxplot() + #ggtitle("1800 x 30 - Objective Function") +   
  labs(x = "number of agents", y = "gap(%)")
t2 = ggplot(d_1800_30, aes(tratamento, time)) + geom_boxplot() + #ggtitle("1800 x 30 - Computational Time") +   
  labs(x = "number of agents", y = "time(s)")

p3 = ggplot(d_1_30_m, aes(tratamento, gap)) + geom_boxplot() + #ggtitle("Machine 30 x 30 - Objective Function") +   
  labs(x = "number of agents", y = "gap(%)")
t3 = ggplot(d_1_30_m, aes(tratamento, time)) + geom_boxplot() + #ggtitle("Machine 30 x 30 - Computational Time") +   
  labs(x = "number of agents", y = "time(s)")

p = ggplot(d_60_1800, aes(tratamento, gap)) + geom_boxplot() + #ggtitle("1800 x 1800 - Objective Function") +   
  labs(x = "número de agentes", y = "gap(%)")
t = ggplot(d_60_1800, aes(tratamento, time)) + geom_boxplot() + #ggtitle("1800 x 1800 - Computational Time") +   
  labs(x = "número de agentes", y = "tempo(s)")

p1 = ggplot(d_1_30, aes(tratamento, gap)) + geom_boxplot() + #ggtitle("30 x 30 - Objective Function") +   
  labs(x = "número de agentes", y = "gap(%)")
t1 = ggplot(d_1_30, aes(tratamento, time)) + geom_boxplot() + #ggtitle("30 x 30 - Computational Time") +   
  labs(x = "número de agentes", y = "tempo(s)")

p2 = ggplot(d_1800_30, aes(tratamento, gap)) + geom_boxplot() + #ggtitle("1800 x 30 - Objective Function") +   
  labs(x = "número de agentes", y = "gap(%)")
t2 = ggplot(d_1800_30, aes(tratamento, time)) + geom_boxplot() + #ggtitle("1800 x 30 - Computational Time") +   
  labs(x = "número de agentes", y = "tempo(s)")

p3 = ggplot(d_1_30_m, aes(tratamento, gap)) + geom_boxplot() + #ggtitle("Machine 30 x 30 - Objective Function") +   
  labs(x = "número de agentes", y = "gap(%)")
t3 = ggplot(d_1_30_m, aes(tratamento, time)) + geom_boxplot() + #ggtitle("Machine 30 x 30 - Computational Time") +   
  labs(x = "número de agentes", y = "tempo(s)")

p
t
p1
t1
p2
t2
p3
t3

t
t1
t2
t3
(p + t) / (p1 + t1) / (p2 + t2) / (p3 + t3)

#_________________________________________________________TESTE ESTATISTICO_________________________________________________
#model <- aov(results ~ tratamento, data = d_60);
#model
#summary(model)
pairwise.t.test(d_60_1800$results, d_60_1800$tratamento, p.adjust.method="bonferroni")
pairwise.t.test(d_60_1800$time, d_60_1800$tratamento, p.adjust.method="bonferroni")

pairwise.t.test(d_1_30$results, d_1_30$tratamento, paired=T, p.adjust.method="bonferroni")
pairwise.t.test(d_1_30$time, d_1_30$tratamento, paired=T, p.adjust.method="bonferroni")

pairwise.t.test(d_1800_30$results, d_1800_30$tratamento, p.adjust.method="bonferroni")
pairwise.t.test(d_1800_30$time, d_1800_30$tratamento, p.adjust.method="bonferroni")

pairwise.t.test(d_1_30_m$results, d_1_30_m$tratamento, p.adjust.method="bonferroni")
pairwise.t.test(d_1_30_m$time, d_1_30_m$tratamento, p.adjust.method="bonferroni")