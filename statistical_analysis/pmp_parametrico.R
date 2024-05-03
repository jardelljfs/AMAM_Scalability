library(dplyr)
library(lmtest)

rm(list = ls(all = TRUE))

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("instances_pmp2.txt", header = T)
#colnames(melhor) <- c("instance", "fitness")

dados <- read.csv("results_50.csv", sep = ",", dec = ".");

results <- data.frame(instance= character(), 
                      literatura = double(),
                      one = double(),
                      two = double(),
                      four = double(),
                      eight = double(),
                      ten = double(),
                      twenty = double(),
                      thirty = double(),
                      forty = double(),
                      fifty = double(),
                      sixty = double());

anova <- data.frame(instance= character(),
                    bloco=character(),
                    tratamento=character(),
                    results = double(),
                    tempo = double());

anova_media <- data.frame(instance= character(),
                          bloco=character(),
                          tratamento=character(),
                          media = double(),
                          mediana = double(),
                          minimo = double(),
                          tempo_medio = double(),
                          tempo_mediana = double(),
                          tempo_max = double());

for(instance in melhor$instance){
  
  #instance <- "I_50_10_S_1-9_1";
  
  d_1 <- dados[dados$instance == instance & dados$metodo == "OneAgent", c("fitness", "time")]
  d_2 <- dados[dados$instance == instance & dados$metodo == "TwoAgent", c("fitness", "time")]
  d_4 <- dados[dados$instance == instance & dados$metodo == "FourAgent", c("fitness", "time")]
  d_8 <- dados[dados$instance == instance & dados$metodo == "EightAgent", c("fitness", "time")]
  d_10 <- dados[dados$instance == instance & dados$metodo == "TenAgent", c("fitness", "time")]
  d_20 <- dados[dados$instance == instance & dados$metodo == "TwentyAgent", c("fitness", "time")]
  d_30 <- dados[dados$instance == instance & dados$metodo == "ThirtyAgent", c("fitness", "time")]
  d_40 <- dados[dados$instance == instance & dados$metodo == "FortyAgent", c("fitness", "time")]
  d_50 <- dados[dados$instance == instance & dados$metodo == "FiftyAgent", c("fitness", "time")]
  d_60 <- dados[dados$instance == instance & dados$metodo == "SixtyAgent", c("fitness", "time")]
  
  linha <- data.frame(instance = instance, 
                      literatura = melhor[melhor$instance == instance, 4],
                      one = mean(d_1$fitness),
                      two = mean(d_2$fitness),
                      four = mean(d_4$fitness),
                      eight = mean(d_8$fitness),
                      ten = mean(d_10$fitness),
                      twenty = mean(d_20$fitness),
                      thirty = mean(d_30$fitness),
                      forty = mean(d_40$fitness),
                      fifty = mean(d_50$fitness),
                      sixty = mean(d_60$fitness))
  
  results <- rbind(results, linha)
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "01one",
                    media = mean(d_1$fitness),
                    mediana = median(d_1$fitness),
                    minimo = min(d_1$fitness),
                    tempo_medio = mean(d_1$time),
                    tempo_mediana = median(d_1$time),
                    tempo_maximo = max(d_1$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "02two",
                    media = mean(d_2$fitness),
                    mediana = median(d_2$fitness),
                    minimo = min(d_2$fitness),
                    tempo_medio = mean(d_2$time),
                    tempo_mediana = median(d_2$time),
                    tempo_maximo = max(d_2$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "04four",
                    media = mean(d_4$fitness),
                    mediana = median(d_4$fitness),
                    minimo = min(d_4$fitness),
                    tempo_medio = mean(d_4$time),
                    tempo_mediana = median(d_4$time),
                    tempo_maximo = max(d_4$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "08eight",
                    media = mean(d_8$fitness),
                    mediana = median(d_8$fitness),
                    minimo = min(d_8$fitness),
                    tempo_medio = mean(d_8$time),
                    tempo_mediana = median(d_8$time),
                    tempo_maximo = max(d_8$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "10ten",
                    media = mean(d_10$fitness),
                    mediana = median(d_10$fitness),
                    minimo = min(d_10$fitness),
                    tempo_medio = mean(d_10$time),
                    tempo_mediana = median(d_10$time),
                    tempo_maximo = max(d_10$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "20twenty",
                    media = mean(d_20$fitness),
                    mediana = median(d_20$fitness),
                    minimo = min(d_20$fitness),
                    tempo_medio = mean(d_20$time),
                    tempo_mediana = median(d_20$time),
                    tempo_maximo = max(d_20$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "30thirty",
                    media = mean(d_30$fitness),
                    mediana = median(d_30$fitness),
                    minimo = min(d_30$fitness),
                    tempo_medio = mean(d_30$time),
                    tempo_mediana = median(d_30$time),
                    tempo_maximo = max(d_30$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "40forty",
                    media = mean(d_40$fitness),
                    mediana = median(d_40$fitness),
                    minimo = min(d_40$fitness),
                    tempo_medio = mean(d_40$time),
                    tempo_mediana = median(d_40$time),
                    tempo_maximo = max(d_40$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "50fifty",
                    media = mean(d_50$fitness),
                    mediana = median(d_50$fitness),
                    minimo = min(d_50$fitness),
                    tempo_medio = mean(d_50$time),
                    tempo_mediana = median(d_50$time),
                    tempo_maximo = max(d_50$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 4],
                    tratamento = "60sixty",
                    media = mean(d_60$fitness),
                    mediana = median(d_60$fitness),
                    minimo = min(d_60$fitness),
                    tempo_medio = mean(d_60$time),
                    tempo_mediana = median(d_60$time),
                    tempo_maximo = max(d_60$time));
  anova_media <- rbind.data.frame(anova_media,aux);
  
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("01one", 30),
                    results = d_1$fitness,
                    tempo = d_1$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("02two", 30),
                    results = d_2$fitness,
                    tempo = d_2$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("04four", 30),
                    results = d_4$fitness,
                    tempo = d_4$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("08eight", 30),
                    results = d_8$fitness,
                    tempo = d_8$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("10ten", 30),
                    results = d_10$fitness,
                    tempo = d_10$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("20twenty", 30),
                    results = d_20$fitness,
                    tempo = d_20$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("30thirty", 30),
                    results = d_30$fitness,
                    tempo = d_30$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("40forty", 30),
                    results = d_40$fitness,
                    tempo = d_40$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("50fifty", 30),
                    results = d_50$fitness,
                    tempo = d_50$time);
  anova <- rbind.data.frame(anova,aux);
  aux <- data.frame(instance = rep(instance, 30),
                    bloco= rep(melhor[melhor$instance == instance, 4],30),
                    tratamento = rep("60sixty", 30),
                    results = d_60$fitness,
                    tempo = d_60$time);
  anova <- rbind.data.frame(anova,aux);
  
}

#ANOVA - FO

model <- aov(results ~ tratamento, data = anova);
model
summary(model)
pairwise.t.test(anova$results, anova$tratamento, p.adjust.method="bonferroni")

dwtest(model)

fligner.test (results ~ tratamento, data = anova)

#shapiro.test(resid(model))
qqnorm(resid(model))
qqline(resid(model))

TukeyHSD(model)

#ANOVA - TEMPO

modelt <- aov(tempo ~ tratamento, data = anova);
modelt
summary(modelt)
pairwise.t.test(anova$tempo, anova$tratamento, p.adjust.method="bonferroni")

dwtest(modelt)

fligner.test (tempo ~ tratamento, data = anova)

#shapiro.test(resid(model))
qqnorm(resid(modelt))
qqline(resid(modelt))

TukeyHSD(modelt)

#ANOVA - RESULTADO MÉDIO

model <- aov(media ~ tratamento, data = anova_media);
model
summary(model)
pairwise.t.test(anova_media$media, anova_media$tratamento, p.adjust.method="bonferroni")

dwtest(model)

fligner.test (media ~ tratamento, data = anova_media)

shapiro.test(resid(model))
qqnorm(resid(model))
qqline(resid(model))

TukeyHSD(model)

#ANOVA - TEMPO MÉDIO

modelt <- aov(tempo_medio ~ tratamento, data = anova_media);
modelt
summary(modelt)
pairwise.t.test(anova_media$tempo_medio, anova_media$tratamento, p.adjust.method="bonferroni")

dwtest(modelt)

fligner.test (tempo_medio ~ tratamento, data = anova_media)

shapiro.test(resid(model))
qqnorm(resid(modelt))
qqline(resid(modelt))

TukeyHSD(modelt)
