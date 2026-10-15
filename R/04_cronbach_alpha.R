# ==============================================================================
# 04_cronbach_alpha.R
# Internal consistency reliability analysis (Cronbach's alpha)
# Evaluates Overall 18 items, WFC/FWC 9-item scales, and 6 subscales
# ==============================================================================

df_items <- read.csv("../data/wfc_item_scores.csv", fileEncoding = "UTF-8")

# Define item lists
items_all18 <- paste0("Q", 22:39)
items_wfc9  <- c("Q22", "Q23", "Q24", "Q28", "Q29", "Q30", "Q34", "Q35", "Q36")
items_fwc9  <- c("Q25", "Q26", "Q27", "Q31", "Q32", "Q33", "Q37", "Q38", "Q39")

items_time_wfc   <- c("Q22", "Q23", "Q24")
items_strain_wfc <- c("Q28", "Q29", "Q30")
items_behav_wfc  <- c("Q34", "Q35", "Q36")

items_time_fwc   <- c("Q25", "Q26", "Q27")
items_strain_fwc <- c("Q31", "Q32", "Q33")
items_behav_fwc  <- c("Q37", "Q38", "Q39")

# Standard alpha formula
calc_alpha <- function(mat) {
  k <- ncol(mat)
  var_items <- sum(apply(mat, 2, var))
  var_total <- var(rowSums(mat))
  (k / (k - 1)) * (1 - var_items / var_total)
}

scales <- list(
  "Overall 18-item Scale (総合18項目)" = items_all18,
  "Work-to-Family Conflict (WFC計: 9項目)" = items_wfc9,
  "  - Time-based WFC (時間的葛藤: 3項目)" = items_time_wfc,
  "  - Strain-based WFC (負担的葛藤: 3項目)" = items_strain_wfc,
  "  - Behavior-based WFC (行動的葛藤: 3項目)" = items_behav_wfc,
  "Family-to-Work Conflict (FWC計: 9項目)" = items_fwc9,
  "  - Time-based FWC (時間的葛藤: 3項目)" = items_time_fwc,
  "  - Strain-based FWC (負担的葛藤: 3項目)" = items_strain_fwc,
  "  - Behavior-based FWC (行動的葛藤: 3項目)" = items_behav_fwc
)

res <- data.frame(
  Scale = names(scales),
  Num_Items = sapply(scales, length),
  Alpha_Overall = sapply(scales, function(cols) round(calc_alpha(df_items[, cols]), 3)),
  Alpha_Email = sapply(scales, function(cols) round(calc_alpha(subset(df_items, method == "メール")[, cols]), 3)),
  Alpha_Postal = sapply(scales, function(cols) round(calc_alpha(subset(df_items, method == "郵送")[, cols]), 3)),
  Alpha_Web = sapply(scales, function(cols) round(calc_alpha(subset(df_items, method == "Web回答")[, cols]), 3))
)

cat("=== Cronbach's Alpha Reliability Results ===\n")
print(res, row.names = FALSE)
