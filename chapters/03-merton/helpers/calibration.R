source("chapters/03-merton/helpers/packages.R")
source("shared/formatting.R")
source("chapters/03-merton/helpers/core.R")

E0 <- 3
se <- 0.8
rf <- 0.05
TT <- 1
D <- 10

## ---- merton-calibration
d1_merton <- function(V0, sv) {
  merton_d1(V0, sv, D, rf, TT)
}

d2_merton <- function(V0, sv) {
  merton_d2(V0, sv, D, rf, TT)
}

equity_value_error <- function(V0, sv) {
  merton_equity(V0, sv, D, rf, TT) - E0
}

equity_volatility_error <- function(V0, sv) {
  merton_equity_volatility_value(V0, sv, D, rf, TT) - se * E0
}

merton_squared_error <- function(x) {
  merton_objective(x, E0, se, rf, TT, D)
}

start_V0 <- E0 + D * exp(-rf * TT)
start_sv <- se * E0 / start_V0
V0_sv <- merton_calibrate(E0, se, rf, TT, D)
V0 <- unname(V0_sv$par["V0"])
sv <- unname(V0_sv$par["sv"])

## ---- merton-probability
PD <- function(V0, sv) {
  merton_probability(V0, sv, D, rf, TT)
}

## ---- merton-benchmark
pd_merton <- PD(V0, sv)
market_value_debt <- V0 - E0
pv_promised_payment_debt <- D * exp(-rf * TT)
merton_implied_debt_yield <- (1 / TT) * log(D / market_value_debt)
merton_implied_spread <- merton_implied_debt_yield - rf

## ---- merton-register-display
if (isTRUE(getOption("knitr.in.progress"))) {
  knitr::read_chunk("chapters/03-merton/helpers/core.R")
  knitr::read_chunk("chapters/03-merton/helpers/calibration.R")
}
