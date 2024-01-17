melhor <- read.delim("/home/jardell/Documentos/artigo_escalabilidade/melhor_total");
melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo);

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

for(instance in melhor$instancia){
  
  d_1 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-OneAgent-30-",instance,"-.txt", sep = ""))
  d_2 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-TwoAgent-30-",instance,"-.txt", sep = ""))
  d_4 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-FourAgent-30-",instance,"-.txt", sep = ""))
  d_8 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-EightAgent-30-",instance,"-.txt", sep = ""))
  d_10 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-TenAgent-30-",instance,"-.txt", sep = ""))
  d_20 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-TwentyAgent-30-",instance,"-.txt", sep = ""))
  d_30 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-ThirtyAgent-30-",instance,"-.txt", sep = ""))
  d_40 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-FortyAgent-30-",instance,"-.txt", sep = ""))
  d_50 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-FiftyAgent-30-",instance,"-.txt", sep = ""))
  d_60 <- read.delim(paste("/home/jardell/Documentos/artigo_escalabilidade/results_final/Results_BestSolutionNTry-SixtyAgent-30-",instance,"-.txt", sep = ""))
  
  d_1 <- data.frame(d_1, results = d_1$n * 1000 + d_1$fo)
  d_2 <- data.frame(d_2, results = d_2$n * 1000 + d_2$fo)
  d_4 <- data.frame(d_4, results = d_4$n * 1000 + d_4$fo)
  d_8 <- data.frame(d_8, results = d_8$n * 1000 + d_8$fo)
  d_10 <- data.frame(d_10, results = d_10$n * 1000 + d_10$fo)
  d_20 <- data.frame(d_20, results = d_20$n * 1000 + d_20$fo)
  d_30 <- data.frame(d_30, results = d_30$n * 1000 + d_30$fo)
  d_40 <- data.frame(d_40, results = d_40$n * 1000 + d_40$fo)
  d_50 <- data.frame(d_50, results = d_50$n * 1000 + d_50$fo)
  d_60 <- data.frame(d_60, results = d_60$n * 1000 + d_60$fo)
  
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
  
  
  #boxplot(dados2)
  #title(paste("Result", instance))
  #boxplot(dados3)
  #title(paste("Time", instance))
  
  
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(01),
                    results = d_1$results,
                    time = d_1$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(02),
                    results = d_2$results,
                    time = d_2$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(04),
                    results = d_4$results,
                    time = d_4$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(08),
                    results = d_8$results,
                    time = d_8$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(10),
                    results = d_10$results,
                    time = d_10$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(20),
                    results = d_20$results,
                    time = d_20$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(30),
                    results = d_30$results,
                    time = d_30$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(40),
                    results = d_40$results,
                    time = d_40$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(50),
                    results = d_50$results,
                    time = d_50$time);
  dados <- rbind.data.frame(dados,aux);
  aux <- data.frame(instance = instance,
                    bloco= melhor[melhor$instancia == instance, 4],
                    tratamento = rep(60),
                    results = d_60$results,
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

dados_g <- read.delim("/home/jardell/Documentos/artigo_escalabilidade/teste_results.csv");
#dados_time <- read.delim("/home/jardell/Documentos/artigo_escalabilidade/dados_time.csv");

## set up some fake test data
agentes <- c(1, 2, 4, 8, 10, 20, 30, 40, 50, 60)

#fo <- c(mean(dados_g$one_m_g), mean(dados_g$two_m_g), mean(dados_g$four_m_g), mean(dados_g$eight_m_g), mean(dados_g$ten_m_g), mean(dados_g$twenty_m_g), mean(dados_g$thirty_m_g), mean(dados_g$forty_m_g), mean(dados_g$fifty_m_g), mean(dados_g$sixty_m_g))
fo <- c(mean(dados_g$one_m), mean(dados_g$two_m), mean(dados_g$four_m), mean(dados_g$eight_m), mean(dados_g$ten_m), mean(dados_g$twenty_m), mean(dados_g$thirty_m), mean(dados_g$forty_m), mean(dados_g$fifty_m), mean(dados_g$sixty_m))
#fo <- -0.1737173 * agentes - 2.6760706
#tempo <- c(mean(dados$one_m_time), mean(dados$two_m_time), mean(dados$four_m_time), mean(dados$eight_m_time), mean(dados$ten_m_time), mean(dados$twenty_m_time), mean(dados$thirty_m_time), mean(dados$forty_m_time), mean(dados$fifty_m_time), mean(dados$sixty_m_time))
tempo <- c(mean(dados_time$one), mean(dados_time$two), mean(dados_time$four), mean(dados_time$eight), mean(dados_time$ten), mean(dados_time$twenty), mean(dados_time$thirty), mean(dados_time$forty), mean(dados_time$fifty), mean(dados_time$sixty))

#tempo <- 0.9074146 * agentes + 137.7802250

## add extra space to right margin of plot within frame
par(mar=c(4, 5, 4, 5) + 0.1)

## Plot first set of data and draw its axis
plot(agentes, fo, pch=16, axes=FALSE, #ylim=c(-14,-2), 
     xlab="", ylab="", 
     type="b",col="black")#, main="Objective Function (average) x Average Time(s)"
axis(2, 
     #ylim=c(0,1),
     col="black",las=1)  ## las=1 makes horizontal labels
#mtext("Objective Function (average)",side=2.5,line=3.5)
mtext("Função Objetivo (média)",side=2.5,line=3.5)
#box()

## Allow a second plot on the same graph
par(new=TRUE)

## Plot the second plot and put axis scale on right
plot(agentes, tempo, pch=15,  xlab="", ylab="", #ylim=c(130,200), 
     axes=FALSE, type="b", col="red")
## a little farther out (line=4) to make room for labels
#mtext("Average Time(s)",side=4,col="red",line=3)
mtext("Tempo Médio(s)",side=4,col="red",line=3)
axis(4, #ylim=c(0,7000), 
     col="red",col.axis="red",las=1)

## Draw the time axis
axis(side=1, at=seq(1,60,59))
axis(side=1, at=seq(1,1,1))
axis(side=1, at=seq(2,2,1))
axis(side=1, at=seq(4,4,1))
axis(side=1, at=seq(8,8,1))
axis(side=1, at=seq(10,10,1))
axis(side=1, at=seq(20,20,1))
axis(side=1, at=seq(30,30,1))
axis(side=1, at=seq(40,40,1))
axis(side=1, at=seq(50,50,1))
#axis(1,pretty(range(agentes),10))
#mtext("Number of Agents",side=1,col="black",line=2.5)
mtext("Número de Agentes",side=1,col="black",line=2.5) 

## Add Legend
  #legend("topright",inset=c(0.4,-0.01),legend=c("Objective Function","Time"), text.col=c("black","red"),pch=c(16,15),col=c("black","red"),  xpd=TRUE, horiz=TRUE, bty="n")
  legend("topright",inset=c(0.4,-0.01),legend=c("Função Objetivo","Tempo"), text.col=c("black","red"),pch=c(16,15),col=c("black","red"),  xpd=TRUE, horiz=TRUE, bty="n")
  
  