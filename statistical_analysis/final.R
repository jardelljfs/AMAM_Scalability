instance <- "R210"

  d_1 <- read.delim(paste("results_final/Results_BestSolutionNTry-OneAgent-30-",instance,"-.txt", sep = ""))
  d_2 <- read.delim(paste("results_final/Results_BestSolutionNTry-TwoAgent-30-",instance,"-.txt", sep = ""))
  d_4 <- read.delim(paste("results_final/Results_BestSolutionNTry-FourAgent-30-",instance,"-.txt", sep = ""))
  d_8 <- read.delim(paste("results_final/Results_BestSolutionNTry-EightAgent-30-",instance,"-.txt", sep = ""))
  d_10 <- read.delim(paste("results_final/Results_BestSolutionNTry-TenAgent-30-",instance,"-.txt", sep = ""))
  d_20 <- read.delim(paste("results_final/Results_BestSolutionNTry-TwentyAgent-30-",instance,"-.txt", sep = ""))
  d_30 <- read.delim(paste("results_final/Results_BestSolutionNTry-ThirtyAgent-30-",instance,"-.txt", sep = ""))
  d_40 <- read.delim(paste("results_final/Results_BestSolutionNTry-FortyAgent-30-",instance,"-.txt", sep = ""))
  d_50 <- read.delim(paste("results_final/Results_BestSolutionNTry-FiftyAgent-30-",instance,"-.txt", sep = ""))
  d_60 <- read.delim(paste("results_final/Results_BestSolutionNTry-SixtyAgent-30-",instance,"-.txt", sep = ""))
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
  
  melhor <- read.delim("melhor_total.txt");
  melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo)
  
  dados <-data.frame(one = d_1$results,
                     two = d_2$results,
                     four = d_4$results,
                     eight = d_8$results,
                     ten = d_10$results,
                     twenty = d_20$results,
                     thirty = d_30$results,
                     forty = d_40$results,
                     fifty = d_50$results,
                     sixty = d_60$results)
  boxplot(dados, xlab = "Número de Agentes", ylab = "Função Objetivo")
  
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
  legend("topright",inset=c(0,0.018), legend = c("Média do Agente", "Melhor Solução do Agente", "Melhor Solucão da Literatura"), col=c("red", "blue", "green"), pch = 19, xpd=TRUE, horiz=TRUE, bty="n")
  
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
  
  boxplot(tempo, ylab = "Tempo Computacional(s)", xlab = "Número de Agentes")