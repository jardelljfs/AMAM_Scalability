#library(data.table)

rm(list = ls(all = TRUE))

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("instances_pmp2.txt", header = T)
#colnames(instances) <- c("instance", "fitness")

dados <- read.delim("results_50.txt", header = T)

results <- data.frame(instance= character(), 
                      literatura = double(),
                      one = double(),one_m = double(),one_md = double(), one_g = double(),one_m_g = double(),one_md_g = double(),
                      two = double(),two_m = double(),two_md = double(), two_g = double(),two_m_g = double(),two_md_g = double(),
                      four = double(),four_m = double(),fou_md = double(), four_g = double(),four_m_g = double(),fou_md_g = double(),
                      eight = double(),eight_m = double(),eight_md = double(), eight_g = double(),eight_m_g = double(),eight_md_g = double(),
                      ten = double(),ten_m = double(),ten_md = double(), ten_g = double(),ten_m_g = double(),ten_md_g = double(),
                      twenty = double(),twenty_m = double(),twenty_md = double(), twenty_g = double(),twenty_m_g = double(),twenty_md_g = double(),
                      thirty = double(),thirty_m = double(),thirty_md = double(), thirty_g = double(),thirty_m_g = double(),thirty_md_g = double(),
                      forty = double(),forty_m = double(),forty_md = double(), forty_g = double(),forty_m_g = double(),forty_md_g = double(),
                      fifty = double(),fifty_m = double(),fifty_md = double(), fifty_g = double(),fifty_m_g = double(),fifty_md_g = double(),
                      sixty = double(),sixty_m = double(), sixty_md = double(), sixty_g = double(),sixty_m_g = double(), sixty_md_g = double());

#instance <- "I_50_10_S_1-9_1"

