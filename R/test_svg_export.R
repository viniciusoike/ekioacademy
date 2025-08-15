# Test SVG Export Workflow
# This script tests the EKIO Academy SVG export system

# Load required libraries
library(ggplot2)
library(dplyr)
library(here)

# Source EKIO functions
source(here("R/ekio_plotting.R"))

# Test 1: Simple bar chart with transparent background
test_bar_chart <- function() {
  cat("Testing bar chart with transparent background...\n")
  
  # Sample data
  data <- data.frame(
    city = c("São Paulo", "Rio de Janeiro", "Brasília", "Salvador", "Fortaleza"),
    population = c(12.4, 6.8, 3.1, 2.9, 2.7),
    stringsAsFactors = FALSE
  )
  
  # Create plot
  p <- ggplot(data, aes(x = reorder(city, population), y = population)) +
    geom_col(fill = ekio_colors$primary, alpha = 0.85, width = 0.7) +
    geom_text(aes(label = paste0(population, "M")), 
              hjust = -0.1, size = 4, color = ekio_colors$gray_700) +
    coord_flip() +
    scale_y_continuous(expand = expansion(mult = c(0, 0.12))) +
    labs(
      title = "Brazil's Largest Cities",
      subtitle = "Population in millions (2024 estimates)",
      caption = "Source: IBGE | EKIO Academy",
      x = NULL,
      y = "Population (millions)"
    ) +
    ekio_theme_weekly(base_size = 12)
  
  # Test SVG export
  tryCatch({
    svg_path <- save_plot_svg(p, "test-brazil-cities", 
                             path = "assets/images/weekly-charts",
                             width = 10, height = 6)
    cat("✅ SVG export successful:", svg_path, "\n")
    
    # Test PNG export
    png_path <- save_plot_png(p, "test-brazil-cities",
                             path = "assets/images/weekly-charts", 
                             width = 10, height = 6)
    cat("✅ PNG export successful:", png_path, "\n")
    
    return(TRUE)
  }, error = function(e) {
    cat("❌ Export failed:", e$message, "\n")
    return(FALSE)
  })
}

# Test 2: Line chart with time series data
test_line_chart <- function() {
  cat("\nTesting line chart with time series data...\n")
  
  # Sample time series data
  data <- data.frame(
    date = seq(as.Date("2020-01-01"), as.Date("2024-12-01"), by = "month"),
    inflation = c(4.31, 4.01, 3.30, 3.07, 2.40, 2.13, 2.44, 2.95, 3.14, 4.20, 4.52, 4.31,
                  5.20, 5.99, 6.10, 8.35, 10.06, 10.74, 11.30, 10.07, 11.89, 12.13, 11.30, 10.06,
                  9.15, 8.50, 7.17, 6.47, 5.77, 5.22, 4.62, 4.24, 4.76, 5.19, 4.68, 4.62,
                  4.50, 4.18, 4.71, 5.00, 4.77, 4.23, 3.85, 3.16, 2.95, 3.38, 3.69, 4.50,
                  4.62, 4.80, 4.71, 4.23, 3.92, rep(4.0, 7))
  )
  
  # Create plot
  p <- ggplot(data, aes(x = date, y = inflation)) +
    geom_line(color = ekio_colors$primary, size = 1.1) +
    geom_point(color = ekio_colors$primary, size = 1.5, alpha = 0.7) +
    scale_x_date(date_labels = "%Y", date_breaks = "1 year") +
    scale_y_continuous(labels = function(x) paste0(x, "%")) +
    labs(
      title = "Brazil's Inflation Rate",
      subtitle = "IPCA monthly inflation from 2020-2024", 
      caption = "Source: IBGE | EKIO Academy",
      x = "Year",
      y = "Inflation Rate (%)"
    ) +
    ekio_theme_weekly(base_size = 12)
  
  # Test export
  tryCatch({
    svg_path <- save_plot_svg(p, "test-brazil-inflation",
                             path = "assets/images/weekly-charts",
                             width = 10, height = 6)
    cat("✅ Line chart SVG export successful:", svg_path, "\n")
    return(TRUE)
  }, error = function(e) {
    cat("❌ Line chart export failed:", e$message, "\n")
    return(FALSE)
  })
}

