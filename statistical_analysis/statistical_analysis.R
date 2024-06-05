
#-------------------Statistical Analysis - VRPTW------------------------

#------------------Parametric-----------------

rm(list = ls(all = TRUE))

dados <- read.csv("vrp_data.csv", sep = ",", dec = ".");

#Premises for carrying out the parametric time test

model <- aov(fitness ~ metodo, data = dados);

#Durbin-Watson to check independence
dwtest(model)

#Fligner-Killeen to check homoscedasticity
fligner.test (fitness ~ metodo, data = dados)

#Shapiro-Wilk to check normality
shapiro.test(resid(model))
qqnorm(resid(model))
qqline(resid(model))

#Premises for carrying out the parametric time test

modelt <- aov(time ~ metodo, data = dados);

#Durbin-Watson to check independence
dwtest(modelt)

#Fligner-Killeen to check homoscedasticity
fligner.test (time ~ metodo, data = dados)

#Shapiro-Wilk to check normality
shapiro.test(resid(model))
qqnorm(resid(modelt))
qqline(resid(modelt))

#------------------Non-Parametric-------------

rm(list = ls(all = TRUE))

dados <- read.csv("vrp_data.csv", sep = ",", dec = ".")

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

#-------------------Statistical Analysis - UPMSP-ST---------------------

#------------------Parametric-----------------

rm(list = ls(all = TRUE))

dados <- read.csv("pmp_data.csv", sep = ",", dec = ".");

#Assumptions for carrying out the parametric Fitness test

model <- aov(fitness ~ metodo, data = dados);

#Durbin-Watson to check independence
dwtest(model)

#Fligner-Killeen to check homoscedasticity
fligner.test (fitness ~ metodo, data = dados)

#Shapiro-Wilk to check normality
shapiro.test(resid(model))
qqnorm(resid(model))
qqline(resid(model))

#Premises for carrying out the parametric time test

modelt <- aov(time ~ metodo, data = dados);

#Durbin-Watson to check independence
dwtest(modelt)

#Fligner-Killeen to check homoscedasticity
fligner.test (time ~ metodo, data = dados)

#Shapiro-Wilk to check normality
shapiro.test(resid(model))
qqnorm(resid(modelt))
qqline(resid(modelt))

#------------------Non-Parametric-------------

rm(list = ls(all = TRUE))

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
