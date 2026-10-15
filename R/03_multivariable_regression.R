# ==============================================================================
# 03_multivariable_regression.R
# Multivariable Linear Regression Analysis for Factors Associated with WFC
# Fits both Total Score (18-90 points) and Subscale (9 items)
# Across Overall sample and 3 Survey Methods
# ==============================================================================

df <- read.csv("../data/clean_survey_data.csv", fileEncoding = "UTF-8")

# Set Reference levels
df$age <- relevel(factor(df$age), ref = "35～45歳")
df$sex <- relevel(factor(df$sex), ref = "男性")
df$overtime <- relevel(factor(df$overtime), ref = "10時間未満")
df$daysOff <- relevel(factor(df$daysOff), ref = "固定休（土日休みなど）")
df$familyCat <- relevel(factor(df$familyCat), ref = "未婚")
df$children <- relevel(factor(df$children), ref = "いいえ")
df$satisfaction <- relevel(factor(df$satisfaction), ref = "非常に満足している")
df$anxiety <- relevel(factor(df$anxiety), ref = "全く感じない")

# Helper function
summarize_model <- function(mod, name = "Model") {
  cat("\n======================================================\n")
  cat(name, "\n")
  cat("======================================================\n")
  s <- summary(mod)
  ci <- confint(mod)
  cf <- s$coefficients
  res <- data.frame(
    B = round(cf[, "Estimate"], 3),
    SE = round(cf[, "Std. Error"], 3),
    `95% CI Lower` = round(ci[, 1], 3),
    `95% CI Upper` = round(ci[, 2], 3),
    `t value` = round(cf[, "t value"], 3),
    `p value` = ifelse(cf[, "Pr(>|t|)"] < 0.001, "< 0.001", round(cf[, "Pr(>|t|)"], 4))
  )
  print(res)
  cat(sprintf("\nR2 = %.4f, Adjusted R2 = %.4f, F = %.3f, p = %.3e\n",
              s$r.squared, s$adj.r.squared, s$fstatistic[1],
              pf(s$fstatistic[1], s$fstatistic[2], s$fstatistic[3], lower.tail = FALSE)))
}

# 1. Total Score Model (18 - 90 points)
fit_total_all <- lm(wfc18_sum ~ age + sex + overtime + daysOff + familyCat + children + satisfaction + anxiety, data = df)
summarize_model(fit_total_all, "Overall Sample: WFC Total Score (18-90 points)")

# 2. Subgroup models by survey method
fit_total_mail <- lm(wfc18_sum ~ age + sex + overtime + daysOff + familyCat + children + satisfaction + anxiety, data = subset(df, method == "メール"))
summarize_model(fit_total_mail, "Newsletter / Email Group (n = 488)")

fit_total_post <- lm(wfc18_sum ~ age + sex + overtime + daysOff + familyCat + children + satisfaction + anxiety, data = subset(df, method == "郵送"))
summarize_model(fit_total_post, "Postal Mail Group (n = 80)")

fit_total_web <- lm(wfc18_sum ~ age + sex + overtime + daysOff + familyCat + children + satisfaction + anxiety, data = subset(df, method == "Web回答"))
summarize_model(fit_total_web, "Website Posting Group (n = 119)")
