expected_shortfall <- function(losses, confidence) {
  stopifnot(is.numeric(losses), length(losses) > 0,
            all(is.finite(losses)), length(confidence) == 1,
            is.finite(confidence), confidence >= 0, confidence < 1)
  threshold <- unname(quantile(losses, confidence, type = 1))
  excess <- pmax(losses - threshold, 0)
  threshold + mean(excess) / (1 - confidence)
}
