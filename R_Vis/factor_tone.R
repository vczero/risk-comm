library(ggplot2)
library(dplyr)

data <- read.csv("factor_tone.csv")


print(colnames(data)) 


median_data <- data %>%
  group_by(em_label) %>%                           
  summarise(median_read_num = median(read_num)) %>% 
  mutate(em_label = as.factor(em_label))           

print(median_data)

ggplot(data, aes(x = as.factor(em_label), y = read_num)) +
  geom_boxplot(aes(fill = as.factor(em_label)),  
               color = 'black',   
               size = 0.5,
               alpha = 0,  
               outlier.shape = NA) +            
  geom_jitter(aes(fill = as.factor(em_label)),  
              shape = 21,                       
              color = "#12459A",                 
              width = 0.2,                      
              alpha = 0.2,                      
              size = 3) +                     
  geom_line(data = median_data,          
            aes(x = em_label, y = median_read_num, group = 1),  
            color = "#EE3824",                   
            size = 1) +                         
  geom_point(data = median_data,                
             aes(x = em_label, y = median_read_num),
             color = "#EE3824",                   
             size = 4) +                        
  scale_x_discrete(
    limits = c("3","2",  "1"),  
    labels = c("3" = "Highly Urgent", "2" = "Urgent", "1" = "Non-Urgent")  
  ) +
  scale_fill_manual(
    values = c("#12459A", "#12459A", "#12459A") 
  ) +
  labs(
    x = "Urgency Level",  
    y = "Reads"    
  ) +
  theme_minimal(base_size = 16) +               
  theme(
    plot.title = element_blank(),              
    axis.title.x = element_text(size = 14),  #face = "bold"
    axis.title.y = element_text(size = 14),  
    axis.text.x = element_text(size = 12),                  
    axis.text.y = element_text(size = 12),                  
    legend.position = "none"                               
  )

ggsave("./factor_tone.pdf", width = 6, height = 5, device = "pdf")
