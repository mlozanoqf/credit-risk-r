# Frozen inputs, source freshness, navigation, and numerical regression checks.
verification_csv <- function(path) {
  utils::read.csv(path, colClasses = "character", check.names = FALSE,
                  fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE)
}

verification_text <- function(path) {
  if (!file.exists(path) || dir.exists(path)) stop("Missing file: ", path)
  rawToChar(readBin(path, "raw", n = file.info(path)$size))
}

check_inputs <- function(root) {
  rows <- verification_csv(file.path(root, "data/input-checksums.csv"))
  if (!all(c("path", "md5") %in% names(rows)) || !nrow(rows) ||
      anyNA(rows[c("path", "md5")]) || anyDuplicated(rows$path)) {
    stop("Invalid frozen input checksum index.")
  }
  paths <- file.path(root, rows$path)
  present <- file.exists(paths) & !dir.exists(paths)
  if (!all(present)) stop("Missing reference input: ", paste(rows$path[!present], collapse = ", "))
  matching <- unname(tools::md5sum(paths)) == rows$md5
  if (!all(matching)) stop("Reference input checksum mismatch: ",
                           paste(rows$path[!matching], collapse = ", "))
  nrow(rows)
}

source_hashes <- function(root) {
  paths <- c("run.R", "_quarto.yml", "chapters.json", "results-index.csv", "renv.lock",
             "checks/require-inputs.R", "data/input-checksums.csv")
  for (folder in c("chapters", "shared")) {
    paths <- c(paths, paste0(folder, "/", list.files(
      file.path(root, folder), pattern = "\\.(R|qmd)$", recursive = TRUE)))
  }
  paths <- sort(unique(paths))
  hashes <- lapply(paths, function(path) {
    text <- gsub("\r\n", "\n", verification_text(file.path(root, path)), fixed = TRUE)
    digest::digest(charToRaw(text), algo = "sha256", serialize = FALSE)
  })
  stats::setNames(hashes, paths)
}

verification_outputs <- function(root, chapter) {
  chapters <- jsonlite::fromJSON(file.path(root, "chapters.json"))
  if (!chapter %in% chapters$id) stop("Unknown chapter: ", chapter)
  index <- verification_csv(file.path(root, "results-index.csv"))
  out <- paste0("output/", chapter, "/")
  paths <- c(index$output[index$chapter == chapter], paste0(out, c(
    "numeric-results.rds", "chapter.html", "session-info.txt", "loaded-packages.csv")))
  if (chapter == "00-foundations") {
    paths <- c(paths, paste0(out, "figures/", c("step-015-1.png", "step-020-1.png")))
  }
  unique(paths)
}

verification_file_state <- function(path) {
  if (!file.exists(path) || dir.exists(path)) return(NULL)
  info <- file.info(path)
  list(sha256 = digest::digest(file = path, algo = "sha256"),
       size = unname(info$size), mtime = as.numeric(info$mtime))
}

verification_assert_regenerated <- function(path, started, previous) {
  current <- verification_file_state(path)
  if (is.null(current) || current$size == 0 || current$mtime < started - 2 ||
      (!is.null(previous) && identical(current, previous))) {
    stop("Missing or stale output from this run: ", path)
  }
  current
}

begin_run <- function(root, chapter) {
  check_inputs(root)
  paths <- verification_outputs(root, chapter)
  previous <- stats::setNames(lapply(paths, function(path) {
    verification_file_state(file.path(root, path))
  }), paths)
  manifest <- file.path(root, "output", chapter, "run-manifest.json")
  if (file.exists(manifest) && !file.remove(manifest)) {
    stop("Could not invalidate the previous run manifest.")
  }
  list(started = as.numeric(Sys.time()), before = source_hashes(root), previous = previous)
}

