library(ggplot2)

# Dados das tarefas e máquinas
tarefas <- c(1, 17, 7, 73, 3, 35, 5, 58, 8, 2, 24, 4, 46, 6)
tarefas <- c(8, 58, 5, 35, 3, 73, 7, 17, 1, 6, 46, 4, 24, 2)
maquina <- c(rep("Machine 1", 9), rep("Machine 2", 5))
tempo <- c(67, 8, 25, 7, 29, 6, 11, 2, 12, 40, 3, 26, 6, 49)
tempo <- c(12, 3, 11, 6, 29, 7, 25, 8, 67, 49, 6, 26, 4, 40)
setup <- c("1", "1 - 7", "7", "7 - 3", "3", "3 - 5", "5", "5 - 8", "8", "2", "2 - 4", "4", "4 - 6", "6")
setup <- c("JOB 8 = 12", "SETUP 5 -> 8 = 2", "JOB 5 = 11", "SETUP 3 -> 5 = 6", "JOB 3 = 29", "SETUP 7 -> 3 = 7", "JOB 7 = 25", "SETUP 1 -> 7 = 8", "JOB 1 = 67", "JOB 6 = 49", "SETUP 4 -> 6 = 6", "JOB 4 = 26", "SETUP 2 -> 4 = 3", "JOB 2 =  40")
#cores <- ifelse(tarefas %in% c(17, 73, 35, 58, 24, 46), "lightgrey", "blue")
#cores <- rainbow(14)
cores <- c("yellow", "lightgrey", "lightblue", "lightgrey", "lightgreen", "lightgrey", "orange", "lightgrey", "brown", "red",  "lightgrey", "blue", "lightgrey", "green")

# Criar um data frame com os dados
dados <- data.frame(tarefa = tarefas, maquina = maquina, tempo = tempo, setup = setup, cores =cores)

# Reordenar o fator das tarefas para corresponder à ordem desejada

dados$tarefa <- factor(dados$tarefa, levels = tarefas)
#dados$cores <- factor(dados$cores, levels = rev(cores))

valores_destacados <- c(124, 167)

# Criar o gráfico de colunas
ggplot(dados, aes(x = maquina, y = tempo, fill = tarefa)) +
  geom_col() +
  scale_fill_manual(values = cores) +
  labs(title = "",
       x = "",
       y = "Time") +
  theme_minimal() +
  theme(legend.position = "none") +
  geom_text(aes(label = setup), position = position_stack(vjust = 0.5), color = "black", size = 3) +
  scale_y_continuous(breaks = c(0, 50, 100, 124, 150, 167))


ma1 =  c(67, 8, 25, 7, 29, 6, 11, 2, 12)
ma2 = c(40, 3, 26, 6, 49)
