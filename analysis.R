source("get_data.R")
list_recent_surveys()

results <- get_responses("Internal Representations Questionnaire")

q3 <- filter(results, qid == "Q3") %>%
  mutate(value = as.numeric(response))

ggplot(q3) +
  aes(subq_label, value) +
  geom_bar(stat = "summary", fun.y = "mean", alpha = 0.6) +
  geom_point(aes(color = ResponseID), position = position_jitter(width = 0.2)) +
  coord_flip() +
  guides(color = "none")
