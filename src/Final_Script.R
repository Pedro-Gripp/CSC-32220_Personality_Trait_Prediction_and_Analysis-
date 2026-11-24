library(tidyverse)
library(dplyr)
library(tidymodels)

test_data <- read_csv("Data/test.csv")
train_data <- read_csv("Data/train.csv")

glimpse(train_data)
colSums(is.na(train_data))

clean_train_data <- train_data %>% mutate(
  Time_spent_Alone = replace_na(Time_spent_Alone, median(Time_spent_Alone, na.rm = TRUE)),
  Social_event_attendance = replace_na(Social_event_attendance, median(Social_event_attendance, na.rm = TRUE)),
  Going_outside = replace_na(Going_outside, median(Going_outside, na.rm = TRUE)),
  Friends_circle_size = replace_na(Friends_circle_size, median(Friends_circle_size, na.rm = TRUE)),
  Post_frequency = replace_na(Post_frequency, median(Post_frequency, na.rm = TRUE)),
  
  Stage_fear = replace_na(Stage_fear, "No"),
  Stage_fear = factor(Stage_fear, levels = c("No", "Yes")),
  Drained_after_socializing = replace_na(Drained_after_socializing, "No"),
  Drained_after_socializing = factor(Drained_after_socializing, levels = c("No", "Yes"))
)

sum(is.na(clean_train_data))


# ==============================================================================
# SHARED DATA SPLIT (Keep this the same across all models for fair comparison)
# ==============================================================================

clean_train_data <- clean_train_data %>%
  mutate(Personality = as.factor(Personality))

set.seed(42)
data_split <- initial_split(clean_train_data, prop = 0.8, strata = Personality)
train_set <- training(data_split)
valid_set <- testing(data_split)


# ==============================================================================
# START MODELING LOGIC: LOGISTIC REGRESSION
# ==============================================================================

lr_recipe <- recipe(
  Personality ~ Time_spent_Alone + Social_event_attendance +
    Going_outside + Friends_circle_size + Post_frequency +
    Stage_fear + Drained_after_socializing,
  data = train_set
) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors())

lr_model <- logistic_reg() %>%
  set_engine("glm") %>%
  set_mode("classification")

lr_wf <- workflow() %>%
  add_recipe(lr_recipe) %>%
  add_model(lr_model)

lr_fit <- fit(lr_wf, data = train_set)

lr_predictions <- predict(lr_fit, new_data = valid_set, type = "class")
lr_results <- bind_cols(valid_set, lr_predictions)

lr_accuracy <- yardstick::accuracy(lr_results, truth = Personality, estimate = .pred_class)
print(lr_accuracy)

# ==============================================================================
# END MODELING LOGIC: LOGISTIC REGRESSION
# ==============================================================================