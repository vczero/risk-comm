library(ggplot2)


factor_question <- read.csv("factor_question.csv")
factor_question$is_question_mark <- as.factor(factor_question$is_question_mark)


medians <- aggregate(read_num ~ is_question_mark, data = factor_question, median)


ggplot(factor_question, aes(x = is_question_mark, y = read_num)) +
  geom_boxplot(aes(fill = is_question_mark), alpha = 0, color = "black") + 
  geom_jitter(color = "#60AE57", width = 0.2, alpha = 0.5, size = 3, stroke = 0.6) + # 散点
  labs(x = "Contains Question Mark", y = "Reads") +
  scale_x_discrete(
    labels = c("1" = "Yes", "0" = "No")  
  ) +
  
  annotate(
    "segment",
    x = 1, xend = 2,
    y = medians$read_num[medians$is_question_mark == "0"],
    yend = medians$read_num[medians$is_question_mark == "1"],
    color = "#FEAE00", size = 1.2
  ) +

  annotate(
    "point",
    x = 1, y = medians$read_num[medians$is_question_mark == "0"],
    color = "#FEAE00", size = 3
  ) +
  annotate(
    "point",
    x = 2, y = medians$read_num[medians$is_question_mark == "1"],
    color = "#FEAE00", size = 3
  ) +
  theme_minimal(base_size = 16) +
  theme(legend.position = "none") 


ggsave("./factor_question.pdf", width = 5, height = 4, device = "pdf")