complete_run <- function(root, chapter, started, before, previous) {
  after <- source_hashes(root)
  if (!identical(after, before)) stop("Sources changed during rendering; rerun the chapter.")
  check_inputs(root)
  paths <- verification_outputs(root, chapter)
  if (!identical(names(previous), paths)) stop("Output index changed during rendering.")
  outputs <- stats::setNames(lapply(paths, function(path) {
    verification_assert_regenerated(file.path(root, path), started, previous[[path]])
  }), paths)
  manifest <- list(version = 1L, sources = after, started = started,
                   outputs = outputs, r_version = as.character(getRversion()))
  jsonlite::write_json(manifest, file.path(root, "output", chapter, "run-manifest.json"),
                       auto_unbox = TRUE, pretty = TRUE, digits = NA)
  invisible(manifest)
}

check_freshness <- function(root, chapter) {
  path <- file.path(root, "output", chapter, "run-manifest.json")
  if (!file.exists(path)) stop(chapter, ": run the chapter through run.R before verification.")
  recorded <- jsonlite::read_json(path, simplifyVector = FALSE)
  if (!identical(recorded$sources, source_hashes(root))) {
    stop(chapter, ": source files changed after rendering; rerun the chapter.")
  }
  paths <- verification_outputs(root, chapter)
  if (!identical(recorded$version, 1L) || !is.numeric(recorded$started) ||
      length(recorded$started) != 1L || !is.finite(recorded$started) ||
      !identical(names(recorded$outputs), paths)) stop("Invalid run manifest: ", chapter)
  for (relative in paths) {
    current <- verification_file_state(file.path(root, relative))
    saved <- recorded$outputs[[relative]]
    if (is.null(current) || current$size == 0 ||
        !identical(current$sha256, saved$sha256) ||
        !isTRUE(current$size == saved$size) ||
        !isTRUE(abs(current$mtime - saved$mtime) < 0.00001) ||
        current$mtime < recorded$started - 2) {
      stop("Missing, stale, or modified output: ", relative)
    }
  }
  invisible(TRUE)
}

check_numeric <- function(actual, cases) {
  if (!is.list(cases) || !length(cases)) stop("Missing numerical reference cases.")
  for (case in cases) {
    label <- paste(unlist(case$path), collapse = "/")
    fail <- function() stop("Numeric reference mismatch: ", label)
    if (!length(case$path)) fail()
    value <- actual
    for (key in case$path) {
      if (length(key) != 1L || is.na(key)) fail()
      if (is.character(key)) {
        if (is.null(names(value)) || !key %in% names(value)) fail()
        value <- value[[key, exact = TRUE]]
      } else if (is.numeric(key) && is.finite(key) && key >= 1 &&
                 key == floor(key) && key <= length(value)) {
        value <- value[[as.integer(key)]]
      } else fail()
    }
    expected <- unlist(case$expected, use.names = FALSE)
    tolerance <- c(case$atol, case$rtol)
    if (!(is.numeric(value) || is.logical(value)) || !is.numeric(expected) ||
        !length(expected) || length(value) != length(expected) ||
        !is.numeric(tolerance) || length(tolerance) != 2L ||
        any(!is.finite(tolerance)) || any(tolerance < 0) ||
        any(!is.finite(value)) || any(!is.finite(expected))) fail()
    if (any(abs(as.numeric(value) - expected) >
            pmax(case$atol, case$rtol * pmax(abs(value), abs(expected))))) fail()
  }
  length(cases)
}

scoring_split_hashes <- function(snapshot) {
  train <- if (!is.null(snapshot$train)) snapshot$train else snapshot$training
  test <- snapshot$test
  if (!is.data.frame(train) || !is.data.frame(test)) stop("Missing scoring split data frames.")
  ids <- list(train = rownames(train), test = rownames(test))
  if (anyDuplicated(c(ids$train, ids$test))) stop("Duplicate or overlapping scoring split IDs.")
  lapply(ids, function(x) list(rows = length(x), sha256 = digest::digest(
    paste0(paste(x, collapse = "\n"), "\n"), algo = "sha256", serialize = FALSE)))
}

