require_chapter_inputs <- function(chapter) {
  scoring <- "data/credit-scoring/credit_scoring.rds"
  if (chapter %in% c("01-logistic", "02-tree-based") && !file.exists(scoring)) {
    stop(
      "Chapters 1 and 2 require ", scoring, ". ",
      "The frozen dataset is included in the private companion checkout. ",
      "Download or clone the complete repository rather than an individual QMD. ",
      "See data/credit-scoring/README.md. No replacement data are downloaded.",
      call. = FALSE
    )
  }
  invisible(TRUE)
}
