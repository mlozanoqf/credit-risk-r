source("chapters/03-merton/helpers/packages.R")
source("shared/formatting.R")

E0 <- 3
se <- 0.8
rf <- 0.05
TT <- 1
D <- 10

equity_value_error <- function(V0, sv) {
  V0 * pnorm((log(V0 / D) + (rf + sv^2 / 2) * TT) / (sv * sqrt(TT))) -
    D * exp(-rf * TT) * pnorm(
      ((log(V0 / D) + (rf + sv^2 / 2) * TT) / (sv * sqrt(TT))) -
        sv * sqrt(TT)
    ) -
    E0
}

equity_volatility_error <- function(V0, sv) {
  pnorm((log(V0 / D) + (rf + sv^2 / 2) * TT) / (sv * sqrt(TT))) *
    sv * V0 -
    se * E0
}

merton_squared_error <- function(x) {
  (equity_value_error(x[1], x[2]))^2 + (equity_volatility_error(x[1], x[2]))^2
}

start_V0 <- E0 + D * exp(-rf * TT)
start_sv <- se * E0 / start_V0

V0_sv <- optim(
  par = c(V0 = start_V0, sv = start_sv),
  fn = merton_squared_error,
  method = "L-BFGS-B",
  lower = c(V0 = 1e-6, sv = 1e-6),
  control = list(
    parscale = c(V0 = 10, sv = 0.2),
    ndeps = c(V0 = 1e-6, sv = 1e-8)
  )
)
V0 <- unname(V0_sv$par["V0"])
sv <- unname(V0_sv$par["sv"])

PD <- function(V0, sv) {
  # Merton risk-neutral/implied probability: P_Q(V_T < D) = N(-d2).
  pnorm(-(((log(V0 / D) + (rf + sv^2 / 2) * TT) /
    (sv * sqrt(TT))) - sv * sqrt(TT)))
}

pd_merton <- PD(V0, sv)
market_value_debt <- V0 - E0
pv_promised_payment_debt <- D * exp(-rf * TT)
merton_implied_debt_yield <- (1 / TT) * log(D / market_value_debt)
merton_implied_spread <- merton_implied_debt_yield - rf
