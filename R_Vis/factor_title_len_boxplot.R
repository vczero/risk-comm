library(ggplot2)
library(dplyr)

df <- read.csv("factor_title_len.csv")


df <- df %>%
  mutate(title_group = cut(title_len, 
                           breaks = c(0, 16, 32, 48, 64),
                           labels = c("1-16", "17-32", "33-48", "49-64"),  
                           right = TRUE))  

group_colors <- c("1-16" = "#E04439",  
                  "17-32" = "#E04439", 
                  "33-48" = "#E04439", 
                  "49-64" = "#E04439")

median_data <- df %>%
  group_by(title_group) %>%
  summarize(median_read = median(read_num))  

ggplot(df, aes(x = title_group, y = read_num, fill = title_group)) +
  geom_boxplot(color = "black", 
               alpha = 0,  
               outlier.shape = NA) +       

  geom_jitter(width = 0.2,               
              size = 3,                
              alpha = 0.2,               
              shape = 21,               
              color = "#E04439",           
              stroke = 0.3) +            
  
  geom_line(data = median_data,         
            aes(x = title_group, y = median_read, group = 1), 
            color = "#1B4097",           
            size = 1) +   
  geom_point(data = median_data,                
             aes(x = title_group, y = median_read),
             color = "#1B4097",                   
             size = 4) +                  
 

  scale_fill_manual(values = group_colors) + 
  labs(x = "Title Length Group", y = "Reads") +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",  
    axis.text = element_text(size = 14)  
  )

ggsave("./factor_title_len_boxplots.pdf", width = 7, height = 4, device = "pdf")
