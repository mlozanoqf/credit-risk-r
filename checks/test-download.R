# Run from the companion root: Rscript --vanilla checks/test-download.R
# All queries are stubs; no network or optional packages are needed.
local({
  root <- normalizePath(".", winslash = "/", mustWork = TRUE)
  helper <- file.path(root, "chapters/06-climate-credit-risk/helpers/download-data.R")
  frozen <- file.path(root, "data/climate", c(
    "ngfs_climacred_global_raw.csv", "ngfs_climacred_daps_raw.csv",
    "ngfs_climacred_download_manifest.csv"
  ))
  stopifnot(all(file.exists(frozen)))
  before <- tools::md5sum(frozen)
  scratch <- tempfile("ngfs-download-test-")
  stopifnot(dir.create(scratch))
  old_wd <- setwd(scratch)
  on.exit({
    setwd(old_wd)
    unlink(scratch, recursive = TRUE)
  }, add = TRUE)

  expect_error <- function(expr, pattern) {
    error <- tryCatch({ force(expr); NULL }, error = identity)
    stopifnot(inherits(error, "error"), grepl(pattern, conditionMessage(error)))
  }

  env <- new.env(parent = baseenv())
  env$requireNamespace <- function(...) stop("source must not load optional packages")
  sys.source(helper, envir = env)
  stopifnot(is.function(env$download_ngfs_data),
            length(list.files(scratch, all.files = TRUE, no.. = TRUE)) == 0L)
  download <- env$download_ngfs_data

  calls <- 0L
  forbidden_query <- function(...) {
    calls <<- calls + 1L
    stop("Unexpected query")
  }
  expect_error(download(query = forbidden_query), "explicit new destination")
  for (destination in list(NULL, NA_character_, "", "  ", c("a", "b"), 1)) {
    expect_error(download(destination, query = forbidden_query), "explicit new destination")
  }
  for (destination in c(dirname(frozen[1]), frozen[1], scratch)) {
    expect_error(download(destination, query = forbidden_query), "new destination")
  }
  stopifnot(calls == 0L)

  global <- data.frame(
    runId = c(75L, 76L), model = "CLIMACRED", scenario = c("HWTP", "SWUC"),
    region = "World", variable = "pd_adjustment|Coal", unit = "percentage points",
    year = c(2024L, 2030L), value = c(0.0123456789, -2.5),
    extra_raw_column = c("untouched, raw", "quoted \"value\""),
    stringsAsFactors = FALSE
  )
  daps <- global[1, , drop = FALSE]
  daps$runId <- 68L
  daps$scenario <- "DAPS_AFR_R"
  daps$region <- "Africa"

  failed_destination <- file.path(scratch, "absent-parent", "failed")
  calls <- 0L
  failed_query <- function(...) {
    calls <<- calls + 1L
    stopifnot(!file.exists(dirname(failed_destination)))
    if (calls == 2L) stop("Second query failed")
    global
  }
  expect_error(download(failed_destination, failed_query), "Second query failed")
  stopifnot(calls == 2L, !file.exists(dirname(failed_destination)),
            identical(before, tools::md5sum(frozen)))

  # Reject malformed results from either query before creating any output.
  malformed <- list(list(), list(scenario = "HWTP"), global[FALSE, ],
                    global[, names(global) != "value"])
  for (bad in malformed) {
    for (failed_call in 1:2) {
      calls <- 0L
      schema_destination <- file.path(scratch, "bad-schema")
      schema_query <- function(...) {
        calls <<- calls + 1L
        if (calls == failed_call) bad else global
      }
      expect_error(download(schema_destination, schema_query), "response|schema")
      stopifnot(calls == failed_call, !file.exists(schema_destination))
    }
  }

  destination <- file.path(scratch, "new-parent", "valid")
  requests <- list()
  valid_query <- function(runs, regions, variables, years) {
    stopifnot(!file.exists(dirname(destination)))
    requests[[length(requests) + 1L]] <<- list(
      runs = runs, regions = regions, variables = variables, years = years
    )
    if (length(requests) == 1L) global else daps
  }
  manifest <- download(destination, valid_query)
  sectors <- c("Coal", "Oil", "Gas", "Power Supply", "Land transport",
               "Air transport", "Construction", "Agriculture", "Chemical Products",
               "Computer, electronic and optical products")
  metrics <- c("baseline_pd", "pd_adjustment", "corporate_bond_spread_adjustment",
               "corporate_bond_price_rel_adjustment", "wacc_adjustment")
  stopifnot(length(requests) == 2L,
            identical(requests[[1]], list(
              runs = c(74, 75, 76), regions = "World",
              variables = as.vector(outer(metrics, sectors, paste, sep = "|")),
              years = 2022:2030)),
            identical(requests[[2]], list(
              runs = c(68, 69, 70, 71, 72, 73),
              regions = c("Africa", "Asia", "Euro Area", "North America", "Oceania", "South America"),
              variables = paste0("pd_adjustment|", c("Agriculture", "Coal", "Power Supply")),
              years = 2024:2030)))
  output_files <- file.path(destination, basename(frozen))
  stopifnot(all(file.exists(output_files)), length(list.files(destination)) == 3L)
  for (i in 1:2) {
    actual <- utils::read.csv(output_files[i], stringsAsFactors = FALSE, check.names = FALSE)
    expected <- if (i == 1L) global else daps
    stopifnot(isTRUE(all.equal(actual, expected)))
  }
  saved_manifest <- utils::read.csv(output_files[3], stringsAsFactors = FALSE)
  stopifnot(isTRUE(all.equal(saved_manifest, manifest)),
            identical(manifest$file, output_files[1:2]),
            identical(manifest$rows, c(2L, 1L)),
            all(manifest$database == env$ngfs_database),
            all(manifest$endpoint == paste0(env$ngfs_base_url, "/runs/bulk/ts")),
            all(nzchar(manifest$downloaded_at_utc)))

  # A destination appearing during requests must not be overwritten either.
  raced_destination <- file.path(scratch, "created-during-query")
  calls <- 0L
  racing_query <- function(...) {
    calls <<- calls + 1L
    if (calls == 2L) {
      stopifnot(dir.create(raced_destination))
      stopifnot(file.copy(frozen[1], raced_destination))
    }
    global
  }
  expect_error(download(raced_destination, racing_query), "Could not create")
  stopifnot(length(list.files(raced_destination)) == 1L,
            identical(unname(tools::md5sum(file.path(raced_destination, basename(frozen[1])))),
                      unname(before[1])),
            identical(before, tools::md5sum(frozen)))
  cat("PASS: source is inert; destinations protected; query/schema failures write nothing;\n",
      "      valid stubs preserve filters/raw data and write three files; frozen hashes unchanged.\n")
})
