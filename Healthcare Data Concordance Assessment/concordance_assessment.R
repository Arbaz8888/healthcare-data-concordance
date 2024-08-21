library(dplyr)
library(tidyr)

# Load healthcare site data
site_data <- read.csv('healthcare_site_data.csv')

# Normalize Scores (0-100 scale) for consistency
site_data <- site_data %>%
  mutate_at(vars(StructureScore, ProcessScore, OutcomeScore),
            list(~ (.-min(.))/(max(.)-min(.)) * 100))

# Calculate Concordance Scores
site_data <- site_data %>%
  rowwise() %>%
  mutate(ConcordanceScore = mean(c_across(StructureScore:OutcomeScore))) %>%
  ungroup()

# Categorize sites based on ConcordanceScore
site_data <- site_data %>%
  mutate(Category = case_when(
    ConcordanceScore > 90 ~ "Excellent",
    ConcordanceScore > 75 ~ "Good",
    ConcordanceScore > 60 ~ "Average",
    TRUE ~ "Needs Improvement"
  ))

# Save concordance scores
write.csv(site_data, 'concordance_scores.csv', row.names = FALSE)
