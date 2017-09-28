source("get_data.R")

results <- get_responses("Internal Representations Questionnaire",
                         useLabels = FALSE)  # force using values

# Q182
q182 <- filter(results, qid == "Q182") %>%
  mutate(
    # Convert response column to numeric
    response = as.numeric(response),
    # Create a new version of subq_label with newline
    # characters '\n' inserted every 40 characters.
    subq_labeln = gsub('(.{1,40})(\\s|$)', '\\1\n', subq_label)
  )

# Create groups of related subquestions
factor_3_map <- data_frame(
  subq_id = paste0("Q182_", c(10, 36, 59, 18, 60, 37)),
  label = "factor_3"
)
# factor_4_map <- data_frame(
#   subq_id = c(...),
#   label = "factor_4"
# )
# factor_N_map <- data_frame(
#   subq_id = c(...),
#   label = "factor_N"
#)

# Bind all factor maps together
factor_map <- bind_rows(factor_3_map) #, factor_4_map, factor_N_map)

# Merge the question data with the factor map.
# Creates a new column q182$label
q182 <- left_join(q182, factor_map)

# Calculate the mean response for each subquestion.
q182_means <- q182 %>%
  group_by(label, subq_labeln) %>%
  summarize(response = mean(response, na.rm = TRUE)) %>%
  ungroup()

# Plot responses to factor 3 questions
q182_factor3 <- filter(q182, label == "factor_3")
q182_factor3_means <- filter(q182_means, label == "factor_3")
ggplot(q182_factor3) +
  aes(response) +
  geom_histogram(binwidth = 1, fill = "white", color = "black") +
  geom_vline(aes(xintercept = response),
             data = q182_factor3_means) +
  facet_wrap("subq_labeln")

# Plot responses to factor 4 questions
# q182_factor4 <- filter(q182, label == "factor_4")
# q182_factor4_means <- filter(q182, label == "factor_4")
# ggplot(q182_factor4) +
#   aes(response) +
#   geom_histogram(binwidth = 1, fill = "white", color = "black") +
#   geom_vline(aes(xintercept = response),
#              data = q182_factor4_means) +
#   facet_wrap("subq_labeln")

# Plot responses to factor N questions
# q182_factorN <- filter(q182, label == "factor_N")
# q182_factorN_means <- filter(q182, label == "factor_N")
# ggplot(q182_factorN) +
#   aes(response) +
#   geom_histogram(binwidth = 1, fill = "white", color = "black") +
#   geom_vline(aes(xintercept = response),
#              data = q182_factorN_means) +
#   facet_wrap("subq_labeln")