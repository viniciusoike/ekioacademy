#' Export ggplot2 charts optimized for McKinsey-style web layouts using EKIO theme system
#'
#' @param plot ggplot2 object to export
#' @param filename Base filename without extension (e.g., "week-12-gdp")
#' @param type Export type: "all", "small_card", "medium_card", "featured", "chart", or "web_optimized"
#' @param output_dir Base directory for exports (default: "images")
#' @param week Week identifier for automatic naming (optional, e.g., "week-12")
#' @param ekio_style EKIO theme style: "modern_premium", "academic_authority", "sophisticated_unique", etc.
#' @param apply_ekio_theme Apply EKIO theme automatically (default: TRUE)
#' @param add_watermark Add EKIO watermark to exports (default: FALSE)
#' @param watermark_position Position for watermark: "bottom_right", "bottom_left", "top_right"
#'
#' @return Invisible list of exported file paths
#' @export
#'
#' @examples
#' # Basic usage with EKIO theme
#' p <- ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
#'      geom_point() +
#'      scale_color_ekio_categorical()
#' export_plot(p, "my-chart", type = "all")
#'
#' # Export specific type with academic theme
#' export_plot(p, "gdp-analysis", type = "featured", ekio_style = "academic_authority")
#'
#' # With week identifier and watermark
#' export_plot(p, type = "all", week = "week-12", add_watermark = TRUE)

