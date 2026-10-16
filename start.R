# Reader entry point. Calculations and output checks remain in run.R.
reader_root <- function() {
  required <- c("chapters.json", "run.R", "renv.lock", "credit-risk-r.Rproj")
  if (!all(file.exists(required))) {
    stop("Open credit-risk-r.Rproj in RStudio first, then run these commands in its Console.", call. = FALSE)
  }
  normalizePath(".", winslash = "/", mustWork = TRUE)
}

check_setup <- function() {
  reader_root()
  cat("R version:", as.character(getRversion()), "(reference: 4.6.1)\n")
  if (getRversion() != numeric_version("4.6.1")) {
    warning("This R version differs from the reference. Use R 4.6.1 for the recorded environment.", call. = FALSE)
  }
  quarto <- Sys.which("quarto")
  if (!nzchar(quarto)) {
    stop("Quarto was not found. Install Quarto, restart RStudio, and try again. See README.md.", call. = FALSE)
  }
  version <- system2(quarto, "--version", stdout = TRUE, stderr = TRUE)
  if (!is.null(attr(version, "status")) && attr(version, "status") != 0L) {
    stop("Quarto could not start. See README.md troubleshooting.", call. = FALSE)
  }
  cat("Quarto version:", paste(version, collapse = " "), "(reference: 1.5.54)\n")
  if (!identical(trimws(paste(version, collapse = " ")), "1.5.54")) {
    warning("Quarto differs from the tested version; report layout may differ.", call. = FALSE)
  }
  if (!requireNamespace("renv", quietly = TRUE) || !requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Restore packages first with renv::restore(prompt = FALSE). Reopen the project if renv is unavailable.", call. = FALSE)
  }
  status <- renv::status()
  if (!isTRUE(status$synchronized)) {
    stop("The package environment needs attention. Run renv::restore(prompt = FALSE), then check_setup() again. See README.md if the warning remains.", call. = FALSE)
  }
  cat("Setup check passed. No packages or data were changed.\n")
  invisible(TRUE)
}

reader_run <- function(chapter) {
  runner <- new.env(parent = globalenv())
  sys.source("run.R", envir = runner)
  runner$run_chapter(chapter)
}

reader_choose <- function(chapters, choose = utils::menu) {
  selected <- choose(paste(chapters$id, chapters$title, sep = " | "),
                     title = "Choose a chapter (0 exits without running):")
  if (selected == 0L) return(NULL)
  chapters$id[selected]
}

start_chapter <- function(chapter = NULL, open = interactive()) {
  reader_root()
  check_setup()
  chapters <- jsonlite::fromJSON("chapters.json")
  if (is.null(chapter)) {
    if (!interactive()) {
      stop('Specify a chapter, for example start_chapter("00-foundations", open = FALSE).', call. = FALSE)
    }
    chapter <- reader_choose(chapters)
    if (is.null(chapter)) return(invisible(NULL))
  }
  if (length(chapter) != 1L || is.na(chapter) || !chapter %in% chapters$id) {
    stop("Choose one of: ", paste(chapters$id, collapse = ", "), call. = FALSE)
  }
  cat("Running", chapter, ". Keep RStudio open until Complete appears.\n")
  report <- reader_run(chapter)
  report <- normalizePath(report, winslash = "/", mustWork = TRUE)
  cat("Your report is ready:\n", report, "\n", sep = "")
  if (isTRUE(open)) {
    tryCatch(utils::browseURL(report), error = function(e) {
      message("The report is complete, but the browser could not open. Open the HTML path printed above.")
    })
  }
  invisible(report)
}
