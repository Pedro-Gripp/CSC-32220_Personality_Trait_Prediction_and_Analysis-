install.packages("ggplot2")
install.packages("dplyr")

library(ggplot2)
library(dplyr)

ggplot(clean_train_data, aes(x = Personality, fill = Personality)) +
  geom_bar() +
  labs(
    title = "Distribution of Personality Types",
    x = "Personality",
    y = "Count"
  ) +
  theme_minimal()

ggplot(clean_train_data, aes(x = Time_spent_Alone, fill = Personality)) +
  geom_histogram(bins = 20, alpha = 0.7, position = "identity") +
  labs(
    title = "Time Spent Alone by Personality",
    x = "Time Spent Alone",
    y = "Frequency"
  ) +
  theme_minimal()

ggplot(clean_train_data, aes(x = Personality,
                 y = Time_spent_Alone,
                 fill = Personality)) +
  geom_boxplot() +
  labs(
    title = "Time Spent Alone by Personality Type",
    x = "Personality",
    y = "Time Spent Alone"
  ) +
  theme_minimal()