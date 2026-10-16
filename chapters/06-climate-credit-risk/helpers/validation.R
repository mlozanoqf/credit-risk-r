# Check the requested portfolio grid before an inner join can discard exposures.
validate_climate_inputs <- function(raw, portfolio, scenarios, years, metrics) {
  required <- c("model", "region", "scenario", "year", "variable", "unit", "value")
  if (!all(required %in% names(raw))) stop("Missing raw climate fields.")
  if (!all(c("ngfs_sector", "portfolio_sector", "ead", "recovery") %in% names(portfolio))) {
    stop("Incomplete portfolio columns.")
  }
  if (!nrow(portfolio) || anyNA(portfolio) ||
      anyDuplicated(portfolio$ngfs_sector) || anyDuplicated(portfolio$portfolio_sector) ||
      any(!nzchar(portfolio$ngfs_sector)) || any(!nzchar(portfolio$portfolio_sector)) ||
      any(!is.finite(portfolio$ead)) || any(portfolio$ead < 0) ||
      sum(portfolio$ead) <= 0 || any(!is.finite(portfolio$recovery)) ||
      any(portfolio$recovery < 0 | portfolio$recovery > 1)) {
    stop("Review portfolio identifiers, exposures and recoveries.")
  }
  variables <- as.vector(outer(metrics, portfolio$ngfs_sector, paste, sep = "|"))
  selected <- raw[raw$scenario %in% scenarios & raw$year %in% years &
                    raw$variable %in% variables, , drop = FALSE]
  if (anyNA(selected[required]) || any(selected$model != "CLIMACRED") ||
      any(selected$region != "World") || any(!is.finite(selected$value))) {
    stop("Review model, region and finite raw values for the requested grid.")
  }
  keys <- c("scenario", "year", "variable")
  if (anyDuplicated(selected[keys])) stop("Duplicate climate observations.")
  expected <- expand.grid(scenario = scenarios, year = years, variable = variables,
                          stringsAsFactors = FALSE)
  selected$present <- TRUE
  coverage <- merge(expected, selected[c(keys, "present")], by = keys, all.x = TRUE)
  if (anyNA(coverage$present)) {
    stop("Missing sector/scenario/year/metric observations; reconcile the portfolio mapping.")
  }
  metric <- sub("\\|.*$", "", selected$variable)
  expected_units <- c(
    baseline_pd = "value/level in percentage points",
    pd_adjustment = "abs. change in value with respect to BAU in percentage points",
    corporate_bond_spread_adjustment = "abs. change in value with respect to BAU in percentage points",
    corporate_bond_price_rel_adjustment = "relative change with respect to BAU in percents",
    wacc_adjustment = "abs. change in value with respect to BAU in percentage points"
  )
  if (anyNA(expected_units[metric]) || any(selected$unit != expected_units[metric])) {
    stop("Source units changed; review the conversion before proceeding.")
  }
  invisible(TRUE)
}

validate_climate_portfolio <- function(data, portfolio, scenarios, years) {
  keys <- c("scenario", "year", "ngfs_sector")
  expected <- expand.grid(scenario = scenarios, year = years,
                          ngfs_sector = portfolio$ngfs_sector, stringsAsFactors = FALSE)
  if (anyNA(data[keys]) || anyDuplicated(data[keys]) || nrow(data) != nrow(expected)) {
    stop("The transformed portfolio grid is incomplete or duplicated.")
  }
  joined <- merge(expected, data, by = keys, all.x = TRUE)
  if (anyNA(joined$ead) || any(!is.finite(joined$ead))) stop("Missing portfolio exposure.")
  numeric_fields <- c("baseline_pd", "pd_adjustment", "climate_pd", "recovery", "ead")
  if (any(!is.finite(as.matrix(joined[numeric_fields]))) ||
      any(joined$baseline_pd < 0 | joined$baseline_pd > 1) ||
      any(joined$climate_pd < 0 | joined$climate_pd > 1) ||
      any(joined$baseline_pd + joined$pd_adjustment < 0)) {
    stop("Invalid PD or loss inputs; review source data and units.")
  }
  source_row <- match(joined$ngfs_sector, portfolio$ngfs_sector)
  if (any(joined$ead != portfolio$ead[source_row]) ||
      any(joined$recovery != portfolio$recovery[source_row])) {
    stop("Exposure or recovery changed during the join.")
  }
  totals <- aggregate(ead ~ scenario + year, joined, sum)
  if (any(abs(totals$ead - sum(portfolio$ead)) > 1e-8 * sum(portfolio$ead))) {
    stop("Represented exposure differs from the specified portfolio.")
  }
  totals
}
