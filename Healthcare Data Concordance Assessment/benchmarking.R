library(ggplot2)
library(scales)

# Load concordance scores
concordance_scores <- read.csv('concordance_scores.csv')

# Benchmarking against MSK standards
benchmark <- mean(concordance_scores$ConcordanceScore)

# Visualize benchmarking with categorization
ggplot(concordance_scores, aes(x = reorder(Site, -ConcordanceScore), y = ConcordanceScore, fill = Category)) +
  geom_bar(stat = "identity", width = 0.7) +
  geom_hline(yintercept = benchmark, color = "red", linetype = "dashed", size = 1) +
  labs(title = "Healthcare Site Concordance Benchmarking Against MSK Standards",
       x = "Healthcare Site",
       y = "Concordance Score") +
  scale_fill_manual(values = c("Needs Improvement" = "red", 
                               "Average" = "orange", 
                               "Good" = "yellow", 
                               "Excellent" = "green")) +
  scale_y_continuous(labels = percent_format(scale = 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
