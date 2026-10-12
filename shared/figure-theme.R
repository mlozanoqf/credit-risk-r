# Explicit presentation settings for the publisher manuscript.
book_plot_colors <- c(primary = "#0072B2", age = "#B77900",
                      interest = "#009E73", multi = "#7A5195",
                      risk = "#B22222", reference = "#666666", text = "#222222")
book_model_colors <- c(logi_full = book_plot_colors[["primary"]],
                       logi_age = book_plot_colors[["age"]],
                       logi_int = book_plot_colors[["interest"]],
                       logi_multi = book_plot_colors[["multi"]])
book_model_labels <- c(logi_full = "Full model", logi_age = "Age only",
                       logi_int = "Interest rate", logi_multi = "Multi-factor")
book_prediction_colors <- setNames(book_model_colors, paste0("pred_", names(book_model_colors)))
book_prediction_labels <- setNames(book_model_labels, paste0("pred_", names(book_model_labels)))

book_tree_colors <- c(logi_full = book_plot_colors[["primary"]],
                      single_tree = book_plot_colors[["reference"]],
                      xgboost = book_plot_colors[["age"]])
book_tree_labels <- c(logi_full = "Full logistic model", single_tree = "Single tree",
                      xgboost = "XGBoost")

book_figure_theme <- function(base_size = 10) {
  ggplot2::theme_minimal(base_size = base_size, base_family = "sans") +
    ggplot2::theme(
      text = ggplot2::element_text(color = book_plot_colors[["text"]]),
      axis.text = ggplot2::element_text(size = base_size - 1, color = book_plot_colors[["text"]]),
      axis.title = ggplot2::element_text(size = base_size),
      axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 6)),
      axis.title.y = ggplot2::element_text(margin = ggplot2::margin(r = 6)),
      panel.grid.major = ggplot2::element_line(color = "grey88", linewidth = 0.18),
      panel.grid.minor = ggplot2::element_blank(),
      panel.background = ggplot2::element_rect(fill = "white", color = NA),
      plot.background = ggplot2::element_rect(fill = "white", color = NA),
      strip.text = ggplot2::element_text(size = base_size, face = "bold"),
      panel.spacing = grid::unit(12, "pt"),
      legend.position = "bottom",
      legend.text = ggplot2::element_text(size = base_size - 1),
      legend.title = ggplot2::element_blank(),
      legend.background = ggplot2::element_rect(fill = "white", color = NA),
      legend.key = ggplot2::element_rect(fill = "white", color = NA),
      plot.margin = ggplot2::margin(8, 10, 8, 8)
    )
}
