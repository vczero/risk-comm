library(ggplot2)

df <- read.csv("factor_title_len.csv")

ggplot(df, aes(x = title_len, y = read_num)) +
  geom_point(color = "#D6543B", size = 3, alpha = 0.2) + 
  geom_smooth(method = "lm", color = "#1A3F96", se = FALSE) + 
  labs(
       x = "Title Length",
       y = "Reads") +
  theme_minimal(base_size = 16)  

ggsave("./factor_title_len_scatter.pdf", width = 6, height = 5, device = "pdf")
