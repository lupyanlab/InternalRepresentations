source("get_data.R")
list_recent_surveys()

results <- get_responses("Internal Representations Questionnaire",
                         useLabels = FALSE)  # force using values

# Q3
q3 <- filter(results, qid == "Q3") %>%
  mutate(response = as.numeric(response))

q_plot <- ggplot(q3) +
  aes(subq_label, response) +
  geom_bar(stat = "summary", fun.y = "mean", alpha = 0.6) +
  geom_point(aes(color = ResponseID), position = position_jitter(width = 0.2)) +
  coord_flip() +
  guides(color = "none")
q_plot

# Q182
q182 <- filter(results, qid == "Q182") %>%
  mutate(response = as.numeric(response))

q_plot %+% q182