export_plot <- function(
  plot,
  filename = NULL,
  type = "all",
  output_dir = "images",
  week = NULL,
  ekio_style = "modern_premium",
  apply_ekio_theme = TRUE,
  add_watermark = FALSE,
  watermark_position = "bottom_right"
) {
  # Load required libraries
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 package is required")
  }

  # Validate inputs
  if (!inherits(plot, "ggplot")) {
    stop("plot must be a ggplot object")
  }

  valid_types <- c(
    "all",
    "small_card",
    "medium_card",
    "featured",
    "chart",
    "web_optimized"
  )
  if (!type %in% valid_types) {
    stop("type must be one of: ", paste(valid_types, collapse = ", "))
  }

  valid_styles <- c(
    "modern_premium",
    "academic_authority",
    "sophisticated_unique",
    "institutional_oxford",
    "professional_deep",
    "premium_steel"
  )
  if (!ekio_style %in% valid_styles) {
    stop("ekio_style must be one of: ", paste(valid_styles, collapse = ", "))
  }

  # Generate filename if not provided
  if (is.null(filename)) {
    if (!is.null(week)) {
      filename <- paste0(week, "-chart")
    } else {
      filename <- paste0("chart-", format(Sys.time(), "%Y%m%d-%H%M%S"))
    }
  }

  # EKIO theme configurations
  ekio_themes <- list(
    modern_premium = list(
      colors = c(
        "#f4f7fb",
        "#e3ecf5",
        "#d2e1ef",
        "#a0bfdb",
        "#6d9dc7",
        "#2C6BB3",
        "#265c9a",
        "#204d81",
        "#1a3e68"
      ),
      primary = "#2C6BB3",
      font = "Avenir",
      categorical = c("#2C6BB3", "#1abc9c", "#f39c12", "#e74c3c", "#9b59b6")
    ),
    academic_authority = list(
      colors = c(
        "#f2f4f7",
        "#e0e6ed",
        "#ced8e3",
        "#9fb4cc",
        "#7090b5",
        "#0F3A65",
        "#0d3256",
        "#0b2a47",
        "#092238"
      ),
      primary = "#0F3A65",
      font = "Lato",
      categorical = c("#0F3A65", "#7090b5", "#34495e", "#95a5a6", "#27ae60")
    ),
    sophisticated_unique = list(
      colors = c(
        "#f6fafa",
        "#e8f4f4",
        "#d9efef",
        "#b8dee0",
        "#96ced1",
        "#5F9EA0",
        "#528a8c",
        "#467678",
        "#396264"
      ),
      primary = "#5F9EA0",
      font = "Avenir",
      categorical = c("#5F9EA0", "#2c3e50", "#95a5a6", "#34495e", "#7f8c8d")
    ),
    institutional_oxford = list(
      colors = c(
        "#f3f6fa",
        "#e2eaf4",
        "#d1deed",
        "#a8c5d4",
        "#7fa6c4",
        "#1E5F9F",
        "#1a5289",
        "#164573",
        "#12385d"
      ),
      primary = "#1E5F9F",
      font = "Helvetica Neue",
      categorical = c("#1E5F9F", "#34495e", "#95a5a6", "#2c3e50", "#7f8c8d")
    ),
    professional_deep = list(
      colors = c(
        "#f2f4f7",
        "#e0e6ed",
        "#ced8e3",
        "#9fb4cc",
        "#7090b5",
        "#0F3A65",
        "#0d3256",
        "#0b2a47",
        "#092238"
      ),
      primary = "#0F3A65",
      font = "Helvetica Neue",
      categorical = c("#0F3A65", "#2c3e50", "#95a5a6", "#34495e", "#7f8c8d")
    ),
    premium_steel = list(
      colors = c(
        "#f4f7fa",
        "#e1eaf2",
        "#cddde9",
        "#a5c4d4",
        "#7da9c4",
        "#4682B4",
        "#3a6fa0",
        "#2f5c8c",
        "#244978"
      ),
      primary = "#4682B4",
      font = "Avenir",
      categorical = c("#4682B4", "#2c3e50", "#95a5a6", "#34495e", "#7f8c8d")
    )
  )

  theme_config <- ekio_themes[[ekio_style]]

  # Apply EKIO theme if requested
  if (apply_ekio_theme) {
    # Create web-optimized EKIO theme function
    theme_ekio_web <- function(base_size = 14) {
      ggplot2::theme_minimal(
        base_size = base_size,
        base_family = theme_config$font
      ) +
        ggplot2::theme(
          # Text elements
          text = ggplot2::element_text(
            family = theme_config$font,
            color = "#2c3e50"
          ),
          plot.title = ggplot2::element_text(
            size = base_size * 1.4,
            color = "#000000",
            margin = ggplot2::margin(b = 20),
            hjust = 0
          ),
          plot.subtitle = ggplot2::element_text(
            size = base_size * 1.1,
            color = "#7f8c8d",
            margin = ggplot2::margin(b = 25),
            hjust = 0
          ),
          plot.caption = ggplot2::element_text(
            size = base_size * 0.8,
            color = "#7f8c8d",
            hjust = 0,
            margin = ggplot2::margin(t = 15)
          ),

          # Axis elements
          axis.title = ggplot2::element_text(
            size = base_size * 0.9,
            color = "#7f8c8d"
          ),
          axis.text = ggplot2::element_text(
            size = base_size * 0.85,
            color = "#2c3e50"
          ),

          # Grid elements
          panel.grid.major = ggplot2::element_line(
            color = theme_config$colors[2],
            linewidth = 0.5
          ),
          panel.grid.minor = ggplot2::element_blank(),
          panel.background = ggplot2::element_rect(fill = "white", color = NA),
          plot.background = ggplot2::element_rect(fill = "white", color = NA),

          # Legend
          legend.position = "bottom",
          legend.title = ggplot2::element_text(
            size = base_size * 0.9,
            color = "#2c3e50"
          ),
          legend.text = ggplot2::element_text(
            size = base_size * 0.85,
            color = "#2c3e50"
          ),
          legend.background = ggplot2::element_rect(fill = "white", color = NA),
          legend.margin = ggplot2::margin(t = 15),

          # Plot margins
          plot.margin = ggplot2::margin(25, 25, 25, 25),

          # Strip text for facets
          strip.text = ggplot2::element_text(
            size = base_size * 0.9,
            color = theme_config$primary,
            face = "bold"
          ),
          strip.background = ggplot2::element_rect(
            fill = theme_config$colors[1],
            color = NA
          )
        )
    }

    plot <- plot + theme_ekio_web()
  }

  # Add EKIO watermark if requested
  if (add_watermark) {
    positions <- list(
      "bottom_right" = c(x = Inf, y = -Inf, hjust = 1.1, vjust = -0.5),
      "bottom_left" = c(x = -Inf, y = -Inf, hjust = -0.1, vjust = -0.5),
      "top_right" = c(x = Inf, y = Inf, hjust = 1.1, vjust = 1.5)
    )

    pos <- positions[[watermark_position]]

    plot <- plot +
      ggplot2::annotate(
        "text",
        x = pos[1],
        y = pos[2],
        label = "EKIO",
        hjust = pos[3],
        vjust = pos[4],
        size = 3,
        alpha = 0.6,
        color = theme_config$primary,
        family = theme_config$font,
        fontface = "bold"
      )
  }

  # Create directory structure
  create_dirs <- function(base_dir) {
    dirs <- file.path(base_dir, c("thumbnails", "featured", "charts"))
    for (dir in dirs) {
      if (!dir.exists(dir)) {
        dir.create(dir, recursive = TRUE)
        message("✓ Created directory: ", dir)
      }
    }
  }

  create_dirs(output_dir)

  # Export specifications optimized for web
  export_specs <- list(
    small_card = list(
      path = file.path(
        output_dir,
        "thumbnails",
        paste0(filename, "-thumb.png")
      ),
      width = 6,
      height = 4.5,
      dpi = 150,
      description = "Small card thumbnail (6×4.5 inches, 150 DPI)"
    ),
    medium_card = list(
      path = file.path(
        output_dir,
        "thumbnails",
        paste0(filename, "-medium.png")
      ),
      width = 8,
      height = 5,
      dpi = 150,
      description = "Medium card thumbnail (8×5 inches, 150 DPI)"
    ),
    featured = list(
      path = file.path(
        output_dir,
        "featured",
        paste0(filename, "-featured.png")
      ),
      width = 10,
      height = 6,
      dpi = 150,
      description = "Featured card image (10×6 inches, 150 DPI)"
    ),
    chart = list(
      path = file.path(output_dir, "charts", paste0(filename, "-chart.png")),
      width = 12,
      height = 8,
      dpi = 300,
      description = "High-quality chart (12×8 inches, 300 DPI)"
    ),
    web_optimized = list(
      path = file.path(output_dir, "charts", paste0(filename, "-web.png")),
      width = 10,
      height = 6.67,
      dpi = 200,
      description = "Web-optimized chart (10×6.67 inches, 200 DPI)"
    )
  )

  # Determine which exports to create
  if (type == "all") {
    types_to_export <- names(export_specs)
  } else {
    types_to_export <- type
  }

  # Export files
  exported_files <- list()

  for (export_type in types_to_export) {
    spec <- export_specs[[export_type]]

    tryCatch(
      {
        ggplot2::ggsave(
          filename = spec$path,
          plot = plot,
          width = spec$width,
          height = spec$height,
          dpi = spec$dpi,
          bg = "white",
          device = "png"
        )

        file_size <- file.size(spec$path)
        file_size_kb <- round(file_size / 1024, 1)

        message("✓ Exported ", export_type, ": ", spec$path)
        message("  ", spec$description, " (", file_size_kb, " KB)")

        exported_files[[export_type]] <- spec$path
      },
      error = function(e) {
        warning("Failed to export ", export_type, ": ", e$message)
      }
    )
  }

  # Print usage examples
  if (length(exported_files) > 0) {
    message("\n📋 HTML Usage Examples:")

    if ("small_card" %in% names(exported_files)) {
      rel_path <- file.path("images/thumbnails", paste0(filename, "-thumb.png"))
      message(
        "Small card: <div class=\"card-visual\" style=\"background-image: url('",
        rel_path,
        "');\"></div>"
      )
    }

    if ("medium_card" %in% names(exported_files)) {
      rel_path <- file.path(
        "images/thumbnails",
        paste0(filename, "-medium.png")
      )
      message(
        "Medium card: <div class=\"card-visual\" style=\"background-image: url('",
        rel_path,
        "');\"></div>"
      )
    }

    if ("featured" %in% names(exported_files)) {
      rel_path <- file.path(
        "images/featured",
        paste0(filename, "-featured.png")
      )
      message(
        "Featured card: <div class=\"image-section\" style=\"background-image: url('",
        rel_path,
        "');\"></div>"
      )
    }

    message("\n🎨 EKIO Theme: ", ekio_style)
    message("🔤 Font: ", theme_config$font)
    message("🎯 Primary Color: ", theme_config$primary)
  }

  invisible(exported_files)
}

