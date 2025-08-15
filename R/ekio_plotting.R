# EKIO Academy Plotting Functions
# Consistent plotting theme and SVG export functions for EKIO Academy

library(ggplot2)
library(showtext)
library(here)

# Load Google Fonts for consistent typography
font_add_google("Inter", "Inter")
font_add_google("Source Sans Pro", "Source Sans Pro") 
showtext_auto()

# EKIO Color Palette
ekio_colors <- list(
  # Primary EKIO colors
  primary = "#1abc9c",      # EKIO teal
  secondary = "#2c3e50",    # EKIO dark blue
  accent = "#3498db",       # Light blue
  
  # Supporting colors
  success = "#27ae60",
  warning = "#f39c12", 
  danger = "#e74c3c",
  info = "#9b59b6",
  
  # Grayscale
  gray_100 = "#f8f9fa",
  gray_200 = "#e9ecef", 
  gray_300 = "#dee2e6",
  gray_400 = "#ced4da",
  gray_500 = "#adb5bd",
  gray_600 = "#6c757d",
  gray_700 = "#495057",
  gray_800 = "#343a40",
  gray_900 = "#212529",
  
  # Chart-specific palettes
  sequential = c("#f0f9ff", "#0ea5e9", "#0369a1", "#1e3a8a"),
  diverging = c("#dc2626", "#f87171", "#fecaca", "#dbeafe", "#60a5fa", "#2563eb"),
  categorical = c("#1abc9c", "#3498db", "#9b59b6", "#e74c3c", "#f39c12", "#27ae60")
)

#' EKIO Base Theme
#' 
#' Base ggplot2 theme for EKIO Academy plots with transparent background
#' and consistent typography
#' 
#' @param base_size Base font size
#' @param base_family Base font family 
#' @param grid_color Color for grid lines
#' @return ggplot2 theme object
ekio_theme_base <- function(base_size = 12, base_family = "Inter", grid_color = "#f8f9fa") {
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      # Transparent backgrounds
      panel.background = element_rect(fill = "transparent", color = NA),
      plot.background = element_rect(fill = "transparent", color = NA),
      legend.background = element_rect(fill = "transparent", color = NA),
      legend.box.background = element_rect(fill = "transparent", color = NA),
      
      # Grid styling
      panel.grid.major = element_line(color = grid_color, size = 0.5),
      panel.grid.minor = element_line(color = grid_color, size = 0.25),
      
      # Text styling
      text = element_text(color = ekio_colors$gray_800),
      plot.title = element_text(
        size = rel(1.4),
        color = ekio_colors$secondary,
        face = "bold",
        margin = margin(b = 12)
      ),
      plot.subtitle = element_text(
        size = rel(1.1),
        color = ekio_colors$gray_600,
        margin = margin(b = 16)
      ),
      plot.caption = element_text(
        size = rel(0.8),
        color = ekio_colors$gray_500,
        hjust = 0,
        margin = margin(t = 12)
      ),
      
      # Axis styling
      axis.title = element_text(size = rel(1), color = ekio_colors$gray_700),
      axis.text = element_text(size = rel(0.9), color = ekio_colors$gray_600),
      axis.line = element_line(color = ekio_colors$gray_300, size = 0.5),
      axis.ticks = element_line(color = ekio_colors$gray_300, size = 0.5),
      
      # Legend styling
      legend.title = element_text(size = rel(1), color = ekio_colors$gray_700),
      legend.text = element_text(size = rel(0.9), color = ekio_colors$gray_600),
      legend.position = "bottom",
      
      # Facet styling
      strip.text = element_text(
        size = rel(1),
        color = ekio_colors$secondary,
        face = "bold"
      ),
      strip.background = element_rect(fill = "transparent", color = NA),
      
      # Margins
      plot.margin = margin(20, 20, 20, 20)
    )
}

#' EKIO Weekly Charts Theme
#' 
#' Specialized theme for Weekly Charts posts - minimal and chart-focused
ekio_theme_weekly <- function(base_size = 14) {
  ekio_theme_base(base_size = base_size) +
    theme(
      plot.title = element_text(
        size = rel(1.2),
        face = "bold",
        hjust = 0
      ),
      plot.subtitle = element_text(
        size = rel(1),
        hjust = 0
      ),
      panel.grid.minor = element_blank(),
      legend.position = "top",
      plot.margin = margin(10, 10, 10, 10)
    )
}

#' EKIO Research Insights Theme  
#' 
#' Professional theme for Research & Insights publications
ekio_theme_research <- function(base_size = 12) {
  ekio_theme_base(base_size = base_size) +
    theme(
      plot.title = element_text(
        size = rel(1.6),
        face = "bold",
        hjust = 0
      ),
      plot.subtitle = element_text(
        size = rel(1.2),
        hjust = 0,
        margin = margin(b = 20)
      ),
      legend.position = "bottom",
      legend.justification = "center",
      plot.margin = margin(25, 25, 25, 25)
    )
}

