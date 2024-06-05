library(dplyr)
library(lmtest)

rm(list = ls(all = TRUE))

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("pmp_instances.txt", header = T)

dados <- read.csv("pmp_data.csv", sep = ",", dec = ".");

#Premissas para realização do teste parametrico Fitness

model <- aov(fitness ~ metodo, data = dados);

dwtest(model)

fligner.test (fitness ~ metodo, data = dados)

shapiro.test(resid(model))
qqnorm(resid(model))
qqline(resid(model))

#Premissas para realização do teste parametrico time

modelt <- aov(time ~ metodo, data = dados);

dwtest(modelt)

fligner.test (time ~ metodo, data = dados)

shapiro.test(resid(model))
qqnorm(resid(modelt))
qqline(resid(modelt))