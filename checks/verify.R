# Run from the companion root in the restored R library: Rscript checks/verify.R
verify_companion <- function(root = ".") {
  root <- normalizePath(root, winslash = "/", mustWork = TRUE)
  source(file.path(root, "shared/verification.R"), local = TRUE)
  cat("Inputs:", check_inputs(root), "frozen files match.\n")
  results <- check_results(root)
  reference <- jsonlite::read_json(file.path(root, "checks/numeric-reference.json"),
                                   simplifyVector = FALSE)
  chapters <- jsonlite::fromJSON(file.path(root, "chapters.json"))
  if (!setequal(names(reference$chapters), chapters$id)) {
    stop("Numerical reference must cover every chapter exactly.")
  }
  count <- 0L
  for (chapter in chapters$id) {
    check_freshness(root, chapter)
    snapshot <- readRDS(file.path(root, "output", chapter, "numeric-results.rds"))
    n <- check_numeric(snapshot, reference$chapters[[chapter]])
    if (chapter %in% c("01-logistic", "02-tree-based")) check_scoring_split(snapshot)
    count <- count + n
    cat(chapter, ": fresh outputs; ", n, " numerical reference checks passed.\n", sep = "")
  }
  cat("PASS:", results, "book results and", count, "pinned-environment numerical checks.\n")
  invisible(list(results = results, numeric_checks = count))
}

if (sys.nframe() == 0L) verify_companion()
