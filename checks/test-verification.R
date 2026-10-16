# Offline unit tests; run from the companion root in the restored R library.
local({
  project <- normalizePath(".", winslash = "/", mustWork = TRUE)
  source(file.path(project, "shared/verification.R"), local = TRUE)
  root <- tempfile("companion-verification-")
  stopifnot(dir.create(root))
  on.exit(unlink(root, recursive = TRUE), add = TRUE)
  failures_checked <- 0L
  expect_error <- function(expr, pattern) {
    error <- tryCatch({ force(expr); NULL }, error = identity)
    stopifnot(inherits(error, "error"), grepl(pattern, conditionMessage(error)))
    failures_checked <<- failures_checked + 1L
  }
  put <- function(path, text) {
    full <- file.path(root, path)
    dir.create(dirname(full), recursive = TRUE, showWarnings = FALSE)
    writeLines(text, full, useBytes = TRUE)
  }
  csv <- function(value, path) utils::write.csv(value, file.path(root, path), row.names = FALSE)
  chapter <- "01-logistic"
  for (folder in c("checks", "data", "shared", paste0("chapters/", chapter))) {
    dir.create(file.path(root, folder), recursive = TRUE)
  }
  stopifnot(file.copy(file.path(project, "shared/verification.R"), file.path(root, "shared")),
            file.copy(file.path(project, "run.R"), root))
  put("_quarto.yml", "execute: {cache: false}")
  put("renv.lock", "{}")
  put("checks/require-inputs.R", "require_chapter_inputs <- function(chapter) invisible(TRUE)")
  jsonlite::write_json(list(list(id = chapter, source = paste0("chapters/", chapter, "/chapter.qmd"))),
                       file.path(root, "chapters.json"), auto_unbox = TRUE)
  put("data/frozen.txt", "frozen observations")
  csv(data.frame(path = "data/frozen.txt", md5 = unname(tools::md5sum(
    file.path(root, "data/frozen.txt")))), "data/input-checksums.csv")
  stopifnot(check_inputs(root) == 1L)
  put("data/frozen.txt", "mutated observations")
  expect_error(check_inputs(root), "checksum mismatch")
  unlink(file.path(root, "data/frozen.txt"))
  expect_error(check_inputs(root), "Missing reference input")
  put("data/frozen.txt", "frozen observations")

  rows <- data.frame(
    chapter = chapter, kind = c("Table", "Figure"), number = "1.1",
    title = c("Expected loss.", "Loss distribution."), book_id = c("tbl-loss", "fig-loss"),
    anchor = c("result-table-1-1", "result-figure-1-1"), chunk = c("table-1-1", "figure-1-1"),
    output = paste0("output/", chapter, c("/tables/table-1-1.csv", "/figures/figure-1-1-1.png")),
    source = paste0("chapters/", chapter, "/chapter.qmd"), source_line = c(2, 5),
    result_html = paste0("output/", chapter, "/chapter.html#", c("result-table-1-1", "result-figure-1-1")),
    stringsAsFactors = FALSE
  )
  csv(rows, "results-index.csv")
  csv(data.frame(kind = rows$kind, number = rows$number, book_id = rows$book_id,
                 companion_title = rows$title), "checks/book-results.csv")
  qmd <- c("### Table 1.1 {#result-table-1-1}", "```{r table-1-1}", "```",
           "### Figure 1.1 {#result-figure-1-1}", "```{r figure-1-1}", "```")
  put(rows$source[1], qmd)
  readme_path <- paste0("chapters/", chapter, "/README.md")
  readme <- paste0("| ", rows$kind, " ", rows$number, " | ", rows$title,
                   " | [Code](chapter.qmd#L", rows$source_line, ") |")
  put(readme_path, readme)
  html <- '<html><div id="result-table-1-1"></div><div id="result-figure-1-1"></div></html>'
  paths <- verification_outputs(root, chapter)
  manifest_path <- file.path(root, "output", chapter, "run-manifest.json")
  outputs <- function(timestamp = as.numeric(Sys.time()) + 0.25) {
    for (path in paths) put(path, "fresh output")
    put(paste0("output/", chapter, "/chapter.html"), html)
    saveRDS(list(loss = c(1, 2)), file.path(root, "output", chapter, "numeric-results.rds"))
    for (path in paths) Sys.setFileTime(file.path(root, path), as.POSIXct(timestamp, origin = "1970-01-01"))
  }
  finish <- function(run) complete_run(root, chapter, run$started, run$before, run$previous)
  good_run <- function() {
    run <- begin_run(root, chapter)
    outputs(run$started + 0.25)
    finish(run)
    check_freshness(root, chapter)
  }
  expect_error(check_freshness(root, chapter), "run the chapter through run.R")
  good_run()
  stopifnot(check_results(root, expected_count = 2L) == 2L)

  original_checksums <- verification_text(file.path(root, "data/input-checksums.csv"))
  put("data/frozen.txt", "new approved observations")
  csv(data.frame(path = "data/frozen.txt", md5 = unname(tools::md5sum(
    file.path(root, "data/frozen.txt")))), "data/input-checksums.csv")
  stopifnot(check_inputs(root) == 1L)
  expect_error(check_freshness(root, chapter), "source files changed")
  put("data/frozen.txt", "frozen observations")
  writeBin(charToRaw(original_checksums), file.path(root, "data/input-checksums.csv"))
  check_freshness(root, chapter)

  # Newline-only checkout changes preserve SHA-256; real source changes do not.
  before <- source_hashes(root)
  qmd_file <- file.path(root, rows$source[1])
  writeBin(charToRaw(paste0(paste(qmd, collapse = "\r\n"), "\r\n")), qmd_file)
  stopifnot(identical(before, source_hashes(root)))
  check_freshness(root, chapter)
  put(rows$source[1], c(qmd, "changed calculation"))
  expect_error(check_freshness(root, chapter), "source files changed")
  put(rows$source[1], qmd)
  put("shared/new-helper.R", "x <- 1")
  expect_error(check_freshness(root, chapter), "source files changed")
  unlink(file.path(root, "shared/new-helper.R"))

  output_file <- file.path(root, rows$output[1])
  saved_time <- file.info(output_file)$mtime
  put(rows$output[1], "tampered data")
  Sys.setFileTime(output_file, saved_time)
  expect_error(check_freshness(root, chapter), "modified output")
  good_run()
  Sys.setFileTime(output_file, Sys.time() - 3600)
  expect_error(check_freshness(root, chapter), "stale, or modified")
  good_run()
  unlink(output_file)
  expect_error(check_freshness(root, chapter), "modified output")
  good_run()

  run <- begin_run(root, chapter)
  stopifnot(!file.exists(manifest_path))
  # Recent unchanged outputs fail even within the two-second timestamp allowance.
  expect_error(finish(run), "stale output")
  outputs(run$started + 0.25)
  Sys.setFileTime(output_file, Sys.time() - 3600)
  expect_error(finish(run), "stale output")
  outputs(run$started + 0.25)
  put("_quarto.yml", "execute: {cache: true}")
  expect_error(finish(run), "Sources changed during rendering")
  put("_quarto.yml", "execute: {cache: false}")
  put("data/frozen.txt", "mutated during rendering")
  expect_error(finish(run), "checksum mismatch")
  put("data/frozen.txt", "frozen observations")
  good_run()

  changed <- rows
  changed$source_line[1] <- 3
  csv(changed, "results-index.csv")
  expect_error(check_results(root, 2L), "source anchor or chunk")
  changed <- rows
  changed$title[1] <- "Wrong title"
  csv(changed, "results-index.csv")
  expect_error(check_results(root, 2L), "Stale book result")
  csv(rows[c(1, 1), ], "results-index.csv")
  expect_error(check_results(root, 2L), "numbering changed")
  csv(rows, "results-index.csv")
  expect_error(check_results(root), "result count")
  put(readme_path, sub("#L2", "#L3", readme, fixed = TRUE))
  expect_error(check_results(root, 2L), "Stale README code link")
  put(readme_path, readme)
  put(paste0("output/", chapter, "/chapter.html"), "<html>missing anchors</html>")
  expect_error(check_results(root, 2L), "Missing HTML result anchor")
  good_run()
  writeBin(raw(), output_file)
  expect_error(check_results(root, 2L), "empty numbered output")
  good_run()

  case <- function(path, expected) list(path = path, expected = expected, atol = 1e-8, rtol = 1e-7)
  actual <- list(vector = c(0.1, 0.2), frame = data.frame(pd = c(0.3, 0.4)),
                 nested = list(c(5, 6)))
  cases <- list(case(list("vector"), c(0.1, 0.2)),
                case(list("frame", "pd"), c(0.3, 0.4)),
                case(list("nested", 1L, 2L), 6))
  stopifnot(check_numeric(actual, cases) == 3L)
  # Parse exactly as the real JSON fixtures, preserving expected arrays.
  json_cases <- jsonlite::fromJSON(jsonlite::toJSON(cases, auto_unbox = TRUE), simplifyVector = FALSE)
  stopifnot(check_numeric(actual, json_cases) == 3L)
  for (bad in list(case(list("vector"), c(0.1, 0.9)), case(list("vector"), 0.1),
                  case(list("missing"), 0), case(list("nested", 0L), 5),
                  case(list("nested", 3L), 5), case(list("vector"), c(NA, 0.2)))) {
    expect_error(check_numeric(actual, list(bad)), "Numeric reference mismatch")
  }
  for (bad in list(c(NA, 0.2), c(Inf, 0.2), c("0.1", "0.2"))) {
    expect_error(check_numeric(list(vector = bad), cases[1]), "Numeric reference mismatch")
  }
  expect_error(check_numeric(actual, list()), "Missing numerical reference")
  negative_tolerance <- cases[1]
  negative_tolerance[[1]]$atol <- -1
  expect_error(check_numeric(actual, negative_tolerance), "Numeric reference mismatch")

  split <- list(train = data.frame(x = 1:2, row.names = c("10", "30")),
                test = data.frame(x = 3:4, row.names = c("20", "40")))
  pinned <- scoring_split_hashes(split)
  check_scoring_split(split, pinned)
  alias <- split
  alias$training <- alias$train
  alias$train <- NULL
  check_scoring_split(alias, pinned)
  split$train <- split$train[2:1, , drop = FALSE]
  expect_error(check_scoring_split(split, pinned), "split identity mismatch")
  rownames(split$test)[1] <- rownames(split$train)[1]
  expect_error(check_scoring_split(split, pinned), "overlapping scoring split")

  # Exercise the real runner hooks with a fake Quarto subprocess, not a real render.
  runner <- new.env(parent = environment())
  sys.source(file.path(project, "run.R"), envir = runner)
  runner$Sys.which <- function(...) "mock-quarto"
  runner$system2 <- function(command, args) {
    stopifnot("--execute" %in% args)
    outputs()
    put(sub("\\.qmd$", ".html", rows$source[1]), html)
    0L
  }
  old_wd <- setwd(root)
  on.exit(setwd(old_wd), add = TRUE, after = FALSE)
  runner$run_chapter(chapter)
  check_freshness(root, chapter)
  runner$system2 <- function(...) 1L
  expect_error(runner$run_chapter(chapter), "Chapter render failed")
  stopifnot(!file.exists(manifest_path))
  runner$system2 <- function(...) 0L
  expect_error(runner$run_chapter(chapter), "stale output")
  stopifnot(!file.exists(manifest_path))
  setwd(old_wd)
  cat("PASS: verification and mocked runner;", failures_checked,
      "negative mutation, staleness, navigation, numerical and split checks.\n")
})
