rm(list = ls(all = TRUE))

setwd(getwd())

melhor <- read.delim("instances_pmp2.txt");

results <- read.delim("results_50.txt", header = T)

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

#instance<-"I_50_10_S_1-9_1"
for(instance in melhor$instance){
 
  d_1 <- results[results$instance == instance & results$metodo == "OneAgent", c("fitness", "time")]
  d_2 <- results[results$instance == instance & results$metodo == "TwoAgent", c("fitness", "time")]
  d_4 <- results[results$instance == instance & results$metodo == "FourAgent", c("fitness", "time")]
  d_8 <- results[results$instance == instance & results$metodo == "EightAgent", c("fitness", "time")]
  d_10 <- results[results$instance == instance & results$metodo == "TenAgent", c("fitness", "time")]
  d_20 <- results[results$instance == instance & results$metodo == "TwentyAgent", c("fitness", "time")]
  d_30 <- results[results$instance == instance & results$metodo == "ThirtyAgent", c("fitness", "time")]
  d_40 <- results[results$instance == instance & results$metodo == "FortyAgent", c("fitness", "time")]
  d_50 <- results[results$instance == instance & results$metodo == "FiftyAgent", c("fitness", "time")]
  d_60 <- results[results$instance == instance & results$metodo == "SixtyAgent", c("fitness", "time")]
  
  dados2 <-data.frame(one = d_1$results,
                      two = d_2$results,
                      four = d_4$results,
                      eight = d_8$results,
                      ten = d_10$results,
                      twenty = d_20$results,
                      thirty = d_30$results,
                      forty = d_40$results,
                      fifty = d_50$results,
                      sixty = d_60$results)
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
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(01),
                    results = d_1$fitness,
                    time = d_1$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(02),
                    results = d_2$fitness,
                    time = d_2$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(04),
                    results = d_4$fitness,
                    time = d_4$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(08),
                    results = d_8$fitness,
                    time = d_8$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(10),
                    results = d_10$fitness,
                    time = d_10$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(20),
                    results = d_20$fitness,
                    time = d_20$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(30),
                    results = d_30$fitness,
                    time = d_30$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(40),
                    results = d_40$fitness,
                    time = d_40$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
                    tratamento = rep(50),
                    results = d_50$fitness,
                    time = d_50$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instance == instance, 2],
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

#dados_time <- read.csv("pmp_dados_time.csv", sep = "", dec = ".");
dados_g <- read.csv("results_pmp.csv", sep = ",", dec = ".");

agentes <- c(1, 2, 4, 8, 10, 20, 30, 40, 50, 60)

fo <- c(mean(dados_g$one_m), mean(dados_g$two_m), mean(dados_g$four_m), mean(dados_g$eight_m), mean(dados_g$ten_m), mean(dados_g$twenty_m), mean(dados_g$thirty_m), mean(dados_g$forty_m), mean(dados_g$fifty_m), mean(dados_g$sixty_m))
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

## Substituir os números no eixo x pelos equivalentes em inglês
nomes_ingles <- c("one", "two", "four", "eight", "ten", "twenty", "thirty", "forty", "fifty", "sixty")
axis(side=1, at=agentes, labels=nomes_ingles, las = 2, cex.axis = 0.8)
mtext("Number of Agents",side=1,col="black",line=2.5) 

legend("topleft",inset=c(0.4,-0.01),legend=c("Objective Function","Time"), text.col=c("black","red"),pch=c(16,15),col=c("black","red"),  xpd=TRUE, horiz=TRUE, bty="n")
