# Output support shared by all chapter entry files; no model calculations.
companion_setup <- function(chapter) {
  source("checks/require-inputs.R", local = TRUE)
  require_chapter_inputs(chapter)
  stopifnot(file.exists("chapters.json"), file.exists("renv.lock"))
  expected <- jsonlite::read_json("renv.lock")$R$Version
  if (as.character(getRversion()) != expected) {
    warning("Reference R version is ", expected, "; current version is ", getRversion())
  }
  out <- file.path("output", chapter)
  for (folder in c("figures", "tables")) {
    dir.create(file.path(out, folder), recursive = TRUE, showWarnings = FALSE)
  }
  options(companion.output = out)
  knitr::opts_chunk$set(cache = FALSE, error = FALSE, echo = TRUE,
    message = FALSE, warning = FALSE, dev = "png", dpi = 150,
    fig.width = 5.5, fig.height = 4, fig.path = paste0("../../", out, "/figures/"))
  invisible(out)
}

companion_kable <- function(x, ...) {
  label <- knitr::opts_current$get("label")
  args <- list(...)
  if (grepl("^table-", label)) {
    stem <- file.path(getOption("companion.output"), "tables", label)
    saveRDS(x, paste0(stem, ".rds"))
    csv <- as.data.frame(x)
    if (!is.null(args$col.names) && length(args$col.names) == ncol(csv)) {
      names(csv) <- args$col.names
    }
    utils::write.csv(csv, paste0(stem, ".csv"), row.names = isTRUE(args$row.names),
                     fileEncoding = "UTF-8")
    if (!is.null(args$caption)) {
      number <- gsub("-", ".", sub("^table-", "", label))
      args$caption <- paste0("Table ", number, ". ", args$caption)
    }
  }
  table <- do.call(knitr::kable, c(list(x = x), args))
  if (grepl("^table-", label)) writeLines(as.character(table), paste0(stem, ".html"))
  table
}

companion_finish <- function(envir) {
  out <- getOption("companion.output")
  numeric_part <- function(x) {
    if (is.numeric(x) || is.logical(x)) return(x)
    if (is.data.frame(x)) {
      x <- as.data.frame(x)
      return(x[vapply(x, function(y) is.numeric(y) || is.logical(y), logical(1))])
    }
    NULL
  }
  snapshot <- lapply(as.list(envir), numeric_part)
  snapshot <- snapshot[!vapply(snapshot, is.null, logical(1))]
  saveRDS(snapshot, file.path(out, "numeric-results.rds"))
  writeLines(capture.output(sessionInfo()), file.path(out, "session-info.txt"))
  packages <- sort(loadedNamespaces())
  utils::write.csv(data.frame(package = packages,
    version = vapply(packages, function(p) as.character(packageVersion(p)), character(1))),
    file.path(out, "loaded-packages.csv"), row.names = FALSE)
  cat("Saved", length(snapshot), "numeric objects and session information.\n")
}
