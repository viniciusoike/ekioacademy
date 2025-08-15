# EKIO Academy SVG Export Guide

Complete guide for creating publication-ready SVG charts with transparent backgrounds for the EKIO Academy website.

## Quick Start

```r
# Load the EKIO plotting functions
source("R/ekio_plotting.R")
source("R/weekly_charts_template.R")

# Create a simple weekly chart
data <- data.frame(
  region = c("Southeast", "South", "Northeast", "North", "Center-West"),
  value = c(45.8, 28.9, 31.2, 23.4, 19.7)
)

weekly_chart_template(
  data = data,
  chart_type = "bar",
  x_var = "region",
  y_var = "value", 
  title = "Regional Economic Distribution",
  subtitle = "Southeast dominates Brazil's economic activity",
  filename = "regional-economy-2024",
  category = "Economics",
  source = "IBGE Regional Accounts"
)
```

## Key Features

### 1. Transparent Backgrounds
All plots automatically use transparent backgrounds that work seamlessly with the EKIO website design.

### 2. Consistent Typography
- **Primary font**: Inter (loaded via Google Fonts)
- **Fallback font**: Source Sans Pro
- **Sizes**: Automatically scaled for readability

### 3. EKIO Brand Colors
```r
# Primary brand colors
ekio_colors$primary    # #1abc9c (teal)
ekio_colors$secondary  # #2c3e50 (dark blue)
ekio_colors$accent     # #3498db (light blue)

# Category-specific colors
"Housing" = "#e74c3c"           # Red
"Transportation" = "#1abc9c"    # Teal  
"Economics" = "#f39c12"         # Orange
"Education" = "#34495e"         # Dark gray
"Public Finance" = "#9b59b6"    # Purple
"Demographics" = "#3498db"      # Blue
```

## Export Functions

### SVG Export (Recommended)
```r
save_plot_svg(
  plot = my_plot,
  filename = "chart-name",
  path = "assets/images/weekly-charts",
  width = 10,
  height = 6.5,
  dpi = 300
)
```

### PNG Export (Fallback)
```r
save_plot_png(
  plot = my_plot, 
  filename = "chart-name",
  path = "assets/images/weekly-charts",
  width = 10,
  height = 6.5,
  dpi = 300
)
```

## Chart Types & Templates

### 1. Bar Charts
Best for: Comparisons, rankings, categorical data

```r
weekly_chart_template(
  data = your_data,
  chart_type = "bar",
  x_var = "category_column",
  y_var = "value_column",
  horizontal = TRUE,  # Default for better labels
  title = "Your Chart Title",
  filename = "your-chart-filename"
)
```

### 2. Line Charts  
Best for: Time series, trends, continuous data

```r
weekly_chart_template(
  data = time_series_data,
  chart_type = "line", 
  x_var = "date_column",
  y_var = "value_column",
  title = "Trend Over Time",
  filename = "trend-chart"
)
```

### 3. Scatter Plots
Best for: Relationships, correlations

```r
weekly_chart_template(
  data = correlation_data,
  chart_type = "scatter",
  x_var = "variable_1", 
  y_var = "variable_2",
  size_var = "population",  # Optional
  title = "Relationship Analysis",
  filename = "scatter-analysis"
)
```

### 4. Maps
Best for: Geographic data, regional patterns

```r
# Maps require additional setup with sf objects
# See specific map examples in the template
```

## Styling Guidelines

### Weekly Charts Theme
- **Clean and minimal** design
- **Large text** for mobile readability  
- **Single focal point** per chart
- **Limited color palette** (1-2 colors max)

### Research Insights Theme
- **Professional presentation** quality
- **Detailed legends** and annotations
- **Multiple data series** supported
- **Comprehensive labeling**

## File Organization

```
assets/images/
├── weekly-charts/          # Brief visualization posts
│   ├── chart-name.svg     # Primary format
│   └── chart-name.png     # Fallback
├── insights/              # Research publications  
│   ├── research-chart.svg
│   └── research-chart.png
└── tutorials/             # Educational content
    ├── tutorial-viz.svg
    └── tutorial-viz.png
```

## Quality Checklist

### Before Export
- [ ] Data is clean and validated
- [ ] Chart type matches data story
- [ ] Title is concise and clear
- [ ] Colors follow EKIO brand guidelines
- [ ] Text is readable at small sizes

### After Export  
- [ ] SVG renders correctly in browser
- [ ] Transparent background works on website
- [ ] File size is reasonable (<500KB)
- [ ] Chart works on mobile devices
- [ ] Alt text is descriptive

## Common Issues & Solutions

### Issue: Text Too Small on Mobile
**Solution**: Use `ekio_theme_weekly(base_size = 14)` or higher

### Issue: Colors Don't Match Website
**Solution**: Use predefined `ekio_colors` or category colors

### Issue: SVG Not Transparent
**Solution**: Ensure `bg = "transparent"` in ggsave call

### Issue: Large File Sizes
**Solution**: 
- Use `optimize = TRUE` in save_plot_svg()
- Install svgo: `npm install -g svgo`
- Reduce DPI if needed (but keep >= 300)

## Advanced Customization

### Custom Themes
```r
my_custom_theme <- ekio_theme_base() +
  theme(
    plot.title = element_text(color = "#custom_color"),
    panel.grid = element_blank()  # Remove grid
  )
```

### Custom Color Scales
```r
# For continuous data
+ scale_fill_gradient(low = "#f8f9fa", high = "#1abc9c")

# For categorical data  
+ scale_fill_manual(values = ekio_colors$categorical)

# For diverging data
+ scale_fill_ekio_diverging(midpoint = 0)
```

## Integration with Quarto

### In .qmd files:
```yaml
---
title: "Your Chart Post"
format:
  html:
    fig-format: svg
    fig-dpi: 300
    fig-background: transparent
---
```

### Chunk options:
```r
#| fig-format: svg
#| fig-dpi: 300
#| fig-background: transparent
#| out-width: "100%"

your_plot
```

## Performance Tips

1. **Use SVG for simple graphics** (lines, bars, scatter)
2. **Use PNG for complex graphics** (maps with many polygons)
3. **Optimize file sizes** with svgo or similar tools
4. **Test on mobile** devices for readability
5. **Provide alt text** for accessibility

## Example Workflow

```r
# 1. Load libraries and functions
source("R/ekio_plotting.R")
source("R/weekly_charts_template.R")

# 2. Prepare your data
data <- prepare_weekly_data(raw_data)

# 3. Create chart
chart <- weekly_chart_template(
  data = data,
  chart_type = "bar",
  title = "Your Insight",
  filename = "chart-slug",
  category = "Economics"
)

# 4. Review output files:
# - assets/images/weekly-charts/chart-slug.svg
# - assets/images/weekly-charts/chart-slug.png  
# - weekly-charts/charts/YYYY-MM-DD-chart-slug.qmd

# 5. Commit and deploy
```

This system ensures all EKIO Academy charts maintain visual consistency, work seamlessly with the website design, and provide excellent user experience across all devices.