# Helper functions for EKIO color system
# ekio_colors <- function(style = "modern_premium") {
#   ekio_themes <- list(
#     modern_premium = list(
#       categorical = c(
#         "#2C6BB3",
#         "#1abc9c",
#         "#f39c12",
#         "#e74c3c",
#         "#9b59b6",
#         "#95a5a6",
#         "#34495e"
#       ),
#       primary = "#2C6BB3"
#     ),
#     academic_authority = list(
#       categorical = c("#0F3A65", "#7090b5", "#34495e", "#95a5a6", "#27ae60"),
#       primary = "#0F3A65"
#     ),
#     sophisticated_unique = list(
#       categorical = c("#5F9EA0", "#2c3e50", "#95a5a6", "#34495e", "#7f8c8d"),
#       primary = "#5F9EA0"
#     ),
#     institutional_oxford = list(
#       categorical = c("#1E5F9F", "#34495e", "#95a5a6", "#2c3e50", "#7f8c8d"),
#       primary = "#1E5F9F"
#     ),
#     professional_deep = list(
#       categorical = c("#0F3A65", "#2c3e50", "#95a5a6", "#34495e", "#7f8c8d"),
#       primary = "#0F3A65"
#     ),
#     premium_steel = list(
#       categorical = c("#4682B4", "#2c3e50", "#95a5a6", "#34495e", "#7f8c8d"),
#       primary = "#4682B4"
#     )
#   )

