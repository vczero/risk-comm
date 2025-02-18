library(ggplot2)
factor_exclamation <- read.csv("factor_exclamation.csv")
factor_exclamation$is_exc_point <- as.factor(factor_exclamation$is_exc_point)

medians <- aggregate(read_num ~ is_exc_point, data = factor_exclamation, median)

ggplot(factor_exclamation, aes(x = is_exc_point, y = read_num)) +
  geom_boxplot(aes(fill = is_exc_point), alpha = 0, color = "black") + 
  geom_jitter(color = "#60AE57", width = 0.2, alpha = 0.5, size = 3, stroke = 0.6) + # 散点
  labs(x = "Contains Exclamation Mark", y = "Reads") +
  scale_x_discrete(
    labels = c("1" = "Yes", "0" = "No")  
  ) +
  geom_segment(
    aes(
      x = 1, xend = 2,  
      y = medians$read_num[medians$is_exc_point == "0"],
      yend = medians$read_num[medians$is_exc_point == "1"] 
    ),
    color = "#F6B32D", 
    size = 1.2 
  ) +
  geom_point(
    aes(x = 1, y = medians$read_num[medians$is_exc_point == "0"]),
    color = "#F6B32D", size = 3
  ) +
  geom_point(
    aes(x = 2, y = medians$read_num[medians$is_exc_point == "1"]),
    color = "#F6B32D", size = 3
  ) +
  theme_minimal(base_size = 16) +
  theme(legend.position = "none") 

ggsave("./factor_exclamation.pdf", width = 5, height = 4, device = "pdf")
