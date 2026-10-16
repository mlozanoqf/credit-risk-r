# Reader entry point tests; chapter calculations remain in the existing runner.
scope <- new.env(parent = globalenv())
sys.source("start.R", envir = scope)
expect_error <- function(expr, pattern) {
  message <- tryCatch({ force(expr); NA_character_ }, error = conditionMessage)
  stopifnot(!is.na(message), grepl(pattern, message, fixed = TRUE))
}
chapters <- jsonlite::fromJSON("chapters.json")
stopifnot(is.null(scope$reader_choose(chapters, function(...) 0L)))
stopifnot(identical(scope$reader_choose(chapters, function(...) 2L), "01-logistic"))

old <- getwd()
setwd(tempdir())
expect_error(scope$reader_root(), "Open credit-risk-r.Rproj")
setwd(old)

scope$Sys.which <- function(...) c(quarto = "")
expect_error(scope$check_setup(), "Quarto was not found")
rm("Sys.which", envir = scope)
scope$requireNamespace <- function(...) FALSE
expect_error(scope$check_setup(), "Restore packages first")
rm("requireNamespace", envir = scope)

scope$check_setup <- function() TRUE
expect_error(scope$start_chapter("not-a-chapter", open = FALSE), "Choose one of:")
expect_error(scope$start_chapter(open = FALSE), "Specify a chapter")
scope$reader_run <- function(chapter) stop("simulated runner failure")
expect_error(scope$start_chapter("00-foundations", open = FALSE), "simulated runner failure")
scope$interactive <- function() TRUE
scope$reader_choose <- function(...) NULL
stopifnot(is.null(scope$start_chapter(open = FALSE)))
rm("interactive", envir = scope)

report <- tempfile(fileext = ".html")
writeLines("<html><body>test report</body></html>", report)
chosen <- NULL
scope$reader_run <- function(chapter) { chosen <<- chapter; report }
stopifnot(identical(scope$start_chapter("00-foundations", open = FALSE),
                    normalizePath(report, winslash = "/")))
stopifnot(identical(chosen, "00-foundations"))
browser_file <- tempfile()
old_browser <- getOption("browser")
options(browser = function(url, ...) writeLines(url, browser_file))
scope$start_chapter("00-foundations", open = TRUE)
stopifnot(file.exists(browser_file), grepl(basename(report), readLines(browser_file), fixed = TRUE))
options(browser = function(...) stop("browser unavailable"))
stopifnot(file.exists(scope$start_chapter("00-foundations", open = TRUE)))
options(browser = old_browser)
unlink(c(report, browser_file))
cat("Reader starter tests passed.\n")
