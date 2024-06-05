library(dplyr)
library(ggplot2)
#library(lmtest)
library(reshape2)

rm(list = ls(all = TRUE))

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("vrp_instances.txt", header = T)
melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo);

results <- read.csv("vrp_results.csv", header = T);

tb_mean <- c(mean(results$one_m_g), mean(results$two_m_g), mean(results$four_m_g), mean(results$eight_m_g),mean(results$ten_m_g),mean(results$twenty_m_g),mean(results$thirty_m_g),mean(results$forty_m_g),mean(results$fifty_m_g),mean(results$sixty_m_g)) 
tb_min <- c(mean(results$one_g), mean(results$two_g), mean(results$four_g), mean(results$eight_g),mean(results$ten_g),mean(results$twenty_g),mean(results$thirty_g),mean(results$forty_g),mean(results$fifty_g),mean(results$sixty_g)) 
tb_med <- c(mean(results$one_md_g), mean(results$two_md_g), mean(results$four_md_g), mean(results$eight_md_g), mean(results$ten_md_g), mean(results$twenty_md_g), mean(results$thirty_md_g), mean(results$forty_md_g), mean(results$fifty_md_g), mean(results$sixty_md_g))
tb_mean_time <- c(mean(results$one_m_time), mean(results$two_m_time), mean(results$four_m_time), mean(results$eight_m_time),mean(results$ten_m_time),mean(results$twenty_m_time), mean(results$thirty_m_time), mean(results$forty_m_time), mean(results$fifty_m_time), mean(results$sixty_m_time)) 
tb_med_time <- c(mean(results$one_md_time), mean(results$two_md_time), mean(results$four_md_time), mean(results$eight_md_time),mean(results$ten_md_time),mean(results$twenty_md_time), mean(results$thirty_md_time),mean(results$forty_md_time), mean(results$fifty_md_time), mean(results$sixty_md_time)) 
tb_min_time <- c(mean(results$one_time),mean(results$two_time), mean(results$four_time), mean(results$eight_time), mean(results$ten_time), mean(results$twenty_time), mean(results$thirty_time), mean(results$forty_time), mean(results$fifty_time), mean(results$sixty_time))

#--------Graph of average gap values (%)--------------------

df <- data.frame(quantidade_agentes = c(1,2,4,8,10,20,30,40,50,60),
                 melhor= tb_min,
                 media = tb_mean,
                 mediana= tb_med )

df <- melt(df,  id.vars = 'quantidade_agentes', variable.name = 'legenda')

plot(df$quantidade_agente,df$value, col = df$legenda, pch = c(rep(19,10),rep(15,10),rep(17,10)), ylab = "gap(%)", xlab = "Number of Agents", xaxt = 'n');
legend("topright",inset=c(0.02,0.05), legend = c("Best", "Average", "Median"), col=c("black", "red", "green"), pch = c(19,15,17), xpd=TRUE, horiz=TRUE, bty="n")
axis(side = 1, at = c(1, 2, 4, 8, 10, 20, 30, 40, 50, 60), 
     labels = c("One", "Two", "Four", "Eight", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty"),
     las = 2, cex.axis = 0.8)

#--------Graph of average computational time--------------------

time <- results[, c("one_m_time", "two_m_time", "four_m_time", "eight_m_time", "ten_m_time", "twenty_m_time", "thirty_m_time", "forty_m_time", "fifty_m_time", "sixty_m_time")]
average_time <- colMeans(time)

boxplot(time, ylab = "Computational Time", xaxt = 'n');
legend("topright",inset=c(0.02,0.0005), legend = c("Average Time"), col=c("red"), pch = c(16), xpd=TRUE, horiz=TRUE, bty="n")
axis(side = 1, at = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), 
     labels = c("One", "Two", "Four", "Eight", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty"),
     las = 2, cex.axis = 0.8)
points(seq_along(average_time), average_time, col = "red", pch = 16)

#--------Graph of average gap values (%) - logarithmic scale--------------------

plot(log(df$quantidade_agentes),log(df$value), col = df$legenda, pch = c(rep(19,10),rep(15,10),rep(17,10)), ylab = "Log gap(%)", xlab = "Log Number of Agents", xaxt = 'n');
legend("topright",inset=c(0.02, 0.01), legend = c("Best", "Average", "Median"), col=c("black", "red", "green"), pch = c(19,15,17), xpd=TRUE, horiz=TRUE, bty="n")
axis(side=1, at = round(log(1),2),las=2)
axis(side=1, at = round(log(2),2),las=2)
axis(side=1, at = round(log(4),2),las=2)
axis(side=1, at = round(log(8),2),las=2)
axis(side=1, at = round(log(10),2),las=2)
axis(side=1, at = round(log(20),2),las=2)
axis(side=1, at = round(log(30),2),las=2)
axis(side=1, at = round(log(40),2),las=2)
axis(side=1, at = round(log(50),2),las=2)
axis(side=1, at = round(log(60),2),las=2)

#--------Linear Regression--------------------

df <- data.frame(quantidade_agentes = c(log(1),log(2),log(4),log(8),log(10),log(20),log(30),log(40),log(50),log(60)),
                 melhor= log(tb_min),
                 media = log(tb_mean),
                 mediana= log(tb_med),
                 melhor_time = tb_min_time,
                 media_time = tb_mean_time,
                 mediana_time= tb_med_time)

modelo_media <- lm(data = df, formula = media ~ quantidade_agentes)
modelo_mediana <- lm(data = df, formula = mediana ~ quantidade_agentes)
modelo_melhor <- lm(data = df, formula = melhor ~ quantidade_agentes)
modelo_media_time <- lm(data = df, formula = media_time ~ quantidade_agentes)
modelo_mediana_time <- lm(data = df, formula = mediana_time ~ quantidade_agentes)
modelo_melhor_time <- lm(data = df, formula = melhor_time ~ quantidade_agentes)

#--------Linear Regression gap values (%)--------------------

#--------LR Average----------

modelo_media$coefficients
summary(modelo_media)

#--------LR Median----------

modelo_mediana$coefficients
summary(modelo_mediana)

#--------LR Best----------

modelo_melhor$coefficients
summary(modelo_melhor)

g1 <- ggplot(df, aes(x=quantidade_agentes, y=media)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)
g2 <- ggplot(df, aes(x=quantidade_agentes, y=mediana)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)
g3 <- ggplot(df, aes(x=quantidade_agentes, y=melhor)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)

g1 / g2 / g3

#--------Linear Regression Computational Time--------------------

#--------LR Average----------

modelo_media_time$coefficients
summary(modelo_media_time)

#--------LR Median----------

modelo_mediana_time$coefficients
summary(modelo_mediana_time)

#--------LR Best----------

modelo_melhor_time$coefficients
summary(modelo_melhor_time)

t1 <- ggplot(df, aes(x=quantidade_agentes, y=media_time)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)
t2 <- ggplot(df, aes(x=quantidade_agentes, y=mediana_time)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)
t3 <- ggplot(df, aes(x=quantidade_agentes, y=melhor_time)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)

t1 / t2 / t3