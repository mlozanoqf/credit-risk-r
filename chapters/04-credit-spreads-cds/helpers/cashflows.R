# Shared annual bond and CDS cash flows; rates are decimals.
## ---- core-discount_factor
discount_factor <- function(r, t) {
  1 / (1 + r)^t
}

## ---- core-survival_schedule
survival_schedule <- function(h) {
  h <- as.numeric(h)
  n <- length(h)
  survival_start <- c(1, cumprod(1 - h)[-n])
  marginal_pd <- survival_start * h
  survival_end <- survival_start - marginal_pd

  data.frame(
    period = seq_len(n),
    h = h,
    survival_start = survival_start,
    marginal_pd = marginal_pd,
    survival_end = survival_end,
    cumulative_pd = 1 - survival_end
  )
}

## ---- core-price_zero_defaultable
price_zero_defaultable <- function(face, r, recovery, h) {
  sched <- survival_schedule(h)
  maturity <- length(h)
  recovery_leg <- sum(
    discount_factor(r, sched$period) * recovery * face * sched$marginal_pd
  )
  survival_leg <- discount_factor(r, maturity) *
    face * sched$survival_end[maturity]
  recovery_leg + survival_leg
}

## ---- core-price_coupon_defaultable
price_coupon_defaultable <- function(face, coupon_rate, r, recovery, h) {
  legs <- price_coupon_components(face, coupon_rate, r, recovery, h)$present_value
  legs[1] + legs[2] + legs[3]
}

## ---- core-price_coupon_components
price_coupon_components <- function(face, coupon_rate, r, recovery, h) {
  sched <- survival_schedule(h)
  maturity <- length(h)
  coupon <- face * coupon_rate
  coupon_leg <- sum(discount_factor(r, sched$period) * coupon * sched$survival_end)
  recovery_leg <- sum(
    discount_factor(r, sched$period) * recovery * face * sched$marginal_pd
  )
  principal_leg <- discount_factor(r, maturity) *
    face * sched$survival_end[maturity]

  data.frame(
    component = c(
      "Survival-weighted coupons",
      "Expected recovery",
      "Survival-weighted principal"
    ),
    present_value = c(coupon_leg, recovery_leg, principal_leg)
  )
}

## ---- core-price_coupon_from_yield
price_coupon_from_yield <- function(face, coupon_rate, yield, maturity) {
  coupon <- face * coupon_rate
  periods <- seq_len(maturity)
  sum(coupon / (1 + yield)^periods) +
    face / (1 + yield)^maturity
}

## ---- core-price_coupon_risk_free
price_coupon_risk_free <- function(face, coupon_rate, r, maturity) {
  price_coupon_from_yield(face, coupon_rate, r, maturity)
}

## ---- core-coupon_bond_ytm
coupon_bond_ytm <- function(price, face, coupon_rate, maturity) {
  f <- function(y) {
    price_coupon_from_yield(face, coupon_rate, y, maturity) - price
  }
  uniroot(f, interval = c(-0.95, 1), tol = 1e-12)$root
}

## ---- core-solve_flat_hazard_from_price
solve_flat_hazard_from_price <- function(price, face, coupon_rate, r, recovery, maturity) {
  f <- function(h) {
    price_coupon_defaultable(
      face = face,
      coupon_rate = coupon_rate,
      r = r,
      recovery = recovery,
      h = rep(h, maturity)
    ) - price
  }
  uniroot(f, interval = c(1e-8, 0.95), tol = 1e-12)$root
}

## ---- core-cds_legs
cds_legs <- function(notional, r, recovery, h, spread) {
  sched <- survival_schedule(h)
  discount <- discount_factor(r, sched$period)
  protection_leg <- notional * (1 - recovery) *
    sum(discount * sched$marginal_pd)
  premium_leg <- notional * spread *
    sum(discount * sched$survival_end)

  data.frame(
    protection_leg = protection_leg,
    premium_leg = premium_leg,
    cds_value_to_protection_buyer = protection_leg - premium_leg
  )
}

## ---- core-cds_fair_spread
cds_fair_spread <- function(r, recovery, h) {
  sched <- survival_schedule(h)
  discount <- discount_factor(r, sched$period)
  (1 - recovery) * sum(discount * sched$marginal_pd) /
    sum(discount * sched$survival_end)
}

## ---- core-hull_cds_schedule
hull_cds_schedule <- function(hazard_rate, r, recovery, maturity) {
  year <- seq_len(maturity)
  survival_start <- exp(-hazard_rate * (year - 1))
  survival_end <- exp(-hazard_rate * year)
  default_probability <- survival_start - survival_end
  premium_discount <- exp(-r * year)
  default_discount <- exp(-r * (year - 0.5))

  data.frame(
    year = year,
    default_time = year - 0.5,
    survival_probability = survival_end,
    default_probability = default_probability,
    premium_discount = premium_discount,
    default_discount = default_discount,
    premium_annuity_piece = survival_end * premium_discount,
    protection_piece = default_probability * (1 - recovery) * default_discount,
    accrual_annuity_piece = 0.5 * default_probability * default_discount
  )
}

