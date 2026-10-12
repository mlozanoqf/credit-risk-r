# Calendar, curve and calibration helpers for Chapter 4.
# Frozen inputs and sources are documented in data/credit-spreads/README.md.
rv_days360 <- function(a, b) {
  360 * (as.integer(format(b, "%Y")) - as.integer(format(a, "%Y"))) +
    30 * (as.integer(format(b, "%m")) - as.integer(format(a, "%m"))) +
    pmin(as.integer(format(b, "%d")), 30) -
    pmin(as.integer(format(a, "%d")), 30)
}

rv_spot <- function(t, curve) {
  a <- function(z) ifelse(abs(z) < 1e-10, 1, -expm1(-z) / z)
  u <- t / curve$TAU1
  v <- t / curve$TAU2
  (curve$BETA0 + curve$BETA1 * a(u) +
     curve$BETA2 * (a(u) - exp(-u)) +
     curve$BETA3 * (a(v) - exp(-v))) / 100
}

rv_discount <- function(t, curve, settlement, shift = 0) {
  elapsed <- as.numeric(settlement - as.Date(curve$Date)) / 365
  exp(-rv_spot(t + elapsed, curve) * (t + elapsed) +
        rv_spot(elapsed, curve) * elapsed - shift * t)
}

rv_yield_price <- function(bond, y) {
  sum(bond$cash / (1 + y / 2)^bond$exponent) - bond$accrued
}

rv_ytm <- function(bond, clean_price) {
  uniroot(function(y) rv_yield_price(bond, y) - clean_price,
          c(-0.02, 0.50), tol = 1e-12)$root
}

rv_make_bonds <- function(inputs, curve, settlement = as.Date("2026-09-29")) {
  lapply(seq_len(nrow(inputs)), function(i) {
    row <- inputs[i, ]
    dates <- sort(seq(as.Date(row$maturity), by = "-6 months", length.out = 30))
    previous <- max(dates[dates <= settlement])
    dates <- dates[dates > settlement]
    time <- as.numeric(dates - settlement) / 365
    coupon <- row$coupon_percent / 2
    cash <- rep(coupon, length(dates))
    cash[length(cash)] <- tail(cash, 1) + 100
    b <- list(isin = row$isin, issuer = row$issuer, dates = dates,
      maturity = as.Date(row$maturity), settlement = settlement,
      time = time, coupon = coupon, cash = cash, price = row$clean_price,
      accrued = row$coupon_percent * rv_days360(previous, settlement) / 360,
      exponent = rv_days360(settlement, dates[1]) / 180 + seq_along(time) - 1,
      exposure = outer(time, 0:7, function(t, k) pmax(0, pmin(1, t - k))))
    stopifnot(max(time) < 8, length(time) > 0)
    b$yield <- rv_ytm(b, b$price)
    b$dv01 <- (rv_yield_price(b, b$yield - 0.0001) -
                 rv_yield_price(b, b$yield + 0.0001)) / 2
    b
  })
}

rv_components <- function(bond, endpoints, curve, recovery = 0.40,
                          shift = 0, timing = "end", shape = "gradual", knot = 4) {
  if (shape == "gradual") {
    h <- seq(endpoints[1], endpoints[2], length.out = 8)
    survival <- exp(as.vector(bond$exposure %*% log1p(-h)))
  } else {
    survival <- (1 - endpoints[1])^pmin(bond$time, knot) *
      (1 - endpoints[2])^pmax(bond$time - knot, 0)
  }
  default <- c(1, head(survival, -1)) - survival
  discount <- rv_discount(bond$time, curve, bond$settlement, shift)
  recovery_time <- if (timing == "end") bond$time else
    (bond$time + c(0, head(bond$time, -1))) / 2
  recovery_discount <- rv_discount(recovery_time, curve, bond$settlement, shift)
  principal <- rep(0, length(survival))
  principal[length(principal)] <- 100 * tail(discount * survival, 1)
  data.frame(date = bond$dates, time = bond$time, survival = survival,
    default = default, discount = discount,
    coupon_pv = discount * bond$coupon * survival,
    recovery_pv = 100 * recovery * recovery_discount * default,
    principal_pv = principal)
}

