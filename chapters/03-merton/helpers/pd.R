source("chapters/03-merton/helpers/calibration.R")

## ---- merton-pd-function
pd <- function(E0, se, rf, TT, D) {
  solution <- merton_calibrate(E0, se, rf, TT, D)
  V0_hat <- unname(solution$par["V0"])
  sv_hat <- unname(solution$par["sv"])
  merton_probability(V0_hat, sv_hat, D, rf, TT)
}

## ---- merton-pd-benchmark
pd1 <- pd(E0, se, rf, TT, D)
if (isTRUE(getOption("knitr.in.progress"))) {
  knitr::read_chunk("chapters/03-merton/helpers/pd.R")
}