## ---- core-hull_cds_components
hull_cds_components <- function(hazard_rate, r, recovery, maturity,
                                notional = 1) {
  sched <- hull_cds_schedule(hazard_rate, r, recovery, maturity)
  premium_annuity <- notional * sum(sched$premium_annuity_piece)
  protection_leg <- notional * sum(sched$protection_piece)
  accrual_annuity <- notional * sum(sched$accrual_annuity_piece)
  fair_spread <- protection_leg / (premium_annuity + accrual_annuity)

  list(
    schedule = sched,
    premium_annuity = premium_annuity,
    protection_leg = protection_leg,
    accrual_annuity = accrual_annuity,
    risky_annuity_with_accrual = premium_annuity + accrual_annuity,
    fair_spread = fair_spread
  )
}

## ---- core-solve_hull_hazard_from_spread
solve_hull_hazard_from_spread <- function(spread, r, recovery, maturity) {
  f <- function(hazard_rate) {
    hull_cds_components(
      hazard_rate = hazard_rate,
      r = r,
      recovery = recovery,
      maturity = maturity
    )$fair_spread - spread
  }
  uniroot(f, interval = c(1e-8, 1), tol = 1e-12)$root
}

## ---- core-cds_midpoint
cds_midpoint <- function(lambda, r = .05, recovery = .4, maturity = 5,
                         intervals_per_year = 1L, premium_annuity = NULL,
                         ends = NULL) {
  dt <- 1 / intervals_per_year
  if (is.null(ends)) ends <- seq_len(maturity * intervals_per_year) * dt
  mids <- ends - dt / 2
  default_mass <- exp(-lambda * (ends - dt)) - exp(-lambda * ends)
  discounted_mass <- default_mass * exp(-r * mids)
  if (is.null(premium_annuity)) {
    premium_annuity <- sum(exp(-(lambda + r) * seq_len(maturity)))
  }
  accrual <- sum((mids - floor(mids)) * discounted_mass)
  protection <- (1 - recovery) * sum(discounted_mass)
  list(A = premium_annuity, C = accrual, annuity = premium_annuity + accrual,
       L = protection, spread = protection / (premium_annuity + accrual))
}

## ---- core-cds_discounted_default_density
cds_discounted_default_density <- function(t, lambda, r) {
  lambda * exp(-(lambda + r) * t)
}

## ---- core-cds_continuous
cds_continuous <- function(lambda, r = .05, recovery = .4, maturity = 5,
                           frequency = 1L, rel.tol = 1e-12,
                           premium_annuity = NULL) {
  dates <- seq_len(maturity * frequency) / frequency
  starts <- c(0, head(dates, -1))
  delta <- 1 / frequency
  density_pv <- function(t) cds_discounted_default_density(t, lambda, r)
  if (is.null(premium_annuity)) {
    premium_annuity <- sum(delta * exp(-(lambda + r) * dates))
  }
  accrual <- sum(vapply(seq_along(dates), function(j) {
    integrate(function(t) (t - starts[j]) * density_pv(t),
              starts[j], dates[j], rel.tol = rel.tol)$value
  }, numeric(1)))
  protection <- (1 - recovery) *
    integrate(density_pv, 0, maturity, rel.tol = rel.tol)$value
  list(A = premium_annuity, C = accrual, annuity = premium_annuity + accrual,
       L = protection, spread = protection / (premium_annuity + accrual))
}

## ---- core-annual_event_cashflows
annual_event_cashflows <- function(coupon = 5, F = 100, recovery = .4, maturity = 5) {
  cash <- matrix(0, nrow = maturity + 1, ncol = maturity)
  for (k in seq_len(maturity)) {
    if (k > 1) cash[k, seq_len(k - 1)] <- coupon
    cash[k, k] <- recovery * F
  }
  cash[maturity + 1, ] <- coupon
  cash[maturity + 1, maturity] <- coupon + F
  rownames(cash) <- c(paste('Default in year', seq_len(maturity)), 'Survive to maturity')
  colnames(cash) <- paste0('year_', seq_len(maturity))
  cash
}

## ---- core-register-display
# The caller sources this file from the companion root, also through the private
# loader. Register the same source for pedagogical displays only during knitting.
if (isTRUE(getOption("knitr.in.progress"))) {
  knitr::read_chunk("chapters/04-credit-spreads-cds/helpers/cashflows.R")
}