# Test 3: Research theme with more complex styling
test_research_theme <- function() {
  cat("\nTesting research theme with complex styling...\n")
  
  # Sample data with multiple categories
  data <- data.frame(
    region = rep(c("North", "Northeast", "Southeast", "South", "Center-West"), 2),
    metric = rep(c("GDP per capita", "Education Index"), each = 5),
    value = c(18500, 16200, 35400, 28900, 31200,  # GDP per capita
              0.65, 0.68, 0.78, 0.76, 0.72)        # Education index (0-1)
  )
  
  # Normalize values for comparison
  data <- data %>%
    group_by(metric) %>%
    mutate(value_norm = scales::rescale(value, to = c(0, 100))) %>%
    ungroup()
  
  # Create plot
  p <- ggplot(data, aes(x = region, y = value_norm, fill = metric)) +
    geom_col(position = "dodge", alpha = 0.8, width = 0.7) +
    scale_fill_manual(values = c(ekio_colors$primary, ekio_colors$accent)) +
    scale_y_continuous(labels = function(x) paste0(x, "%")) +
    labs(
      title = "Regional Development Indicators",
      subtitle = "Comparing economic and educational performance across Brazilian regions",
      caption = "Source: IBGE, UNDP | Values normalized to 0-100 scale",
      x = "Region",
      y = "Normalized Score (%)",
      fill = "Indicator"
    ) +
    ekio_theme_research(base_size = 11) +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      legend.position = "top"
    )
  
  # Test export
  tryCatch({
    svg_path <- save_plot_svg(p, "test-regional-development",
                             path = "assets/images/insights", 
                             width = 11, height = 7)
    cat("✅ Research theme SVG export successful:", svg_path, "\n")
    return(TRUE)
  }, error = function(e) {
    cat("❌ Research theme export failed:", e$message, "\n") 
    return(FALSE)
  })
}

# Test 4: Check file properties and transparency
test_svg_properties <- function() {
  cat("\nTesting SVG properties and transparency...\n")
  
  svg_file <- here("assets/images/weekly-charts/test-brazil-cities.svg")
  
  if (file.exists(svg_file)) {
    # Read SVG content
    svg_content <- readLines(svg_file)
    
    # Check for transparency indicators
    has_transparent_bg <- any(grepl('fill="none"|fill="transparent"', svg_content))
    has_ekio_colors <- any(grepl("#1abc9c|#2c3e50", svg_content))
    
    cat("📊 SVG Properties Check:\n")
    cat("   File exists: ✅\n")
    cat("   File size:", file.size(svg_file), "bytes\n")
    cat("   Transparent background:", ifelse(has_transparent_bg, "✅", "❌"), "\n") 
    cat("   EKIO brand colors:", ifelse(has_ekio_colors, "✅", "❌"), "\n")
    
    return(has_transparent_bg && has_ekio_colors)
  } else {
    cat("❌ SVG file not found\n")
    return(FALSE)
  }
}

# Run all tests
run_all_tests <- function() {
  cat("🧪 EKIO Academy SVG Export Tests\n")
  cat("================================\n")
  
  tests_passed <- 0
  
  if (test_bar_chart()) tests_passed <- tests_passed + 1
  if (test_line_chart()) tests_passed <- tests_passed + 1  
  if (test_research_theme()) tests_passed <- tests_passed + 1
  if (test_svg_properties()) tests_passed <- tests_passed + 1
  
  cat("\n📈 Test Results:\n")
  cat("   Tests passed:", tests_passed, "/ 4\n")
  
  if (tests_passed == 4) {
    cat("🎉 All tests passed! SVG export system is ready.\n")
    cat("\n📁 Generated test files:\n")
    cat("   - assets/images/weekly-charts/test-brazil-cities.svg\n")
    cat("   - assets/images/weekly-charts/test-brazil-cities.png\n") 
    cat("   - assets/images/weekly-charts/test-brazil-inflation.svg\n")
    cat("   - assets/images/insights/test-regional-development.svg\n")
  } else {
    cat("⚠️  Some tests failed. Check the error messages above.\n")
  }
  
  return(tests_passed == 4)
}

# Run tests if sourced directly
if (interactive()) {
  run_all_tests()
} else {
  cat("Load this script and run: run_all_tests()\n")
}