rv_price <- function(bond, endpoints, curve, recovery = 0.40,
                     shift = 0, timing = "end", shape = "gradual", knot = 4) {
  x <- rv_components(bond, endpoints, curve, recovery, shift, timing, shape, knot)
  sum(x$coupon_pv + x$recovery_pv + x$principal_pv) - bond$accrued
}

rv_fit <- function(bonds, train, curve, recovery = 0.40, shift = 0,
                   weight = "dv01", timing = "end", shape = "gradual", knot = 4) {
  # Discounting is fixed during optimization; prepare it once per calibration.
  prepared <- lapply(train, function(j) {
    b <- bonds[[j]]
    b$discount <- rv_discount(b$time, curve, b$settlement, shift)
    rt <- if (timing == "end") b$time else
      (b$time + c(0, head(b$time, -1))) / 2
    b$recovery_discount <- rv_discount(rt, curve, b$settlement, shift)
    b
  })
  objective <- function(h) {
    annual_h <- seq(h[1], h[2], length.out = 8)
    sum(vapply(prepared, function(b) {
      s <- if (shape == "gradual") exp(as.vector(b$exposure %*% log1p(-annual_h))) else
        (1 - h[1])^pmin(b$time, knot) * (1 - h[2])^pmax(b$time - knot, 0)
      q <- c(1, head(s, -1)) - s
      p <- sum(b$discount * b$coupon * s) +
        100 * recovery * sum(b$recovery_discount * q) +
        100 * tail(b$discount * s, 1) - b$accrued
      error <- p - b$price
      if (weight == "dv01") error <- error / b$dv01
      error^2
    }, numeric(1)))
  }
  starts <- list(c(0.01, 0.02), c(0.025, 0.005), c(0.04, 0.05))
  fits <- lapply(starts, function(start) {
    nlminb(start, objective, lower = c(1e-6, 1e-6), upper = c(0.5, 0.5),
           control = list(rel.tol = 1e-10, eval.max = 1500, iter.max = 1000))
  })
  good <- which(vapply(fits, function(f) f$convergence == 0, logical(1)))
  stopifnot(length(good) > 0)
  best <- fits[[good[which.min(vapply(fits[good], function(f) f$objective, numeric(1)))]]]
  list(h = best$par, objective = best$objective,
       boundary = any(best$par < 1e-5 | best$par > 0.5 - 1e-5))
}

rv_evaluate <- function(i, bonds, curve, recovery = 0.40, shift = 0,
                        weight = "dv01", timing = "end", shape = "gradual",
                        knot = 4, omit = integer()) {
  issuer <- vapply(bonds, function(b) b$issuer, character(1))
  train <- setdiff(which(issuer == issuer[i]), c(i, omit))
  stopifnot(length(train) >= 3, !i %in% train)
  fit <- rv_fit(bonds, train, curve, recovery, shift, weight, timing, shape, knot)
  b <- bonds[[i]]
  p <- rv_price(b, fit$h, curve, recovery, shift, timing, shape, knot)
  list(bond = b, train = train, h = fit$h, boundary = fit$boundary,
       model_price = p, model_yield = rv_ytm(b, p),
       residual_bp = 1e4 * (b$yield - rv_ytm(b, p)))
}

rv_call_price <- function(bond, date, redemption, y) {
  dates <- bond$dates[bond$dates <= date]
  cash <- rep(bond$coupon, length(dates))
  if (length(dates) > 0 && tail(dates, 1) == date) {
    cash[length(cash)] <- tail(cash, 1) + redemption
  } else {
    schedule <- sort(seq(bond$maturity, by = "-6 months", length.out = 30))
    last <- max(schedule[schedule < date])
    cash <- c(cash, redemption + 2 * bond$coupon * rv_days360(last, date) / 360)
    dates <- c(dates, date)
  }
  exponent <- rv_days360(bond$settlement, dates) / 180
  sum(cash / (1 + y / 2)^exponent) - bond$accrued
}

rv_call_yield <- function(bond, date, redemption) {
  uniroot(function(y) rv_call_price(bond, date, redemption, y) - bond$price,
          c(-0.02, 3), tol = 1e-12)$root
}