#' Save plot as SVG with transparent background
#' 
#' Exports ggplot2 object as SVG optimized for web use with transparent background
#' 
#' @param plot ggplot2 object
#' @param filename Output filename (without extension)
#' @param path Output directory path
#' @param width Width in inches
#' @param height Height in inches
#' @param dpi Resolution (dots per inch)
#' @param optimize Optimize SVG for web use
save_plot_svg <- function(plot, filename, path = "assets/images/weekly-charts", 
                         width = 10, height = 7, dpi = 300, optimize = TRUE) {
  
  # Ensure path exists
  if (!dir.exists(here(path))) {
    dir.create(here(path), recursive = TRUE)
  }
  
  # Full file path
  file_path <- here(path, paste0(filename, ".svg"))
  
  # Save with ggsave
  ggsave(
    filename = file_path,
    plot = plot,
    width = width,
    height = height,
    dpi = dpi,
    bg = "transparent",
    device = "svg"
  )
  
  # Optional: Optimize SVG (requires svgo installed)
  if (optimize && Sys.which("svgo") != "") {
    system(paste("svgo", shQuote(file_path)))
  }
  
  message("Plot saved to: ", file_path)
  return(file_path)
}

#' Save plot as PNG with transparent background
#' 
#' Exports ggplot2 object as high-quality PNG with transparency
#' 
#' @param plot ggplot2 object
#' @param filename Output filename (without extension) 
#' @param path Output directory path
#' @param width Width in inches
#' @param height Height in inches
#' @param dpi Resolution (dots per inch)
save_plot_png <- function(plot, filename, path = "assets/images/weekly-charts",
                         width = 10, height = 7, dpi = 300) {
  
  # Ensure path exists
  if (!dir.exists(here(path))) {
    dir.create(here(path), recursive = TRUE)
  }
  
  # Full file path  
  file_path <- here(path, paste0(filename, ".png"))
  
  # Save with ggsave using ragg for better quality
  ggsave(
    filename = file_path,
    plot = plot,
    width = width,
    height = height,
    dpi = dpi,
    bg = "transparent",
    device = ragg::agg_png
  )
  
  message("Plot saved to: ", file_path)
  return(file_path)
}

#' EKIO Color Scales
#' 
#' Pre-defined color scales using EKIO brand colors

# Continuous scales
scale_fill_ekio_continuous <- function(...) {
  scale_fill_gradient(low = ekio_colors$gray_100, high = ekio_colors$primary, ...)
}

scale_color_ekio_continuous <- function(...) {
  scale_color_gradient(low = ekio_colors$gray_400, high = ekio_colors$primary, ...)
}

# Discrete scales  
scale_fill_ekio_discrete <- function(...) {
  scale_fill_manual(values = ekio_colors$categorical, ...)
}

scale_color_ekio_discrete <- function(...) {
  scale_color_manual(values = ekio_colors$categorical, ...)
}

# Diverging scales
scale_fill_ekio_diverging <- function(...) {
  scale_fill_gradient2(
    low = ekio_colors$danger, 
    mid = ekio_colors$gray_100,
    high = ekio_colors$primary,
    midpoint = 0,
    ...
  )
}

#' Complete plotting workflow for Weekly Charts
#' 
#' @param data Data frame
#' @param plot_function Function that creates the ggplot
#' @param filename Output filename 
#' @param title Plot title
#' @param subtitle Plot subtitle
#' @param caption Plot caption
#' @param ... Additional arguments passed to plot_function
create_weekly_chart <- function(data, plot_function, filename, 
                               title, subtitle = NULL, caption = NULL, ...) {
  
  # Create base plot
  p <- plot_function(data, ...) +
    ekio_theme_weekly() +
    labs(
      title = title,
      subtitle = subtitle,
      caption = caption
    )
  
  # Save as both SVG and PNG
  save_plot_svg(p, filename, width = 12, height = 8)
  save_plot_png(p, filename, width = 12, height = 8)
  
  return(p)
}

#' Example usage and template
example_weekly_chart <- function() {
  # Sample data
  data <- data.frame(
    region = c("North", "Northeast", "Southeast", "South", "Center-West"),
    value = c(23.4, 31.2, 45.8, 28.9, 19.7),
    category = "Regional Data"
  )
  
  # Plot function
  plot_fn <- function(df) {
    ggplot(df, aes(x = reorder(region, value), y = value)) +
      geom_col(fill = ekio_colors$primary, alpha = 0.8) +
      geom_text(aes(label = paste0(value, "%")), 
                hjust = -0.1, color = ekio_colors$gray_700) +
      coord_flip() +
      scale_y_continuous(
        expand = expansion(mult = c(0, 0.1)),
        labels = function(x) paste0(x, "%")
      ) +
      labs(
        x = NULL,
        y = "Percentage"
      )
  }
  
  # Create chart
  create_weekly_chart(
    data = data,
    plot_function = plot_fn, 
    filename = "example-regional-data",
    title = "Regional Distribution Example",
    subtitle = "Sample data showing regional variations",
    caption = "Source: Example data for demonstration"
  )
}

# Run example if sourced directly
if (interactive()) {
  example_weekly_chart()
}