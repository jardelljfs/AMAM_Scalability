library("scatterplot3d")

instance = "R210"
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

#boxplot(tempo)
agentes = c(1,2,4,8,10,20,30,40,50,60)
t = c(mean(tempo$one),mean(tempo$two),mean(tempo$four),mean(tempo$eight),mean(tempo$ten),mean(tempo$twenty),mean(tempo$thirty),mean(tempo$forty),mean(tempo$fifty),mean(tempo$sixty))
s = c(mean(d_1$results),mean(d_2$results),mean(d_4$results),mean(d_8$results),mean(d_10$results),mean(d_20$results),mean(d_30$results),mean(d_40$results),mean(d_50$results),mean(d_60$results))

scatterplot3d(agentes, t, s, angle = 55, pch = 16, color = "red", type = "h", grid=TRUE, box=FALSE, xlab="Quantidade de Agentes", zlab="Função Objetivo", ylab="Tempo",main="Quantidade de Agentes x FO (Média) x Tempo (Média) - R210")

t = c(median(tempo$one),median(tempo$two),median(tempo$four),median(tempo$eight),median(tempo$ten),median(tempo$twenty),median(tempo$thirty),median(tempo$forty),median(tempo$fifty),median(tempo$sixty))
s = c(median(d_1$results),median(d_2$results),median(d_4$results),median(d_8$results),median(d_10$results),median(d_20$results),median(d_30$results),median(d_40$results),median(d_50$results),median(d_60$results))

scatterplot3d(agentes, t, s, angle = 55, pch = 16, color = "red", type = "h", grid=TRUE, box=FALSE, xlab="Quantidade de Agentes", zlab="Função Objetivo", ylab="Tempo",main="Quantidade de Agentes x FO (Mediana) x Tempo (Mediana) - R210")