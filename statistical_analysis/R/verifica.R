#library(data.table)

rm(list = ls(all = TRUE))

#setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("vrp_instances.txt", header = T)
melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo);

dados <- read.delim("_vrp_1_60_60.csv", header = T, sep=",")

for(instance in melhor$instance){
  dados$fitness <- ifelse(dados$instance == instance & dados$fitness < melhor[melhor$instance == instance, 4], melhor[melhor$instance == instance, 4], dados$fitness)
}

write.csv2(dados, file = "vrp_data.csv", row.names = FALSE)
write.csv(dados, "vrp_data.csv", quote = TRUE, row.names = FALSE)
write.csv(dados, file = "vrp_1_60_60.csv", row.names = FALSE, sep=",")

#----------------------------------

rm(list = ls(all = TRUE))

setwd(getwd())

melhor <- read.delim("vrp_instances.txt");
melhor <- data.frame(melhor, results = melhor$n * 1000 + melhor$fo);

metodos <- c("SixtyAgent")#, "TwoAgent", "FourAgent", "EightAgent", "TenAgent", "TwentyAgent", "ThirtyAgent", "FortyAgent", "FiftyAgent", "SixtyAgent")

results <- data.frame(instance = character(), 
                      metodo = character(),
                      exec = integer(),
                      fo = double(),
                      n = integer(),
                      time= double(),
                      fitness = double())

for(instance in melhor$instancia){
  print(instance)
  for(metodo in metodos){
    for(agent in 0:59){
      #instance <- "C101"
      #metodo <- "SixtyAgent"
      #agent <- 0
      
      d <- read.delim(paste("results_final/Results_NTry-",metodo,"-30-",instance,"-",agent,".txt", sep = ""), header = F)
      colnames(d) <- c("fo", "n", "time")
      #d <- tail(d, n = 1)
      d <- data.frame(d, fitness = d$n * 1000 + d$fo)
    
      linha <- data.frame(instance = rep(instance,30), 
                        metodo = rep(metodo,30),
                        exec = seq(0, 29),
                        fo = d$fo,
                        n = d$n,
                        time= d$time,
                        fitness = d$fitness)
    
      results <- rbind(results, linha)
    }
  }
}

write.csv(results, file = "_vrp_1_60_60.csv", row.names = FALSE, sep=",")
