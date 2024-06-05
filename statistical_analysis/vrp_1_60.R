library(patchwork)
library(ggplot2)
library(magrittr)
library(dplyr)

rm(list = ls(all = TRUE))

#setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("vrp_instances.txt");
melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo);
melhor <- melhor %>%
  select(-n, -fo)
colnames(melhor) <- c("instance", "bloco", "best")

#------------1800 x 1800 ------------------

dados_1800_one <- read.csv("vrp_1_60.csv", sep = ",", dec = ".");
dados_1800_sixty <- read.csv("vrp_1_60_60.csv", sep = ",", dec = ".");
dados_1800_sixty <- dados_1800_sixty %>%
  mutate(metodo = ifelse(metodo == 60, "SixtyAgent", metodo))

dados_1800_one <- merge(dados_1800_one, melhor, by.x = "instance", by.y = "instance")
dados_1800_one$gap <- (dados_1800_one$fitness - dados_1800_one$best) / dados_1800_one$best

dados_1800_sixty <- merge(dados_1800_sixty, melhor, by.x = "instance", by.y = "instance")
dados_1800_sixty$gap <- (dados_1800_sixty$fitness - dados_1800_sixty$best) / dados_1800_sixty$best

d_1_1800 <- data.frame(instancia = character(),
                       tratamento = character(),
                       time = double(),
                       results = double(),
                       gap = double());

d_1_1800 <- data.frame(instancia = dados_1800_one$instance,
                       tratamento = dados_1800_one$metodo,
                       time = dados_1800_one$time,
                       results = dados_1800_one$fitness,
                       gap = dados_1800_one$gap);

d_60_1800 <- data.frame(instancia = character(),
                        tratamento = character(),
                        time = double(),
                        results = double(),
                        gap = double());

d_60_1800 <- data.frame(instancia = dados_1800_sixty$instance,
                        tratamento = dados_1800_sixty$metodo,
                        time = dados_1800_sixty$time,
                        results = dados_1800_sixty$fitness,
                        gap = dados_1800_sixty$gap);

d_60_1800 <- rbind.data.frame(d_1_1800, d_60_1800);

#--------------30 x 30-------------

dados_30 <- read.csv("vrp_data.csv", sep = ",", dec = ".");
dados_30 <- merge(dados_30, melhor, by.x = "instance", by.y = "instance")
dados_30$gap <- (dados_30$fitness - dados_30$best) / dados_30$best

d_1_30 <- data.frame(instancia = character(),
                     tratamento = character(),
                     time = double(),
                     results = double(),
                     gap = double());

d_1_30 <- data.frame(instancia = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = instance),
                     tratamento = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = metodo),
                     time = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = time),
                     results = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = fitness),
                     gap = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = gap));

colnames(d_1_30) <- c("instancia", "tratamento", "time", "results", "gap")

#--------------1800 x 30-------------

d_1800_30 <- rbind.data.frame(subset(d_1_30, tratamento == "SixtyAgent"), subset(d_1_1800, tratamento == "OneAgent"));

#-------------30 x 60-----------------

d_1_30_m <- data.frame(instancia = character(),
                       tratamento = character(),
                       time = double(),
                       results = double(),
                       gap = double());

d_1_30_m <- d_1_1800 %>%
  group_by(instancia) %>%
  mutate(grupo = rep(1:1800, each = 60, length.out = n())) %>%  # Criando um grupo de 60 observações para cada instância
  group_by(instancia, grupo) %>%
  summarise(results = min(results),
            time = max(time),
            gap = gap[which.min(results)],
            tratamento = tratamento[which.min(results)]) %>%
  filter(grupo != 31) %>%  # Removendo as linhas onde grupo é igual a 31
  ungroup() %>%
  select(-grupo)

d_1_30_m <- rbind.data.frame(d_1_30_m, subset(d_1_30, tratamento == "SixtyAgent"));

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

(p + t) / (p2 + t2) / (p1 + t1)  / (p3 + t3)

#_________________________________________________________TESTE ESTATISTICO_________________________________________________

pairwise.t.test(d_60_1800$gap, d_60_1800$tratamento, p.adjust.method="bonferroni")
pairwise.t.test(d_60_1800$time, d_60_1800$tratamento, p.adjust.method="bonferroni")

pairwise.t.test(d_1800_30$gap, d_1800_30$tratamento, p.adjust.method="bonferroni")
pairwise.t.test(d_1800_30$time, d_1800_30$tratamento, p.adjust.method="bonferroni")

pairwise.t.test(d_1_30$gap, d_1_30$tratamento, paired=T, p.adjust.method="bonferroni")
pairwise.t.test(d_1_30$time, d_1_30$tratamento, paired=T, p.adjust.method="bonferroni")

pairwise.t.test(d_1_30_m$gap, d_1_30_m$tratamento, p.adjust.method="bonferroni")
pairwise.t.test(d_1_30_m$time, d_1_30_m$tratamento, p.adjust.method="bonferroni")

#_______________________________________________C_____________________________________________________

rm(list = ls(all = TRUE))

#setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("vrp_instances_C.txt");
melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo);
melhor <- melhor %>%
  select(-n, -fo)
colnames(melhor) <- c("instance", "bloco", "best")

#------------1800 x 1800 ------------------

dados_1800_one <- read.csv("vrp_1_60.csv", sep = ",", dec = ".");
dados_1800_sixty <- read.csv("vrp_1_60_60.csv", sep = ",", dec = ".");
dados_1800_sixty <- dados_1800_sixty %>%
  mutate(metodo = ifelse(metodo == 60, "SixtyAgent", metodo))

dados_1800_one <- merge(dados_1800_one, melhor, by.x = "instance", by.y = "instance")
dados_1800_one$gap <- (dados_1800_one$fitness - dados_1800_one$best) / dados_1800_one$best

dados_1800_sixty <- merge(dados_1800_sixty, melhor, by.x = "instance", by.y = "instance")
dados_1800_sixty$gap <- (dados_1800_sixty$fitness - dados_1800_sixty$best) / dados_1800_sixty$best

d_1_1800 <- data.frame(instancia = character(),
                       tratamento = character(),
                       time = double(),
                       results = double(),
                       gap = double());

d_1_1800 <- data.frame(instancia = dados_1800_one$instance,
                       tratamento = dados_1800_one$metodo,
                       time = dados_1800_one$time,
                       results = dados_1800_one$fitness,
                       gap = dados_1800_one$gap);

d_60_1800 <- data.frame(instancia = character(),
                        tratamento = character(),
                        time = double(),
                        results = double(),
                        gap = double());

d_60_1800 <- data.frame(instancia = dados_1800_sixty$instance,
                        tratamento = dados_1800_sixty$metodo,
                        time = dados_1800_sixty$time,
                        results = dados_1800_sixty$fitness,
                        gap = dados_1800_sixty$gap);

d_60_1800 <- rbind.data.frame(d_1_1800, d_60_1800);

#--------------30 x 30-------------

dados_30 <- read.csv("vrp_data.csv", sep = ",", dec = ".");
dados_30 <- merge(dados_30, melhor, by.x = "instance", by.y = "instance")
dados_30$gap <- (dados_30$fitness - dados_30$best) / dados_30$best

d_1_30 <- data.frame(instancia = character(),
                     tratamento = character(),
                     time = double(),
                     results = double(),
                     gap = double());

d_1_30 <- data.frame(instancia = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = instance),
                     tratamento = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = metodo),
                     time = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = time),
                     results = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = fitness),
                     gap = subset(dados_30, metodo %in% c("OneAgent", "SixtyAgent"), select = gap));

colnames(d_1_30) <- c("instancia", "tratamento", "time", "results", "gap")

#--------------1800 x 30-------------

d_1800_30 <- rbind.data.frame(subset(d_1_30, tratamento == "SixtyAgent"), subset(d_1_1800, tratamento == "OneAgent"));

#-------------30 x 60-----------------

d_1_30_m <- data.frame(instancia = character(),
                       tratamento = character(),
                       time = double(),
                       results = double(),
                       gap = double());

d_1_30_m <- d_1_1800 %>%
  group_by(instancia) %>%
  mutate(grupo = rep(1:1800, each = 60, length.out = n())) %>%  # Criando um grupo de 60 observações para cada instância
  group_by(instancia, grupo) %>%
  summarise(results = min(results),
            time = max(time),
            gap = gap[which.min(results)],
            tratamento = tratamento[which.min(results)]) %>%
  filter(grupo != 31) %>%  # Removendo as linhas onde grupo é igual a 31
  ungroup() %>%
  select(-grupo)

d_1_30_m <- rbind.data.frame(d_1_30_m, subset(d_1_30, tratamento == "SixtyAgent"));

t = ggplot(d_60_1800, aes(tratamento, time)) + geom_boxplot() + #ggtitle("1800 x 1800 - Computational Time") +   
  labs(x = "number of agents", y = "time(s)")

t1 = ggplot(d_1_30, aes(tratamento, time)) + geom_boxplot() + #ggtitle("30 x 30 - Computational Time") +   
  labs(x = "number of agents", y = "time(s)")

t2 = ggplot(d_1800_30, aes(tratamento, time)) + geom_boxplot() + #ggtitle("1800 x 30 - Computational Time") +   
  labs(x = "number of agents", y = "time(s)")

t3 = ggplot(d_1_30_m, aes(tratamento, time)) + geom_boxplot() + #ggtitle("Machine 30 x 30 - Computational Time") +   
  labs(x = "number of agents", y = "time(s)")

(t + t2) / (t1 + t3)

#_________________________________________________________TESTE ESTATISTICO_________________________________________________

pairwise.t.test(d_60_1800$time, d_60_1800$tratamento, p.adjust.method="bonferroni")

pairwise.t.test(d_1800_30$time, d_1800_30$tratamento, p.adjust.method="bonferroni")

pairwise.t.test(d_1_30$time, d_1_30$tratamento, paired=T, p.adjust.method="bonferroni")

pairwise.t.test(d_1_30_m$time, d_1_30_m$tratamento, p.adjust.method="bonferroni")
