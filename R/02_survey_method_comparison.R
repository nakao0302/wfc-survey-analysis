# ==============================================================================
# 02_survey_method_comparison.R
# Comparison across three survey methods (Newsletter/Email, Postal Mail, Website Posting)
# Evaluates survey mode effects and non-response bias
# ==============================================================================

df <- read.csv("../data/clean_survey_data.csv", fileEncoding = "UTF-8")

cat("=== Sample size across survey methods ===\n")
print(table(df$method))

# 1. WFC Scores comparison (One-way ANOVA)
cat("\n=== One-Way ANOVA for WFC Score (9 items) ===\n")
aov9 <- aov(wfc9_sum ~ method, data = df)
print(summary(aov9))

cat("\n=== One-Way ANOVA for WFC Total Score (18 items) ===\n")
aov18 <- aov(wfc18_sum ~ method, data = df)
print(summary(aov18))

# 2. Categorical Demographics comparison (Chi-Square Tests)
cat("\n=== Chi-Square Test: Sex by Survey Method ===\n")
print(chisq.test(table(df$method, df$sex)))

cat("\n=== Chi-Square Test: Having Children by Survey Method ===\n")
print(chisq.test(table(df$method, df$children)))

cat("\n=== Chi-Square Test: Monthly Overtime by Survey Method ===\n")
print(chisq.test(table(df$method, df$overtime)))

cat("\n=== Chi-Square Test: Type of Days Off by Survey Method ===\n")
print(chisq.test(table(df$method, df$daysOff)))
