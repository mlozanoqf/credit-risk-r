# Shared valuation equations and the book's bounded calibration.
## ---- core-merton_d1
merton_d1 <- function(V0, sv, D, rf, TT) {
  (log(V0 / D) + (rf + sv^2 / 2) * TT) / (sv * sqrt(TT))
}

## ---- core-merton_d2
merton_d2 <- function(V0, sv, D, rf, TT, direct = FALSE) {
  # The direct form preserves the instructor tables' final PD rounding.
  if (direct) return((log(V0 / D) + (rf - sv^2 / 2) * TT) / (sv * sqrt(TT)))
  merton_d1(V0, sv, D, rf, TT) - sv * sqrt(TT)
}

## ---- core-merton_equity
merton_equity <- function(V0, sv, D, rf, TT) {
  V0 * pnorm(merton_d1(V0, sv, D, rf, TT)) -
    D * exp(-rf * TT) * pnorm(merton_d2(V0, sv, D, rf, TT))
}

## ---- core-merton_equity_volatility_value
merton_equity_volatility_value <- function(V0, sv, D, rf, TT) {
  pnorm(merton_d1(V0, sv, D, rf, TT)) * sv * V0
}

## ---- core-merton_residuals
merton_residuals <- function(x, E0, se, rf, TT, D) {
  c(equity = merton_equity(x[1], x[2], D, rf, TT) - E0,
    volatility = merton_equity_volatility_value(x[1], x[2], D, rf, TT) - se * E0)
}

## ---- core-merton_objective
merton_objective <- function(x, E0, se, rf, TT, D, aggregate = "pair") {
  residuals <- merton_residuals(x, E0, se, rf, TT, D)
  # sum() uses extended accumulation on some platforms. Retain both callers'
  # original arithmetic without changing the optimizer or its tolerances.
  if (aggregate == "sum") return(sum(residuals^2))
  residuals[1]^2 + residuals[2]^2
}

## ---- core-merton_calibrate
merton_calibrate <- function(E0, se, rf, TT, D, aggregate = "pair") {
  start_V0 <- E0 + D * exp(-rf * TT)
  start_sv <- se * E0 / start_V0
  optim(
    par = c(V0 = start_V0, sv = start_sv),
    fn = function(x) merton_objective(x, E0, se, rf, TT, D, aggregate),
    method = "L-BFGS-B",
    lower = c(V0 = 1e-6, sv = 1e-6),
    control = list(parscale = c(V0 = 10, sv = 0.2),
                   ndeps = c(V0 = 1e-6, sv = 1e-8))
  )
}

## ---- core-merton_probability
merton_probability <- function(V0, sv, D, rf, TT, direct = FALSE) {
  pnorm(-merton_d2(V0, sv, D, rf, TT, direct))
}

## ---- core-merton_claims
merton_claims <- function(V, sigma, D = 10, r = .05, T = 1) {
  stopifnot(all(is.finite(c(V, sigma, D, r, T))), all(V > 0),
            all(sigma > 0), all(D > 0), all(T > 0))
  d1 <- merton_d1(V, sigma, D, r, T)
  d2 <- merton_d2(V, sigma, D, r, T)
  delta <- pnorm(d1)
  E <- merton_equity(V, sigma, D, r, T)
  B <- V - E
  pd <- merton_probability(V, sigma, D, r, T)
  recovery <- V * exp(r * T) * pnorm(-d1) / (D * pd)
  data.frame(V = V, sigma = sigma, D = D, r = r, T = T,
    E = E, B = B, d1 = d1, d2 = d2, delta = delta, pd_Q = pd,
    se = merton_equity_volatility_value(V, sigma, D, r, T) / E,
    recovery_Q = recovery, spread_cc = log(D / B) / T - r)
}

## ---- core-merton_put
merton_put <- function(K, V, sigma, r, T) {
  if (K == 0) return(0)
  d1 <- merton_d1(V, sigma, K, r, T)
  d2 <- merton_d2(V, sigma, K, r, T)
  K * exp(-r * T) * pnorm(-d2) - V * pnorm(-d1)
}
