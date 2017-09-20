# Internal Representations Questionnaire

To be able to download data directly from Qualtrics,
you need to find your API Token and record it in
a file "qualtrics.yml".

You can find your Qualtrics API Token by logging in
to Qualtrics, navigating to **Account Settings**,
and then **Qualtrics IDs**. Click "Generate Token"
if you haven't been assigned one yet.

Once you have your API Token, create a copy of the
file "qualtrics.yml.template" named "qualtrics.yml".
Then copy and paste your API Token into the correct
place in the file "qualtrics.yml".

You can then verify that you are correctly authenticated.

```R
source("get_data.R")
list_recent_surveys()  # prints 10 surveys with recent activity
```

Now you are ready to obtain the results for the survey.

```R
results <- get_responses("Internal Representations Questionnaire")
```

**WARNING**. This data is in "tidy" format, meaning there is one observation
per row. Since response types vary across questions, all
responses are in a character vector. Responses must be explicitly
converted to numeric values.

```R
# Get the responses to question 3 as numeric values
q3 <- filter(results, qid == "Q3") %>%
  mutate(value = as.numeric(response))
```
