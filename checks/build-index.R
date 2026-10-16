# Rebuild only result tables and source targets, preserving all README prose.
script <- sub("^--file=", "", grep("^--file=", commandArgs(), value = TRUE))
root <- dirname(dirname(normalizePath(script, winslash = "/", mustWork = TRUE)))
index_path <- file.path(root, "results-index.csv")
rows <- read.csv(index_path, colClasses = "character", check.names = FALSE)

read_text <- function(path) {
  rawToChar(readBin(path, "raw", n = file.info(path)$size))
}

write_changed <- function(path, text) {
  if (!identical(read_text(path), text)) writeBin(charToRaw(text), path)
}

update_readme <- function(path, chapter_rows) {
  original <- read_text(path)
  newline <- if (grepl("\r\n", original, fixed = TRUE)) "\r\n" else "\n"
  pattern <- paste0("(?m)^\\| Result \\| Title \\| Code \\|\\r?\\n",
                    "\\|---\\|---\\|---\\|\\r?\\n(?:\\|[^\\r\\n]*\\|\\r?\\n)*")
  match <- gregexpr(pattern, original, perl = TRUE)[[1]]
  stopifnot(length(match) == 1L, match[1] > 0)
  titles <- gsub("|", "\\|", chapter_rows$title, fixed = TRUE)
  table <- c("| Result | Title | Code |", "|---|---|---|",
             paste0("| ", chapter_rows$kind, " ", chapter_rows$number,
                    " | ", titles, " | [Code](chapter.qmd#L",
                    chapter_rows$source_line, ") |"))
  updated <- paste0(substr(original, 1, match[1] - 1),
                    paste0(table, collapse = newline), newline,
                    substring(original, match[1] + attr(match, "match.length")[1]))
  if (!identical(read_text(path), original)) {
    stop(path, " changed during the rebuild; rerun it")
  }
  write_changed(path, updated)
}

for (chapter in unique(rows$chapter)) {
  selected <- which(rows$chapter == chapter)
  sources <- unique(rows$source[selected])
  stopifnot(length(sources) == 1L)
  lines <- readLines(file.path(root, sources), warn = FALSE, encoding = "UTF-8")
  for (i in selected) {
    heading <- which(grepl(paste0("{#", rows$anchor[i], "}"), lines, fixed = TRUE))
    block <- which(lines == paste0("```{r ", rows$chunk[i], "}"))
    stopifnot(length(heading) == 1L, length(block) == 1L, block > heading)
    following <- which(grepl("{#result-", lines, fixed = TRUE) & seq_along(lines) > heading)
    stopifnot(!length(following) || block < min(following))
    rows$source_line[i] <- block
  }
  update_readme(file.path(root, "chapters", chapter, "README.md"), rows[selected, ])
}

# Match the existing minimal CSV quoting, including commas inside human titles.
csv_field <- function(x) {
  x <- as.character(x)
  quoted <- grepl('[,"\r\n]', x)
  x[quoted] <- paste0('"', gsub('"', '""', x[quoted], fixed = TRUE), '"')
  x
}
encoded <- as.data.frame(lapply(rows, csv_field), stringsAsFactors = FALSE)
csv_lines <- c(paste(names(rows), collapse = ","),
               apply(encoded, 1, paste, collapse = ","))
newline <- if (grepl("\r\n", read_text(index_path), fixed = TRUE)) "\r\n" else "\n"
write_changed(index_path, paste0(paste(csv_lines, collapse = newline), newline))
cat("Indexed", nrow(rows), "results across", length(unique(rows$chapter)), "chapters.\n")