for(instance in melhor$instance){
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
                      one = if (min(d_1$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_1$fitness) },
                      one_m = if (mean(d_1$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_1$fitness) },
                      one_md = if (median(d_1$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_1$fitness) },
                      one_m_time = mean(d_1$time),
                      one_md_time = median(d_1$time),
                      one_time = min(d_1$time),
                      
                      two = if (min(d_2$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_2$fitness) },
                      two_m = if (mean(d_2$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_2$fitness) },
                      two_md = if (median(d_2$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_2$fitness) },
                      two_m_time = mean(d_2$time),
                      two_md_time = median(d_2$time),
                      two_time = min(d_2$time),
                      
                      four = if (min(d_4$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_4$fitness) },
                      four_m = if (mean(d_4$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_4$fitness) },
                      four_md = if (median(d_4$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_4$fitness) },
                      four_m_time = mean(d_4$time),
                      four_md_time = median(d_4$time),
                      four_time = min(d_4$time),
                      
                      eight = if (min(d_8$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_8$fitness) },
                      eight_m = if (mean(d_8$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_8$fitness) },
                      eight_md = if (median(d_8$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_8$fitness) },
                      eight_m_time = mean(d_8$time),
                      eight_md_time = median(d_8$time),
                      eight_time = min(d_8$time),
                      
                      ten = if (min(d_10$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_10$fitness) },
                      ten_m = if (mean(d_10$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_10$fitness) },
                      ten_md = if (median(d_10$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_10$fitness) },
                      ten_m_time = mean(d_10$time),
                      ten_md_time = median(d_10$time),
                      ten_time = min(d_10$time),
                      
                      twenty = if (min(d_20$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_20$fitness) },
                      twenty_m = if (mean(d_20$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_20$fitness) },
                      twenty_md = if (median(d_20$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_20$fitness) },
                      twenty_m_time = mean(d_20$time),
                      twenty_md_time = median(d_20$time),
                      twenty_time = min(d_20$time),
                      
                      thirty = if (min(d_30$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_30$fitness) },
                      thirty_m = if (mean(d_30$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_30$fitness) },
                      thirty_md = if (median(d_30$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_30$fitness) },
                      thirty_m_time = mean(d_30$time),
                      thirty_md_time = median(d_30$time),
                      thirty_time = min(d_30$time),
                      
                      forty = if (min(d_40$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_40$fitness) },
                      forty_m = if (mean(d_40$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_40$fitness) },
                      forty_md = if (median(d_40$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_40$fitness) },
                      forty_m_time = mean(d_40$time),
                      forty_md_time = median(d_40$time),
                      forty_time = min(d_40$time),
                      
                      fifty = if (min(d_50$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_50$fitness) },
                      fifty_m = if (mean(d_50$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_50$fitness) },
                      fifty_md = if (median(d_50$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_50$fitness) },
                      fifty_m_time = mean(d_50$time),
                      fifty_md_time = median(d_50$time),
                      fifty_time = min(d_50$time),
                      
                      sixty = if (min(d_60$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ min(d_60$fitness) },
                      sixty_m = if (mean(d_60$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ mean(d_60$fitness) },
                      sixty_md = if (median(d_60$fitness) < melhor[melhor$instance == instance, 4]) { melhor[melhor$instance == instance, 4] } else{ median(d_60$fitness)},
                      sixty_m_time = mean(d_60$time),
                      sixty_md_time = median(d_60$time),
                      sixty_time = min(d_60$time))
  
  results <- rbind(results, linha)
}

results = data.frame(results, one_g = (results$one - results$literatura)/results$literatura, 
                     one_m_g = (results$one_m - results$literatura)/results$literatura, 
                     one_md_g = (results$one_md - results$literatura)/results$literatura,
                     one_time_g = (results$one_m_time-results$one_time)/results$one_time,
                     
                     two_g = (results$two - results$literatura)/results$literatura, 
                     two_m_g = (results$two_m - results$literatura)/results$literatura, 
                     two_md_g = (results$two_md - results$literatura)/results$literatura, 
                     two_time_g = (results$two_m_time-results$two_time)/results$two_time,
                     
                     four_g = (results$four - results$literatura)/results$literatura,
                     four_m_g = (results$four_m - results$literatura)/results$literatura, 
                     four_md_g = (results$four_md - results$literatura)/results$literatura, 
                     four_time_g = (results$four_m_time-results$four_time)/results$four_time,
                     
                     eight_g = (results$eight - results$literatura)/results$literatura, 
                     eight_m_g = (results$eight_m - results$literatura)/results$literatura, 
                     eight_md_g = (results$eight_md - results$literatura)/results$literatura, 
                     eight_time_g = (results$eight_m_time-results$eight_time)/results$eight_time,
                     
                     ten_g = (results$ten - results$literatura)/results$literatura, 
                     ten_m_g = (results$ten_m - results$literatura)/results$literatura, 
                     ten_md_g = (results$ten_md - results$literatura)/results$literatura, 
                     ten_time_g = (results$ten_m_time-results$ten_time)/results$ten_time,
                     
                     twenty_g = (results$twenty - results$literatura)/results$literatura, 
                     twenty_m_g = (results$twenty_m - results$literatura)/results$literatura, 
                     twenty_md_g = (results$twenty_md - results$literatura)/results$literatura, 
                     twenty_time_g = (results$twenty_m_time-results$twenty_time)/results$twenty_time,
                     
                     thirty_g = (results$thirty - results$literatura)/results$literatura, 
                     thirty_m_g = (results$thirty_m - results$literatura)/results$literatura, 
                     thirty_md_g = (results$thirty_md - results$literatura)/results$literatura, 
                     thirty_time_g = (results$thirty_m_time-results$thirty_time)/results$thirty_time,
                     
                     forty_g = (results$forty - results$literatura)/results$literatura, 
                     forty_m_g = (results$forty_m - results$literatura)/results$literatura, 
                     forty_md_g = (results$forty_md - results$literatura)/results$literatura, 
                     forty_time_g = (results$forty_m_time-results$forty_time)/results$forty_time,
                     
                     fifty_g = (results$fifty - results$literatura)/results$literatura,
                     fifty_m_g = (results$fifty_m - results$literatura)/results$literatura, 
                     fifty_md_g = (results$fifty_md - results$literatura)/results$literatura, 
                     fifty_time_g = (results$fifty_m_time-results$fifty_time)/results$fifty_time,
                     
                     sixty_g = (results$sixty - results$literatura)/results$literatura,
                     sixty_m_g = (results$sixty_m - results$literatura)/results$literatura,
                     sixty_md_g = (results$sixty_md - results$literatura)/results$literatura,
                     sixty_time_g = (results$sixty_m_time - results$sixty_time)/results$sixty_time)

write.csv(results, file = "results_pmp.csv", row.names = FALSE)

planilha_fo <- results[, c("instance", "literatura", "one", "two", "four", "eight", "ten", "twenty", "thirty", "forty", "fifty", "sixty")]
write.csv(planilha_fo, file = "planilha_fo.csv", row.names = FALSE)

planilha_time <- results[, c("instance", "one_m_time", "two_m_time", "four_m_time", "eight_m_time", "ten_m_time", "twenty_m_time", "thirty_m_time", "forty_m_time", "fifty_m_time", "sixty_m_time")]
write.csv(planilha_time, file = "planilha_time.csv", row.names = FALSE)

best_gap <- results[, c("one_g", "two_g", "four_g", "eight_g", "ten_g", "twenty_g", "thirty_g", "forty_g", "fifty_g", "sixty_g")]
average_gap <- results[, c("one_m_g", "two_m_g", "four_m_g", "eight_m_g", "ten_m_g", "twenty_m_g", "thirty_m_g", "forty_m_g", "fifty_m_g", "sixty_m_g")]
median_gap <- results[, c("one_md_g", "two_md_g", "four_md_g", "eight_md_g", "ten_md_g", "twenty_md_g", "thirty_md_g", "forty_md_g", "fifty_md_g", "sixty_md_g")]
average_time <- results[, c("one_m_time", "two_m_time", "four_m_time", "eight_m_time", "ten_m_time", "twenty_m_time", "thirty_m_time", "forty_m_time", "fifty_m_time", "sixty_m_time")]
median_time <- results[, c("one_md_time", "two_md_time", "four_md_time", "eight_md_time", "ten_md_time", "twenty_md_time", "thirty_md_time", "forty_md_time", "fifty_md_time", "sixty_md_time")]

best_gap <- colMeans(best_gap)
average_gap <- colMeans(average_gap)
median_gap <- colMeans(median_gap)
quantidade <- c(sum(results$one == results$literatura), sum(results$two == results$literatura), sum(results$four == results$literatura), sum(results$eight == results$literatura), sum(results$ten == results$literatura), sum(results$twenty == results$literatura), sum(results$thirty == results$literatura), sum(results$forty == results$literatura), sum(results$fifty == results$literatura), sum(results$sixty == results$literatura))
average_time <- colMeans(average_time)
median_time <- colMeans(median_time)

resumo <- data.frame()
resumo <- rbind(resumo,best_gap)
resumo <- rbind(resumo,average_gap)
resumo <- rbind(resumo,median_gap)
resumo <- rbind(resumo,quantidade)
resumo <- rbind(resumo,average_time)
resumo <- rbind(resumo,median_time)

colnames(resumo) <- c("one", "two", "four", "eight", "ten", "twenty", "thirty", "forty", "fifty", "sixty")
write.csv(resumo, file = "resumo.csv", row.names = FALSE)

tb_mean <- c(mean(results$one_m_g), mean(results$two_m_g), mean(results$four_m_g), mean(results$eight_m_g),mean(results$ten_m_g),mean(results$twenty_m_g),mean(results$thirty_m_g),mean(results$forty_m_g),mean(results$fifty_m_g),mean(results$sixty_m_g)) 
tb_min <- c(mean(results$one_g), mean(results$two_g), mean(results$four_g), mean(results$eight_g),mean(results$ten_g),mean(results$twenty_g),mean(results$thirty_g),mean(results$forty_g),mean(results$fifty_g),mean(results$sixty_g)) 
tb_med <- c(mean(results$one_md_g), mean(results$two_md_g), mean(results$four_md_g), mean(results$eight_md_g), mean(results$ten_md_g), mean(results$twenty_md_g), mean(results$thirty_md_g), mean(results$forty_md_g), mean(results$fifty_md_g), mean(results$sixty_md_g))
tb_mean_time <- c(mean(results$one_m_time), mean(results$two_m_time), mean(results$four_m_time), mean(results$eight_m_time),mean(results$ten_m_time),mean(results$twenty_m_time), mean(results$thirty_m_time), mean(results$forty_m_time), mean(results$fifty_m_time), mean(results$sixty_m_time)) 
tb_med_time <- c(mean(results$one_md_time), mean(results$two_md_time), mean(results$four_md_time), mean(results$eight_md_time),mean(results$ten_md_time),mean(results$twenty_md_time), mean(results$thirty_md_time),mean(results$forty_md_time), mean(results$fifty_md_time), mean(results$sixty_md_time)) 
tb_min_time <- c(mean(results$one_time),mean(results$two_time), mean(results$four_time), mean(results$eight_time), mean(results$ten_time), mean(results$twenty_time), mean(results$thirty_time), mean(results$forty_time), mean(results$fifty_time), mean(results$sixty_time))

df <- data.frame(quantidade_agentes = c(1,2,4,8,10,20,30,40,50,60),
                 melhor= tb_min,
                 media = tb_mean,
                 mediana= tb_med )

df <- melt(df ,  id.vars = 'quantidade_agentes', variable.name = 'legenda')

plot(df$quantidade_agente,df$value, col = df$legenda, pch = c(rep(19,10),rep(15,10),rep(17,10)), ylab = "gap(%)", xlab = "Number of Agents", xaxt = 'n');
legend("topright",inset=c(0.02,0.05), legend = c("Best", "Average", "Median"), col=c("black", "red", "green"), pch = c(19,15,17), xpd=TRUE, horiz=TRUE, bty="n")
axis(side = 1, at = c(1, 2, 4, 8, 10, 20, 30, 40, 50, 60), 
     labels = c("One", "Two", "Four", "Eight", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty"),
     las = 2, cex.axis = 0.8)

#--------TEMPO COMPUTACIONAL
time <- results[, c("one_m_time", "two_m_time", "four_m_time", "eight_m_time", "ten_m_time", "twenty_m_time", "thirty_m_time", "forty_m_time", "fifty_m_time", "sixty_m_time")]
average_time <- colMeans(time)

boxplot(time, ylab = "Computational Time", xaxt = 'n');
legend("topright",inset=c(0.02,0.0005), legend = c("Average Time"), col=c("red"), pch = c(16), xpd=TRUE, horiz=TRUE, bty="n")
axis(side = 1, at = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), 
     labels = c("One", "Two", "Four", "Eight", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty"),
     las = 2, cex.axis = 0.8)
points(seq_along(average_time), average_time, col = "red", pch = 16)

#--------LOG FO

plot(log(df$quantidade_agentes),log(df$value), col = df$legenda, pch = c(rep(19,10),rep(15,10),rep(17,10)), ylab = "Log gap(%)", xlab = "Log Number of Agents", xaxt = 'n');
legend("topright",inset=c(0.02, 0.01), legend = c("Best", "Average", "Median"), col=c("black", "red", "green"), pch = c(19,15,17), xpd=TRUE, horiz=TRUE, bty="n")
#axis(1, #ylim=c(0,7000), col="red",col.axis="red",las=1)
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
#abline(h=seq(-4,0,0.02),v=seq(0,5,0.5),lty=3,col="gray")

#regressão sobre mediana
df <- data.frame(quantidade_agentes = c(log(1),log(2),log(4),log(8),log(10),log(20),log(30),log(40),log(50),log(60)),
                 melhor= log(tb_min),
                 media = log(tb_mean),
                 mediana= log(tb_med),
                 melhor_time = tb_min_time,
                 media_time = tb_mean_time,
                 mediana_time= tb_med_time)

#ggplot(df, aes(x = quantidade_agentes, y = mediana)) + geom_point()
modelo_media <- lm(data = df, formula = media ~ quantidade_agentes)
modelo_mediana <- lm(data = df, formula = mediana ~ quantidade_agentes)
modelo_melhor <- lm(data = df, formula = melhor ~ quantidade_agentes)
modelo_media_time <- lm(data = df, formula = media_time ~ quantidade_agentes)
modelo_mediana_time <- lm(data = df, formula = mediana_time ~ quantidade_agentes)
modelo_melhor_time <- lm(data = df, formula = melhor_time ~ quantidade_agentes)

show("Regressão Linear gap FO")

show("Média")

modelo_media$coefficients
summary(modelo_media)

show("Mediana")

modelo_mediana$coefficients
summary(modelo_mediana)

show("Melhor")

modelo_melhor$coefficients
summary(modelo_melhor)

show("Regressão Linear Tempo Computacional")

show("Média")

modelo_media_time$coefficients
summary(modelo_media_time)

show("Mediana")

modelo_mediana_time$coefficients
summary(modelo_mediana_time)

show("Melhor")

modelo_melhor_time$coefficients
summary(modelo_melhor_time)

require(patchwork)
require(ggplot2)
require(magrittr)

g1 <- ggplot(df, aes(x=quantidade_agentes, y=media)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)
g2 <- ggplot(df, aes(x=quantidade_agentes, y=mediana)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)
g3 <- ggplot(df, aes(x=quantidade_agentes, y=melhor)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)

g1
g2
g3
g1 / g2 / g3

t1 <- ggplot(df, aes(x=quantidade_agentes, y=media_time)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)
t2 <- ggplot(df, aes(x=quantidade_agentes, y=mediana_time)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)
t3 <- ggplot(df, aes(x=quantidade_agentes, y=melhor_time)) + geom_point() + ggtitle("") + ylab("") + xlab("") + geom_smooth(method = lm, se = FALSE)

t1
t2
t3
t1 / t2 / t3
