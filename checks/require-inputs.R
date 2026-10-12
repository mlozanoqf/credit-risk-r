require_chapter_inputs <- function(chapter) {
  scoring <- "data/credit-scoring/credit_scoring.rds"
  if (chapter %in% c("01-logistic", "02-tree-based") && !file.exists(scoring)) {
    stop(
      "Chapters 1 and 2 require ", scoring, ". ",
      "This dataset is temporarily excluded pending redistribution permission. ",
      "The complete code is available, but exact reproduction needs an authorized copy. ",
      "See data/credit-scoring/README.md. No replacement data are downloaded.",
      call. = FALSE
    )
  }
  invisible(TRUE)
}
