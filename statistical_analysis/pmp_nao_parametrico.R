library(dplyr)
library(lmtest)
library(ggplot2)
require(ggplot2)
require(reshape2)

rm(list = ls(all = TRUE))

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("instances_pmp2.txt", header = T)
#colnames(melhor) <- c("instance", "fitness")

dados_ini <- read.csv("results_50.csv", sep = ",", dec = ".");

dados <- data.frame(instance= character(),
                    bloco=character(),
                    tratamento=character(),
                    results = double(),
                    time = double())

dados_time <-data.frame(one = double(),
                        two = double(),
                        four = double(),
                        eight = double(),
                        ten = double(),
                        twenty = double(),
                        thirty = double(),
                        forty = double(),
                        fifty = double(),
                        sixty = double())

for(instance in melhor$instance){
  #instance <- "I_50_10_S_1-9_1";
  
  d_1 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "OneAgent", c("fitness", "time")]
  d_2 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "TwoAgent", c("fitness", "time")]
  d_4 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "FourAgent", c("fitness", "time")]
  d_8 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "EightAgent", c("fitness", "time")]
  d_10 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "TenAgent", c("fitness", "time")]
  d_20 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "TwentyAgent", c("fitness", "time")]
  d_30 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "ThirtyAgent", c("fitness", "time")]
  d_40 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "FortyAgent", c("fitness", "time")]
  d_50 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "FiftyAgent", c("fitness", "time")]
  d_60 <- dados_ini[dados_ini$instance == instance & dados_ini$metodo == "SixtyAgent", c("fitness", "time")]
  
  dados2 <-data.frame(one = d_1$fitness,
                      two = d_2$fitness,
                      four = d_4$fitness,
                      eight = d_8$fitness,
                      ten = d_10$fitness,
                      twenty = d_20$fitness,
                      thirty = d_30$fitness,
                      forty = d_40$fitness,
                      fifty = d_50$fitness,
                      sixty = d_60$fitness)
  dados3 <-data.frame(one = d_1$time,
                      two = d_2$time,
                      four = d_4$time,
                      eight = d_8$time,
                      ten = d_10$time,
                      twenty = d_20$time,
                      thirty = d_30$time,
                      forty = d_40$time,
                      fifty = d_50$time,
                      sixty = d_60$time)
  
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(01),
                    results = d_1$fitness,
                    time = d_1$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(02),
                    results = d_2$fitness,
                    time = d_2$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(04),
                    results = d_4$fitness,
                    time = d_4$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(08),
                    results = d_8$fitness,
                    time = d_8$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(10),
                    results = d_10$fitness,
                    time = d_10$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(20),
                    results = d_20$fitness,
                    time = d_20$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(30),
                    results = d_30$fitness,
                    time = d_30$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(40),
                    results = d_40$fitness,
                    time = d_40$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(50),
                    results = d_50$fitness,
                    time = d_50$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = rep(60),
                    results = d_60$fitness,
                    time = d_60$time);
  dados <- rbind.data.frame(dados,aux);
  dados_t <-data.frame(one = mean(d_1$time),
                       two = mean(d_2$time),
                       four = mean(d_4$time),
                       eight = mean(d_8$time),
                       ten = mean(d_10$time),
                       twenty = mean(d_20$time),
                       thirty = mean(d_30$time),
                       forty = mean(d_40$time),
                       fifty = mean(d_50$time),
                       sixty = mean(d_60$time));
  dados_time <- rbind.data.frame(dados_time, dados_t)
}

show("Teste estatístico Função Objetivo")
kruskal.test(dados$results ~ dados$tratamento)
pairwise.wilcox.test(dados$results, dados$tratamento, paired=T, p.adjust.method="bonferroni",alternative="less")
pairwise.wilcox.test(dados$results, dados$tratamento, paired=T, p.adjust.method="bonferroni",alternative="greater")


show("Teste estatístico Tempo Computacional")
kruskal.test(dados$time ~ dados$tratamento)
pairwise.wilcox.test(dados$time, dados$tratamento, paired=T, p.adjust.method="bonferroni", alternative="less")
pairwise.wilcox.test(dados$time, dados$tratamento, paired=T, p.adjust.method="bonferroni", alternative="greater")
