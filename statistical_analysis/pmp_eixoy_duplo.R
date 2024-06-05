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
