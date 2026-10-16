# Financial policy calculations shared by the chapter and instructor applications.
credit_policy_curve <- function(actual, model_name, prob_of_default,
                                acceptance_grid = seq(.50, .95, .05),
                                good_loan_payoff = 1, bad_loan_cost = 5) {
  do.call(rbind, lapply(acceptance_grid, function(accept_rate) {
    cutoff <- unname(quantile(prob_of_default, accept_rate, type = 7))
    accept <- prob_of_default <= cutoff
    accepted <- sum(accept)
    accepted_good <- sum(actual[accept] == 0)
    accepted_defaults <- sum(actual[accept] == 1)
    data.frame(
      model = model_name, accept_rate = accept_rate,
      actual_accept_rate = accepted / length(actual),
      cutoff = cutoff, accepted = accepted,
      accepted_good = accepted_good, accepted_defaults = accepted_defaults,
      bad_rate = accepted_defaults / accepted,
      net_payoff = accepted_good * good_loan_payoff - accepted_defaults * bad_loan_cost
    )
  }))
}

credit_calibration_table <- function(actual, application_row, model_name,
                                     prob_of_default, groups = 10) {
  data.frame(model = model_name, application_row = application_row,
             observed_default = actual, predicted_pd = prob_of_default) |>
    dplyr::arrange(model, predicted_pd, application_row) |>
    dplyr::group_by(model) |>
    dplyr::mutate(risk_decile = dplyr::ntile(predicted_pd, groups)) |>
    dplyr::group_by(model, risk_decile) |>
    dplyr::summarize(applications = dplyr::n(),
      average_predicted_pd = mean(predicted_pd),
      observed_default_rate = mean(observed_default),
      brier_score = mean((predicted_pd - observed_default)^2), .groups = "drop")
}
