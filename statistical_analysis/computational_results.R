
#-------------------Section Computational Results - VRPTW------------------------

rm(list = ls(all = TRUE))

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

#--------Individual Instance-----------------------------------

rm(list = ls(all = TRUE))

instance <- "R210"

dados <- read.csv("vrp_data.csv", sep = ",", dec = ".");

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

melhor <- read.delim("vrp_instances.txt");
melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo)

dados <-data.frame(one = d_1$fitness,
                   two = d_2$fitness,
                   four = d_4$fitness,
                   eight = d_8$fitness,
                   ten = d_10$fitness,
                   twenty = d_20$fitness,
                   thirty = d_30$fitness,
                   forty = d_40$fitness,
                   fifty = d_50$fitness,
                   sixty = d_60$fitness)
boxplot(dados, xlab = "Number of Agents", ylab = "Objective Function")

points.default(1,mean(dados$one),col = "red", pch = 19)
points.default(1,min(dados$one),col = "blue", pch = 19)
points.default(1,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(2,mean(dados$two),col = "red", pch = 19)
points.default(2,min(dados$two),col = "blue", pch = 19)
points.default(2,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(3,mean(dados$four),col = "red", pch = 19)
points.default(3,min(dados$four),col = "blue", pch = 19)
points.default(3,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(4,mean(dados$eight),col = "red", pch = 19)
points.default(4,min(dados$eight),col = "blue", pch = 19)
points.default(4,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(5,mean(dados$ten),col = "red", pch = 19)
points.default(5,min(dados$ten),col = "blue", pch = 19)
points.default(5,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(6,mean(dados$twenty),col = "red", pch = 19)
points.default(6,min(dados$twenty),col = "blue", pch = 19)
points.default(6,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(7,mean(dados$thirty),col = "red", pch = 19)
points.default(7,min(dados$thirty),col = "blue", pch = 19)
points.default(7,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(8,mean(dados$forty),col = "red", pch = 19)
points.default(8,min(dados$forty),col = "blue", pch = 19)
points.default(8,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(9,mean(dados$fifty),col = "red", pch = 19)
points.default(9,min(dados$fifty),col = "blue", pch = 19)
points.default(9,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
points.default(10,mean(dados$sixty),col = "red", pch = 19)
points.default(10,min(dados$sixty),col = "blue", pch = 19)
points.default(10,melhor[melhor$instancia == instance, 5],col = "green", pch = 19)
legend("topright",inset=c(0,0.018), legend = c("Agent Average", "Best of Agent", "Best of Literature"), col=c("red", "blue", "green"), pch = 19, xpd=TRUE, horiz=TRUE, bty="n")

tempo <-data.frame(one = d_1$time,
                   two = d_2$time,
                   four = d_4$time,
                   eight = d_8$time,
                   ten = d_10$time,
                   twenty = d_20$time,
                   thirty = d_30$time,
                   forty = d_40$time,
                   fifty = d_50$time,
                   sixty = d_60$time)

boxplot(tempo, ylab = "Time(s)", xlab = "Number of Agents")

#-------------------Two Axles ---------------------------

rm(list = ls(all = TRUE))

setwd(getwd())

dados_time <- read.csv("vrp_data_time.csv", dec = ".");
dados_g <- read.csv("vrp_data_fitness.csv", dec = ".");

agentes <- c(1, 2, 4, 8, 10, 20, 30, 40, 50, 60)

fo <- c(mean(dados_g$one), mean(dados_g$two), mean(dados_g$four), mean(dados_g$eight), mean(dados_g$ten), mean(dados_g$twenty), mean(dados_g$thirty), mean(dados_g$forty), mean(dados_g$fifty), mean(dados_g$sixty))
tempo <- c(mean(dados_time$one), mean(dados_time$two), mean(dados_time$four), mean(dados_time$eight), mean(dados_time$ten), mean(dados_time$twenty), mean(dados_time$thirty), mean(dados_time$forty), mean(dados_time$fifty), mean(dados_time$sixty))

## add extra space to right margin of plot within frame
par(mar=c(4, 5, 4, 5) + 0.1)

## Plot first set of data and draw its axis
plot(agentes, fo, pch=16, axes=FALSE, #ylim=c(-14,-2), 
     xlab="", ylab="", 
     type="b",col="black")
axis(2, col="black",las=1)
mtext("Objective Function (average)",side=2.5,line=3.5)

## Allow a second plot on the same graph
par(new=TRUE)

## Plot the second plot and put axis scale on right
plot(agentes, tempo, pch=15,  xlab="", ylab="", 
     axes=FALSE, type="b", col="red")
mtext("Average Time(s)",side=4,col="red",line=3)
axis(4, col="red",col.axis="red",las=1)
nomes_ingles <- c("one", "two", "four", "eight", "ten", "twenty", "thirty", "forty", "fifty", "sixty")
axis(side=1, at=agentes, labels=nomes_ingles, las = 2, cex.axis = 0.8)
mtext("Number of Agents",side=1,col="black",line=2.5) 

legend("topright",inset=c(0.4,-0.01),legend=c("Objective Function","Time"), text.col=c("black","red"),pch=c(16,15),col=c("black","red"),  xpd=TRUE, horiz=TRUE, bty="n")

#-------------------Section Computational Results - UPMSP-ST------------------------

rm(list = ls(all = TRUE))

melhor <- read.delim("pmp_instances.txt", header = T)

results <- read.csv("pmp_results.csv", header = T);

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

#--------Individual Instance-----------------------------------

rm(list = ls(all = TRUE))

instance <- "I_50_10_S_1-99_1"

dados <- read.csv("pmp_data.csv", sep = ",", dec = ".");

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

melhor <- read.delim("pmp_instances.txt");

dados <-data.frame(one = d_1$fitness,
                   two = d_2$fitness,
                   four = d_4$fitness,
                   eight = d_8$fitness,
                   ten = d_10$fitness,
                   twenty = d_20$fitness,
                   thirty = d_30$fitness,
                   forty = d_40$fitness,
                   fifty = d_50$fitness,
                   sixty = d_60$fitness)
boxplot(dados, xlab = "Number of Agents", ylab = "Objective Function")

points.default(1,mean(dados$one),col = "red", pch = 19)
points.default(1,min(dados$one),col = "blue", pch = 19)
points.default(1.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(2,mean(dados$two),col = "red", pch = 19)
points.default(2,min(dados$two),col = "blue", pch = 19)
points.default(2.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(3,mean(dados$four),col = "red", pch = 19)
points.default(3,min(dados$four),col = "blue", pch = 19)
points.default(3.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(4,mean(dados$eight),col = "red", pch = 19)
points.default(4,min(dados$eight),col = "blue", pch = 19)
points.default(4.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(5,mean(dados$ten),col = "red", pch = 19)
points.default(5,min(dados$ten),col = "blue", pch = 19)
points.default(5.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(6,mean(dados$twenty),col = "red", pch = 19)
points.default(6,min(dados$twenty),col = "blue", pch = 19)
points.default(6.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(6.9,mean(dados$thirty),col = "red", pch = 19)
points.default(7,min(dados$thirty),col = "blue", pch = 19)
points.default(7.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(7.9,mean(dados$forty),col = "red", pch = 19)
points.default(8,min(dados$forty),col = "blue", pch = 19)
points.default(8.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(8.9,mean(dados$fifty),col = "red", pch = 19)
points.default(9,min(dados$fifty),col = "blue", pch = 19)
points.default(9.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
points.default(9.9,mean(dados$sixty),col = "red", pch = 19)
points.default(10,min(dados$sixty),col = "blue", pch = 19)
points.default(10.1,melhor[melhor$instance == instance, 4],col = "green", pch = 19)
legend("topright",inset=c(0,0.018), legend = c("Agent Average", "Best of Agent", "Best of Literature"), col=c("red", "blue", "green"), pch = 19, xpd=TRUE, horiz=TRUE, bty="n")

tempo <-data.frame(one = d_1$time,
                   two = d_2$time,
                   four = d_4$time,
                   eight = d_8$time,
                   ten = d_10$time,
                   twenty = d_20$time,
                   thirty = d_30$time,
                   forty = d_40$time,
                   fifty = d_50$time,
                   sixty = d_60$time)

boxplot(tempo, ylab = "Time(s)", xlab = "Number of Agents")

#-------------------Two Axles ---------------------------

rm(list = ls(all = TRUE))

setwd(getwd())

dados_time <- read.csv("pmp_data_time.csv", dec = ".");
dados_g <- read.csv("pmp_data_fitness.csv", dec = ".");

agentes <- c(1, 2, 4, 8, 10, 20, 30, 40, 50, 60)

fo <- c(mean(dados_g$one), mean(dados_g$two), mean(dados_g$four), mean(dados_g$eight), mean(dados_g$ten), mean(dados_g$twenty), mean(dados_g$thirty), mean(dados_g$forty), mean(dados_g$fifty), mean(dados_g$sixty))
tempo <- c(mean(dados_time$one), mean(dados_time$two), mean(dados_time$four), mean(dados_time$eight), mean(dados_time$ten), mean(dados_time$twenty), mean(dados_time$thirty), mean(dados_time$forty), mean(dados_time$fifty), mean(dados_time$sixty))

## add extra space to right margin of plot within frame
par(mar=c(4, 5, 4, 5) + 0.1)

## Plot first set of data and draw its axis
plot(agentes, fo, pch=16, axes=FALSE, #ylim=c(-14,-2), 
     xlab="", ylab="", 
     type="b",col="black")
axis(2, col="black",las=1)
mtext("Objective Function (average)",side=2.5,line=3.5)

## Allow a second plot on the same graph
par(new=TRUE)

## Plot the second plot and put axis scale on right
plot(agentes, tempo, pch=15,  xlab="", ylab="", 
     axes=FALSE, type="b", col="red")
mtext("Average Time(s)",side=4,col="red",line=3)
axis(4, col="red",col.axis="red",las=1)
nomes_ingles <- c("one", "two", "four", "eight", "ten", "twenty", "thirty", "forty", "fifty", "sixty")
axis(side=1, at=agentes, labels=nomes_ingles, las = 2, cex.axis = 0.8)
mtext("Number of Agents",side=1,col="black",line=2.5) 

legend("topright",inset=c(0.4,-0.01),legend=c("Objective Function","Time"), text.col=c("black","red"),pch=c(16,15),col=c("black","red"),  xpd=TRUE, horiz=TRUE, bty="n")