#library(data.table)

rm(list = ls(all = TRUE))

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("instances_pmp2.txt", header = T)
#colnames(instances) <- c("instance", "fitness")

dados <- read.delim("results_50_1_60_60.txt", header = T)

for(instance in melhor$instance){
  dados$fitness <- ifelse(dados$instance == instance & dados$fitness < melhor[melhor$instance == instance, 4], melhor[melhor$instance == instance, 4], dados$fitness)
}

write.csv(dados, file = "results_50_1_60_60.csv", row.names = FALSE)
