source("chapters/01-logistic/helpers/data.R")

dat$loan_st <- as.factor(dat$loan_st)
set.seed(569)
random_order <- order(runif(nrow(dat)))
index_train <- random_order[seq_len(floor(2 * nrow(dat) / 3))]
index_test <- random_order[-seq_along(index_train)]

train <- dat[index_train, ]
test <- dat[index_test, ]

logi_age <- glm(loan_st ~ age, family = "binomial", data = train)
logi_int <- glm(loan_st ~ int, family = "binomial", data = train)
logi_multi <- glm(
  loan_st ~ age + int + grade + log(l_amnt) + log(income),
  family = "binomial",
  data = train
)
logi_full <- glm(
  loan_st ~ age + int + grade + log(l_amnt) + log(income) + emp_len +
    home + sex + region,
  family = "binomial",
  data = train
)

pred_logi_age <- predict(logi_age, newdata = test, type = "response")
pred_logi_int <- predict(logi_int, newdata = test, type = "response")
pred_logi_multi <- predict(logi_multi, newdata = test, type = "response")
pred_logi_full <- predict(logi_full, newdata = test, type = "response")

cutoff <- quantile(pred_logi_full, 0.8)
pred_full_20 <- ifelse(pred_logi_full > cutoff, 1, 0)
real_pred_20 <- cbind.data.frame(
  test$loan_st,
  pred_full_20,
  "Did the model succeed?" = test$loan_st == pred_full_20
)

bank <- function(prob_of_default, actual_default) {
  actual_default <- as.numeric(as.character(actual_default))
  accept_rate <- seq(1, 0, by = -0.05)
  cutoff <- quantile(prob_of_default, accept_rate)
  cutoff[accept_rate == 0] <- -Inf
  bad_rate <- vapply(seq_along(cutoff), function(i) {
    if (accept_rate[i] == 0) return(NA_real_)
    accepted <- prob_of_default <= cutoff[i]
    mean(actual_default[accepted] == 1)
  }, numeric(1))

  table <- cbind(
    accept_rate,
    cutoff = round(cutoff, 4),
    bad_rate = round(bad_rate, 4)
  )

  list(table = table, bad_rate = bad_rate, accept_rate = accept_rate, cutoff = cutoff)
}

bank_logi_full <- bank(pred_logi_full, test$loan_st)
bank_logi_age <- bank(pred_logi_age, test$loan_st)

ROC_logi_full <- roc(test$loan_st, pred_logi_full, quiet = TRUE)
ROC_logi_age <- roc(test$loan_st, pred_logi_age, quiet = TRUE)

classification_metrics <- function(actual, predicted) {
  cm <- table(
    Actual = factor(actual, levels = c("0", "1")),
    Predicted = factor(predicted, levels = c(0, 1))
  )
  tn <- cm["0", "0"]
  fp <- cm["0", "1"]
  fn <- cm["1", "0"]
  tp <- cm["1", "1"]
  c(
    sensitivity = as.numeric(tp / (tp + fn)),
    specificity = as.numeric(tn / (tn + fp))
  )
}

cutoff_full_80 <- unname(quantile(pred_logi_full, 0.80))
cutoff_age_80 <- unname(quantile(pred_logi_age, 0.80))
cutoff_full_65 <- unname(quantile(pred_logi_full, 0.65))
cutoff_age_65 <- unname(quantile(pred_logi_age, 0.65))

pred_full_80 <- ifelse(pred_logi_full > cutoff_full_80, 1, 0)
pred_age_80 <- ifelse(pred_logi_age > cutoff_age_80, 1, 0)
pred_full_65 <- ifelse(pred_logi_full > cutoff_full_65, 1, 0)
pred_age_65 <- ifelse(pred_logi_age > cutoff_age_65, 1, 0)

metrics_full_80 <- classification_metrics(test$loan_st, pred_full_80)
metrics_age_80 <- classification_metrics(test$loan_st, pred_age_80)
metrics_full_65 <- classification_metrics(test$loan_st, pred_full_65)
metrics_age_65 <- classification_metrics(test$loan_st, pred_age_65)
