# Run from the project root. Each chapter render starts its own R session.
run_chapter <- function(chapter) {
  if (!file.exists("chapters.json")) stop("Run from the credit-risk-r project root.")
  source("checks/require-inputs.R", local = TRUE)
  require_chapter_inputs(chapter)
  chapters <- jsonlite::fromJSON("chapters.json")
  if (!chapter %in% chapters$id) stop("Choose one of: ", paste(chapters$id, collapse = ", "))
  source("shared/verification.R", local = TRUE)
  quarto <- Sys.which("quarto")
  if (!nzchar(quarto)) stop("Install Quarto and make its executable available on PATH.")
  old <- Sys.getenv("QUARTO_R", unset = NA_character_)
  on.exit(if (is.na(old)) Sys.unsetenv("QUARTO_R") else Sys.setenv(QUARTO_R = old))
  Sys.setenv(QUARTO_R = R.home("bin"))
  chapter_source <- chapters$source[match(chapter, chapters$id)]
  result <- sub("\\.qmd$", ".html", chapter_source)
  rendered_before <- verification_file_state(result)
  run <- begin_run(".", chapter)
  status <- system2(quarto, c("render", shQuote(chapter_source), "--to", "html", "--execute"))
  if (status != 0L) stop("Chapter render failed; inspect the error above.")
  verification_assert_regenerated(result, run$started, rendered_before)
  destination <- file.path("output", chapter, "chapter.html")
  if (!file.exists(result) || !file.copy(result, destination, overwrite = TRUE)) {
    stop("Could not copy the chapter HTML to its output directory.")
  }
  index <- utils::read.csv("results-index.csv", stringsAsFactors = FALSE)
  expected <- index$output[index$chapter == chapter]
  missing <- expected[!file.exists(expected)]
  if (length(missing)) stop("Missing numbered outputs: ", paste(missing, collapse = ", "))
  complete_run(".", chapter, run$started, run$before, run$previous)
  cat("Complete:", destination, "\n")
  invisible(destination)
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) != 1L) stop("Usage: Rscript run.R <chapter-id>")
  run_chapter(args[1])
}
