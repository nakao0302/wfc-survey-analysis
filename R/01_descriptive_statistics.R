# ==============================================================================
# 01_descriptive_statistics.R
# Descriptive statistics of Work-Family Conflict (WFC) scores
# ==============================================================================

# Read dataset
df <- read.csv("../data/clean_survey_data.csv", fileEncoding = "UTF-8")

cat("=== 1. Overall WFC Descriptive Statistics (N =", nrow(df), ") ===\n")
# Helper function for summary stats
calc_stats <- function(x) {
  c(
    N = length(x),
    Mean = round(mean(x), 2),
    SD = round(sd(x), 2),
    Median = round(median(x), 2),
    Q25 = round(quantile(x, 0.25), 2),
    Q75 = round(quantile(x, 0.75), 2),
    IQR = round(IQR(x), 2),
    Min = min(x),
    Max = max(x)
  )
}

cat("\n-- WFC Total Score (18 items: 18 - 90 points) --\n")
print(calc_stats(df$wfc18_sum))

cat("\n-- WFC Subscale Score (9 items: 9 - 45 points) --\n")
print(calc_stats(df$wfc9_sum))

# ==============================================================================
# 2. Subgroup Descriptive Statistics
# ==============================================================================

cat("\n=== 2. By Sex (9 items) ===\n")
by_sex <- split(df$wfc9_sum, df$sex)
print(t(sapply(by_sex, calc_stats)))

cat("\n=== 3. By Having Children (9 items) ===\n")
by_children <- split(df$wfc9_sum, df$children)
print(t(sapply(by_children, calc_stats)))

cat("\n=== 4. By Monthly Overtime (9 items) ===\n")
df$overtime <- factor(df$overtime, levels = c("10時間未満", "11～20時間", "21～30時間", "31～39時間", "40時間以上"))
by_ot <- split(df$wfc9_sum, df$overtime)
print(t(sapply(by_ot, calc_stats)))
