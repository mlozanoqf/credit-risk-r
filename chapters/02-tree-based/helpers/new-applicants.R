# Store the training schema once; apply it without looking at repayment outcomes.
make_xgb_encoder <- function(training, formula, reference_columns) {
  frame <- model.frame(formula, training, na.action = na.fail)
  factor_names <- names(frame)[vapply(frame, is.factor, logical(1))]
  factor_levels <- lapply(frame[factor_names], levels)
  training_matrix <- model.matrix(formula, frame)
  contrasts_used <- attr(training_matrix, "contrasts")
  if (!identical(colnames(training_matrix)[-1], reference_columns)) {
    stop("Training schema differs from the fitted model columns.")
  }
  force(formula)
  force(reference_columns)
  function(applicants) {
    required <- all.vars(formula)
    if (!all(required %in% names(applicants)) || nrow(applicants) == 0L) {
      stop("Supply at least one applicant and every predictor.")
    }
    applicants <- applicants[, required, drop = FALSE]
    for (name in factor_names) {
      values <- as.character(applicants[[name]])
      if (anyNA(values) || any(!values %in% factor_levels[[name]])) {
        stop("Missing or unseen category in ", name, "; review before scoring.")
      }
      applicants[[name]] <- factor(values, levels = factor_levels[[name]])
    }
    numeric_names <- setdiff(required, factor_names)
    if (!all(vapply(applicants[numeric_names], function(x) {
      is.numeric(x) && all(is.finite(x))
    }, logical(1)))) stop("Numeric predictors must be finite numbers.")
    if (any(applicants$l_amnt <= 0 | applicants$income <= 0)) {
      stop("Loan amount and income must be positive before taking logs.")
    }
    encoded <- model.matrix(formula, applicants,
      contrasts.arg = contrasts_used, xlev = factor_levels)[, -1, drop = FALSE]
    if (!identical(colnames(encoded), reference_columns) ||
        nrow(encoded) != nrow(applicants) || any(!is.finite(encoded))) {
      stop("New applicants do not match the fitted model schema.")
    }
    encoded
  }
}