check_scoring_split <- function(snapshot, expected = list(
    train = list(rows = 20000L, sha256 = "fbcd3a63c5bc13206042a08ee549e396f45543cc03099a454121db755dd02875"),
    test = list(rows = 10000L, sha256 = "833b64bff81285fa3389e527079532d03383a9d79edd3496b5563cc3ff86e27e"))) {
  # Independent pre-edit audit: ordered original row names, LF-separated + final LF.
  if (!identical(scoring_split_hashes(snapshot), expected)) {
    stop("Frozen scoring split identity mismatch (ordered train/test row names).")
  }
  invisible(TRUE)
}

check_results <- function(root, expected_count = 211L) {
  rows <- verification_csv(file.path(root, "results-index.csv"))
  book <- verification_csv(file.path(root, "checks/book-results.csv"))
  columns <- c("chapter", "kind", "number", "title", "book_id", "anchor", "chunk",
               "output", "source", "source_line", "result_html")
  if (!all(columns %in% names(rows)) ||
      !all(c("kind", "number", "book_id", "companion_title") %in% names(book)) ||
      anyNA(rows[columns]) || anyNA(book) || nrow(rows) != expected_count ||
      nrow(book) != expected_count) stop("Invalid book/result index or result count.")
  keys <- paste(rows$kind, rows$number)
  reference_keys <- paste(book$kind, book$number)
  if (anyDuplicated(keys) || anyDuplicated(reference_keys) || anyDuplicated(rows$book_id) ||
      anyDuplicated(rows$output) || !setequal(keys, reference_keys)) {
    stop("Book/result numbering changed; review the reference index.")
  }
  reference <- book[match(keys, reference_keys), ]
  if (!identical(rows$book_id, reference$book_id) ||
      !identical(rows$title, reference$companion_title)) stop("Stale book result ID or title.")
  chapters <- jsonlite::fromJSON(file.path(root, "chapters.json"))
  if (!all(rows$chapter %in% chapters$id)) stop("Unknown chapter in result index.")
  for (chapter in chapters$id) {
    selected <- rows[rows$chapter == chapter, ]
    source <- chapters$source[match(chapter, chapters$id)]
    lines <- readLines(file.path(root, source), warn = FALSE, encoding = "UTF-8")
    readme <- readLines(file.path(root, "chapters", chapter, "README.md"),
                        warn = FALSE, encoding = "UTF-8")
    html <- verification_text(file.path(root, "output", chapter, "chapter.html"))
    code_links <- gregexpr("[Code](", paste(readme, collapse = "\n"), fixed = TRUE)[[1]]
    if (sum(code_links > 0) != nrow(selected)) stop("Stale README code link count: ", chapter)
    for (i in seq_len(nrow(selected))) {
      row <- selected[i, ]
      line <- suppressWarnings(as.integer(row$source_line))
      heading <- which(grepl(paste0("{#", row$anchor, "}"), lines, fixed = TRUE))
      following <- which(grepl("{#result-", lines, fixed = TRUE) & seq_along(lines) > heading[1])
      if (row$source != source || is.na(line) || line < 1 || line > length(lines) ||
          length(heading) != 1L || line <= heading ||
          (length(following) && line >= min(following)) ||
          lines[line] != paste0("```{r ", row$chunk, "}") ||
          sum(lines == paste0("```{r ", row$chunk, "}")) != 1L) {
        stop("Stale source anchor or chunk link: ", row$book_id)
      }
      expected_link <- paste0("| ", row$kind, " ", row$number, " | ",
        gsub("|", "\\|", row$title, fixed = TRUE), " | [Code](chapter.qmd#L", line, ") |")
      if (!expected_link %in% readme) stop("Stale README code link: ", row$book_id)
      if (row$result_html != paste0("output/", chapter, "/chapter.html#", row$anchor) ||
          !(grepl(paste0('id="', row$anchor, '"'), html, fixed = TRUE) ||
            grepl(paste0("id='", row$anchor, "'"), html, fixed = TRUE))) {
        stop("Missing HTML result anchor: ", row$book_id)
      }
      output <- file.path(root, row$output)
      if (!file.exists(output) || dir.exists(output) || file.info(output)$size == 0) {
        stop("Missing or empty numbered output: ", row$output)
      }
    }
  }
  nrow(rows)
}
