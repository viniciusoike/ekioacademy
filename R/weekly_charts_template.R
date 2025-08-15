# Weekly Charts Template
# Template and examples for creating EKIO Academy Weekly Charts

source("R/ekio_plotting.R")
library(dplyr)
library(lubridate)

#' Weekly Chart Template
#' 
#' Creates a standardized weekly chart following EKIO Academy format
#' 
#' @param data Data frame for plotting
#' @param chart_type Type of chart ("bar", "line", "map", "scatter")
#' @param title Main chart title (keep concise)
#' @param subtitle Optional subtitle with key insight
#' @param filename Output filename (without extension)
#' @param date Publication date (YYYY-MM-DD format)
#' @param category Chart category for color coding
#' @param source Data source attribution
#' @param ... Additional arguments for specific chart types
weekly_chart_template <- function(data, chart_type, title, subtitle = NULL, 
                                 filename, date = Sys.Date(), 
                                 category = "Economics", source = "", ...) {
  
  # Category color mapping
  category_colors <- list(
    "Housing" = "#e74c3c",
    "Transportation" = "#1abc9c", 
    "Economics" = "#f39c12",
    "Education" = "#34495e",
    "Public Finance" = "#9b59b6",
    "Demographics" = "#3498db",
    "Urban Development" = "#27ae60"
  )
  
  primary_color <- category_colors[[category]] %||% ekio_colors$primary
  
  # Create base plot based on type
  p <- switch(chart_type,
    "bar" = create_bar_chart(data, primary_color, ...),
    "line" = create_line_chart(data, primary_color, ...),
    "scatter" = create_scatter_chart(data, primary_color, ...),
    "map" = create_map_chart(data, primary_color, ...),
    stop("Unsupported chart type")
  )
  
  # Apply theme and labels
  p <- p +
    ekio_theme_weekly(base_size = 13) +
    labs(
      title = title,
      subtitle = subtitle,
      caption = paste0("Source: ", source, " | EKIO Academy")
    ) +
    theme(
      plot.title = element_text(size = 18, face = "bold", margin = margin(b = 8)),
      plot.subtitle = element_text(size = 14, color = ekio_colors$gray_600, margin = margin(b = 16))
    )
  
  # Save with consistent dimensions
  save_plot_svg(p, filename, path = "assets/images/weekly-charts", 
                width = 10, height = 6.5, dpi = 300)
  save_plot_png(p, filename, path = "assets/images/weekly-charts", 
                width = 10, height = 6.5, dpi = 300)
  
  # Generate markdown template
  generate_weekly_post(title, subtitle, filename, date, category, source, ...)
  
  return(p)
}

#' Create bar chart for weekly charts
create_bar_chart <- function(data, color, x_var, y_var, horizontal = TRUE, ...) {
  p <- ggplot(data, aes(x = !!sym(x_var), y = !!sym(y_var))) +
    geom_col(fill = color, alpha = 0.85, width = 0.7) +
    geom_text(aes(label = scales::number(!!sym(y_var), accuracy = 0.1)), 
              hjust = ifelse(horizontal, -0.1, 0.5),
              vjust = ifelse(horizontal, 0.5, -0.3),
              size = 3.5, color = ekio_colors$gray_700)
  
  if (horizontal) {
    p <- p + 
      coord_flip() +
      scale_x_discrete(limits = rev) +
      scale_y_continuous(expand = expansion(mult = c(0, 0.15)))
  } else {
    p <- p + scale_y_continuous(expand = expansion(mult = c(0, 0.1)))
  }
  
  return(p)
}

#' Create line chart for weekly charts
create_line_chart <- function(data, color, x_var, y_var, ...) {
  ggplot(data, aes(x = !!sym(x_var), y = !!sym(y_var))) +
    geom_line(color = color, size = 1.2, alpha = 0.9) +
    geom_point(color = color, size = 2.5, alpha = 0.8) +
    scale_x_date(date_labels = "%Y", date_breaks = "1 year") +
    scale_y_continuous(labels = scales::comma_format())
}

#' Create scatter plot for weekly charts  
create_scatter_chart <- function(data, color, x_var, y_var, size_var = NULL, ...) {
  aes_mapping <- aes(x = !!sym(x_var), y = !!sym(y_var))
  
  if (!is.null(size_var)) {
    aes_mapping$size <- sym(size_var)
  }
  
  p <- ggplot(data, aes_mapping) +
    geom_point(color = color, alpha = 0.7) +
    scale_x_continuous(labels = scales::comma_format()) +
    scale_y_continuous(labels = scales::comma_format())
  
  if (!is.null(size_var)) {
    p <- p + scale_size_continuous(range = c(1, 8), guide = "none")
  }
  
  return(p)
}

