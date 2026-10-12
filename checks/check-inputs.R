x <- read.csv("data/input-checksums.csv")
scoring <- "data/credit-scoring/credit_scoring.rds"
present <- file.exists(x$path)
missing <- x$path[!present & x$path != scoring]
if (length(missing)) stop("Missing distributed inputs: ", paste(missing, collapse = ", "))
if (any(!present & x$path == scoring)) {
  cat("UNAVAILABLE: credit-scoring data are excluded; Chapters 1-2 cannot run in full.\n")
}
stopifnot(identical(unname(tools::md5sum(x$path[present])), x$md5[present]))
cat("PASS:", sum(present), "available frozen input files match.\n")