#   return(ekio_themes[[style]])
# }

# Helper functions for EKIO scales (compatible with your existing system)
scale_color_ekio_categorical <- function(style = "modern_premium", ...) {
  colors <- ekio_colors(style)$categorical
  ggplot2::scale_color_manual(values = colors, ...)
}

scale_fill_ekio_categorical <- function(style = "modern_premium", ...) {
  colors <- ekio_colors(style)$categorical
  ggplot2::scale_fill_manual(values = colors, ...)
}

# Example usage and testing
if (FALSE) {
  # Set to TRUE to run examples

  library(ggplot2)

  # Create sample plot with EKIO styling
  sample_plot <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
    geom_point(size = 3, alpha = 0.8) +
    geom_smooth(method = "lm", se = FALSE, linewidth = 1.2) +
    scale_color_ekio_categorical(style = "modern_premium") +
    labs(
      title = "Fuel Efficiency Analysis",
      subtitle = "Vehicle weight vs fuel economy across engine types",
      x = "Weight (1000 lbs)",
      y = "Miles per Gallon",
      color = "Cylinders",
      caption = "Data: Motor Trend Magazine (1974) | EKIO Analytics"
    )

  # Export all sizes with EKIO modern premium theme
  export_plot(
    sample_plot,
    "fuel-efficiency",
    type = "all",
    ekio_style = "modern_premium",
    add_watermark = TRUE
  )

  # Export with academic authority theme
  export_plot(
    sample_plot,
    "fuel-efficiency-academic",
    type = "featured",
    ekio_style = "academic_authority"
  )

  # Export with week identifier
  export_plot(
    sample_plot,
    type = "all",
    week = "week-12",
    ekio_style = "sophisticated_unique"
  )

  # Create a Brazilian economic plot
  brazil_plot <- ggplot(economics, aes(x = date, y = unemploy / 1000)) +
    geom_line(linewidth = 1.2, color = ekio_colors("modern_premium")$primary) +
    geom_area(alpha = 0.3, fill = ekio_colors("modern_premium")$primary) +
    labs(
      title = "Brazilian Unemployment Trends",
      subtitle = "Historical unemployment rates across metropolitan regions",
      x = "Year",
      y = "Unemployment Rate (%)",
      caption = "Source: IBGE Labor Force Survey | EKIO Analytics"
    )

  export_plot(
    brazil_plot,
    "brazil-unemployment",
    type = "all",
    ekio_style = "modern_premium",
    add_watermark = TRUE
  )
}
