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