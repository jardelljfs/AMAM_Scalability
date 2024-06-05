library(dplyr)
library(lmtest)
library(ggplot2)
require(ggplot2)
require(reshape2)

rm(list = ls(all = TRUE))

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("pmp_instances.txt", header = T)

dados <- read.csv("pmp_data.csv", sep = ",", dec = ".")

met <- c("OneAgent", "TwoAgent", "FourAgent", "EightAgent", "TenAgent", "TwentyAgent", "ThirtyAgent", "FortyAgent", "FiftyAgent", "SixtyAgent")

dados$metodo <- factor(dados$metodo, levels = met)
dados[order(dados$metodo), ]

show("Teste estatístico Função Objetivo")
kruskal.test(dados$fitness ~ dados$metodo)
pairwise.wilcox.test(dados$fitness, dados$metodo, paired=T, p.adjust.method="bonferroni",alternative="less")
pairwise.wilcox.test(dados$fitness, dados$metodo, paired=T, p.adjust.method="bonferroni",alternative="greater")

show("Teste estatístico Tempo Computacional")
kruskal.test(dados$time ~ dados$metodo)
pairwise.wilcox.test(dados$time, dados$metodo, paired=T, p.adjust.method="bonferroni", alternative="less")
pairwise.wilcox.test(dados$time, dados$metodo, paired=T, p.adjust.method="bonferroni", alternative="greater")