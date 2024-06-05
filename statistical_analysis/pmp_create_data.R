rm(list = ls(all = TRUE))

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

melhor <- read.delim("pmp_instances.txt", header = T)

dados <- read.delim("pmp_data.csv", header = T, sep=",")

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
                      one = min(d_1$fitness),
                      one_m = mean(d_1$fitness),
                      one_md = median(d_1$fitness),
                      one_m_time = mean(d_1$time),
                      one_md_time = median(d_1$time),
                      one_time = min(d_1$time),
                      
                      two = min(d_2$fitness),
                      two_m = mean(d_2$fitness),
                      two_md = median(d_2$fitness),
                      two_m_time = mean(d_2$time),
                      two_md_time = median(d_2$time),
                      two_time = min(d_2$time),
                      
                      four = min(d_4$fitness),
                      four_m = mean(d_4$fitness),
                      four_md = median(d_4$fitness),
                      four_m_time = mean(d_4$time),
                      four_md_time = median(d_4$time),
                      four_time = min(d_4$time),
                      
                      eight = min(d_8$fitness),
                      eight_m = mean(d_8$fitness),
                      eight_md = median(d_8$fitness),
                      eight_m_time = mean(d_8$time),
                      eight_md_time = median(d_8$time),
                      eight_time = min(d_8$time),
                      
                      ten = min(d_10$fitness),
                      ten_m = mean(d_10$fitness),
                      ten_md = median(d_10$fitness),
                      ten_m_time = mean(d_10$time),
                      ten_md_time = median(d_10$time),
                      ten_time = min(d_10$time),
                      
                      twenty = min(d_20$fitness),
                      twenty_m = mean(d_20$fitness),
                      twenty_md = median(d_20$fitness),
                      twenty_m_time = mean(d_20$time),
                      twenty_md_time = median(d_20$time),
                      twenty_time = min(d_20$time),
                      
                      thirty = min(d_30$fitness),
                      thirty_m = mean(d_30$fitness),
                      thirty_md = median(d_30$fitness),
                      thirty_m_time = mean(d_30$time),
                      thirty_md_time = median(d_30$time),
                      thirty_time = min(d_30$time),
                      
                      forty = min(d_40$fitness),
                      forty_m = mean(d_40$fitness),
                      forty_md = median(d_40$fitness),
                      forty_m_time = mean(d_40$time),
                      forty_md_time = median(d_40$time),
                      forty_time = min(d_40$time),
                      
                      fifty = min(d_50$fitness),
                      fifty_m = mean(d_50$fitness),
                      fifty_md = median(d_50$fitness),
                      fifty_m_time = mean(d_50$time),
                      fifty_md_time = median(d_50$time),
                      fifty_time = min(d_50$time),
                      
                      sixty = min(d_60$fitness),
                      sixty_m = mean(d_60$fitness),
                      sixty_md = median(d_60$fitness),
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

#write.csv(results, file = "pmp_results.csv", row.names = FALSE)

data_fo <- results[, c("instance", "literatura", "one_m", "two_m", "four_m", "eight_m", "ten_m", "twenty_m", "thirty_m", "forty_m", "fifty_m", "sixty_m")]
colnames(data_fo) <- c("instance", "literatura", "one", "two", "four", "eight", "ten", "twenty", "thirty", "forty", "fifty", "sixty") 
#write.csv(data_fo, file = "pmp_data_fitness.csv", row.names = FALSE)

data_time <- results[, c("instance", "one_m_time", "two_m_time", "four_m_time", "eight_m_time", "ten_m_time", "twenty_m_time", "thirty_m_time", "forty_m_time", "fifty_m_time", "sixty_m_time")]
colnames(data_time) <- c("instance", "one", "two", "four", "eight", "ten", "twenty", "thirty", "forty", "fifty", "sixty") 
#write.csv(data_time, file = "pmp_data_time.csv", row.names = FALSE)

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
#write.csv(resumo, file = "pmp_summary.csv", row.names = FALSE)