#' Generate markdown post template
generate_weekly_post <- function(title, subtitle, filename, date, category, source, 
                                insight_1 = "", insight_2 = "", insight_3 = "", 
                                next_week = "", ...) {
  
  # Create post filename
  date_str <- format(as.Date(date), "%Y-%m-%d")
  slug <- gsub("[^a-zA-Z0-9]", "-", tolower(title))
  slug <- gsub("-+", "-", slug)
  slug <- gsub("^-|-$", "", slug)
  
  post_filename <- paste0("weekly-charts/charts/", date_str, "-", slug, ".qmd")
  
  # Generate markdown content
  content <- paste0('---
title: "', title, '"
description: "', subtitle, '"
date: "', date, '"
image: "../../assets/images/weekly-charts/', filename, '.png"
categories: ["', tolower(gsub(" ", "-", category)), '"]
format:
  html:
    page-layout: article
---

![', title, '](../../assets/images/weekly-charts/', filename, '.png){fig-alt="', title, ' - ', subtitle, '"}

## Key Insights

', if(insight_1 != "") paste0('**', insight_1, '**\n\n') else '', 
if(insight_2 != "") paste0('**', insight_2, '**\n\n') else '',
if(insight_3 != "") paste0('**', insight_3, '**\n\n') else '',

'## What This Means

[Add 2-3 sentences explaining the broader implications and why this matters for policy, business, or society]

', if(next_week != "") paste0('## Next Week\n\n', next_week, '\n\n') else '', 

'---

*Data: ', source, '. Analysis: EKIO Academy research team.*')

  # Write file
  writeLines(content, post_filename)
  message("Generated post template: ", post_filename)
  
  return(post_filename)
}

#' Example: Brazil Housing Price Chart
example_housing_prices <- function() {
  # Sample data
  housing_data <- data.frame(
    city = c("São Paulo", "Rio de Janeiro", "Brasília", "Belo Horizonte", "Salvador"),
    price_change = c(142, 128, 115, 98, 87),
    stringsAsFactors = FALSE
  )
  
  weekly_chart_template(
    data = housing_data,
    chart_type = "bar",
    x_var = "city", 
    y_var = "price_change",
    title = "Brazil's Housing Price Surge",
    subtitle = "Price increases since 2019 vary dramatically across major cities",
    filename = "brazil-housing-prices-2024",
    category = "Housing",
    source = "FipeZap Housing Price Index",
    insight_1 = "142% - Price increase in São Paulo since 2019",
    insight_2 = "85pp - Gap between highest and lowest price growth",
    insight_3 = "5 cities - Show over 80% price appreciation",
    next_week = "Next week we'll examine which cities are bucking this trend and policy responses."
  )
}

#' Example: Regional Economic Data
example_regional_economy <- function() {
  # Sample time series data
  gdp_data <- data.frame(
    date = seq(as.Date("2019-01-01"), as.Date("2024-01-01"), by = "quarter"),
    gdp_growth = c(1.2, 0.5, -3.8, -1.1, 2.4, 4.5, 1.8, 0.9, 1.6, 2.1, 1.4, 0.8, 
                   1.9, 2.3, 1.7, 1.1, 0.6, 1.4, 2.2, 1.8, 0.9)
  )
  
  weekly_chart_template(
    data = gdp_data,
    chart_type = "line",
    x_var = "date",
    y_var = "gdp_growth", 
    title = "Brazil's Economic Recovery Momentum",
    subtitle = "GDP growth shows steady but modest recovery since 2022",
    filename = "brazil-gdp-recovery-2024",
    category = "Economics",
    source = "IBGE National Accounts",
    insight_1 = "2.3% - Peak quarterly growth in 2023",
    insight_2 = "6 quarters - Of positive growth since recovery began", 
    insight_3 = "1.5% - Average growth rate in recovery period",
    next_week = "We'll analyze which sectors are driving Brazil's economic recovery."
  )
}

# Additional helper functions
#' Convert data to weekly chart format
prepare_weekly_data <- function(raw_data, ...) {
  # Add data preparation utilities
  raw_data %>%
    arrange(desc(value)) %>%
    slice_head(n = 10) %>%
    mutate(
      label = scales::number(value, accuracy = 0.1),
      category = case_when(
        value > quantile(value, 0.75) ~ "High",
        value > quantile(value, 0.25) ~ "Medium", 
        TRUE ~ "Low"
      )
    )
}

#' Validate weekly chart data
validate_chart_data <- function(data, required_cols) {
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }
  return(TRUE)
}

# Print usage examples
if (interactive()) {
  cat("Weekly Charts Template loaded!\n\n")
  cat("Usage examples:\n")
  cat("- example_housing_prices()\n") 
  cat("- example_regional_economy()\n")
  cat("\nFor custom charts, use weekly_chart_template() function\n")
}