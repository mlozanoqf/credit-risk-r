x <- read.csv("data/input-checksums.csv")
present <- file.exists(x$path)
missing <- x$path[!present]
if (length(missing)) stop("Missing distributed inputs: ", paste(missing, collapse = ", "))
stopifnot(identical(unname(tools::md5sum(x$path[present])), x$md5[present]))
cat("PASS:", sum(present), "available frozen input files match.\n")
