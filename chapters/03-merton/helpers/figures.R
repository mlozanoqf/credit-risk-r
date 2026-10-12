# Presentation helpers; financial calculations remain in the chapter.
source("shared/figure-theme.R")

capital_curve_labels <- function(labels) {
  as.expression(lapply(labels, function(label) {
    if (!grepl("^E0=", label)) return(label)
    value <- as.numeric(sub(" .*", "", sub("^E0=", "", label)))
    if (grepl("initial value", label, fixed = TRUE)) {
      bquote(E[0] == .(value) ~ "(initial value)")
    } else {
      bquote(E[0] == .(value))
    }
  }))
}

plot_capital_structure <- function(curve_data, color_values,
                                   x_label, y_label,
                                   v_lines = NULL, h_lines = NULL,
                                   points_data = NULL,
                                   x_limits = NULL, y_limits = NULL,
                                   legend_text_size = 9) {
  p <- ggplot2::ggplot(
    curve_data,
    ggplot2::aes(
      x = promised_debt,
      y = risk_neutral_pd,
      color = curve
    )
  ) +
    ggplot2::geom_line(linewidth = 0.8) +
    ggplot2::scale_color_manual(values = color_values, labels = capital_curve_labels) +
    ggplot2::scale_y_continuous(labels = function(x) fmt_pct(x, 0)) +
    ggplot2::labs(x = x_label, y = y_label, color = NULL) +
    ggplot2::coord_cartesian(xlim = x_limits, ylim = y_limits) +
    book_figure_theme() +
    ggplot2::theme(
      legend.position = "bottom",
      legend.justification = "center",
      legend.background = ggplot2::element_rect(
        fill = "white",
        color = NA,
        linewidth = 0.3
      ),
      legend.key = ggplot2::element_rect(fill = "white", color = NA),
      legend.text = ggplot2::element_text(size = legend_text_size)
    )

  if (!is.null(v_lines)) {
    p <- p + ggplot2::geom_vline(
      xintercept = v_lines,
      linetype = "dashed",
      linewidth = 0.35,
      color = "black"
    )
  }

  if (!is.null(h_lines)) {
    p <- p + ggplot2::geom_hline(
      yintercept = h_lines,
      linetype = "dashed",
      linewidth = 0.35,
      color = "black"
    )
  }

  if (!is.null(points_data)) {
    for (i in seq_len(nrow(points_data))) {
      p <- p + ggplot2::geom_point(
        data = points_data[i, ],
        ggplot2::aes(x = promised_debt, y = risk_neutral_pd),
        inherit.aes = FALSE,
        shape = 21,
        size = 4,
        stroke = 0.7,
        color = "black",
        fill = points_data$point_fill[i]
      )
    }
  }

  p
}

plot_pd_sensitivity <- function(x, y, current_x, x_label,
                                y_limits = NULL, x_as_percent = FALSE,
                                y_digits = 0) {
  plot_data <- data.frame(
    input_value = x,
    risk_neutral_pd = y
  )
  current_point <- data.frame(
    input_value = current_x,
    risk_neutral_pd = pd1
  )
  if (is.null(y_limits)) {
    y_limits <- c(0, max(c(y, pd1), na.rm = TRUE) * 1.06)
  }

  p <- ggplot2::ggplot(
    plot_data,
    ggplot2::aes(x = input_value, y = risk_neutral_pd)
  ) +
    ggplot2::geom_hline(
      yintercept = 0,
      linewidth = 0.35,
      color = "gray82"
    ) +
    ggplot2::geom_line(linewidth = 0.8, color = "#0072B2") +
    ggplot2::geom_vline(
      xintercept = current_x,
      linetype = "dashed",
      linewidth = 0.35,
      color = "gray35"
    ) +
    ggplot2::geom_hline(
      yintercept = pd1,
      linetype = "dashed",
      linewidth = 0.35,
      color = "gray35"
    ) +
    ggplot2::geom_point(
      data = current_point,
      ggplot2::aes(x = input_value, y = risk_neutral_pd),
      shape = 21,
      size = 3.6,
      stroke = 1.1,
      color = "#B77900",
      fill = "white"
    ) +
    ggplot2::coord_cartesian(ylim = y_limits) +
    ggplot2::scale_y_continuous(labels = function(x) fmt_pct(x, y_digits)) +
    ggplot2::labs(x = x_label, y = "Risk-neutral PD") +
    book_figure_theme() +
    ggplot2::theme(
      panel.grid.major.y = ggplot2::element_line(
        color = "gray90",
        linewidth = 0.25
      ),
      panel.grid.minor = ggplot2::element_blank()
    )

  if (x_as_percent) {
    p <- p + ggplot2::scale_x_continuous(labels = function(x) fmt_pct(x, 0))
  }

  p
}
