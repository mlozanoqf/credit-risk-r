source("chapters/01-logistic/helpers/packages.R")

dat <- readRDS("data/credit-scoring/credit_scoring.rds")
colnames(dat) <- c(
  "loan_st",
  "l_amnt",
  "int",
  "grade",
  "emp_len",
  "home",
  "income",
  "age",
  "sex",
  "region"
)

high_income <- dat[dat$income > 1000000, ]
dat <- dat[dat$income <= 1000000, ]
incompatible_employment <- dat[dat$emp_len > dat$age - 16, ]
dat <- dat[dat$emp_len <= dat$age - 16, ]
