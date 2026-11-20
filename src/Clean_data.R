library(tidyverse)  
library(dplyr)
library(tidymodels)

test_data <- read_csv("test.csv")  

glimpse(test_data)  

colSums(is.na(test_data))  

clean_test_data <- test_data %>% mutate(  
  
  Time_spent_Alone = replace_na(Time_spent_Alone, median(Time_spent_Alone, na.rm = TRUE)), 
  
  Social_event_attendance=replace_na(Social_event_attendance,median(Social_event_attendance, na.rm = TRUE)),  
  
  Going_outside = replace_na(Going_outside, median(Going_outside, na.rm = TRUE)), 
  
  Friends_circle_size = replace_na(Friends_circle_size, median(Friends_circle_size, na.rm = TRUE)),  
  
  Post_frequency = replace_na(Post_frequency, median(Post_frequency, na.rm = TRUE)), 
  
  
  
  Stage_fear = replace_na(Stage_fear, "No"), 
  
  Stage_fear = factor(Stage_fear, levels = c("No", "Yes")), 
  
  Drained_after_socializing = replace_na(Drained_after_socializing, "No"), 
  
  Drained_after_socializing = factor(Drained_after_socializing, levels = c("No", "Yes")) )  



sum(is.na(clean_test_data))



train_data <- read_csv("train.csv")  

glimpse(train_data)  

colSums(is.na(train_data))  

clean_train_data <- train_data %>% mutate(  
  
  Time_spent_Alone = replace_na(Time_spent_Alone, median(Time_spent_Alone, na.rm = TRUE)), 
  
  Social_event_attendance=replace_na(Social_event_attendance,median(Social_event_attendance, na.rm = TRUE)),  
  
  Going_outside = replace_na(Going_outside, median(Going_outside, na.rm = TRUE)), 
  
  Friends_circle_size = replace_na(Friends_circle_size, median(Friends_circle_size, na.rm = TRUE)),  
  
  Post_frequency = replace_na(Post_frequency, median(Post_frequency, na.rm = TRUE)), 
  
  
  
  Stage_fear = replace_na(Stage_fear, "No"), 
  
  Stage_fear = factor(Stage_fear, levels = c("No", "Yes")), 
  
  Drained_after_socializing = replace_na(Drained_after_socializing, "No"), 
  
  Drained_after_socializing = factor(Drained_after_socializing, levels = c("No", "Yes")) )  



sum(is.na(clean_train_data))
