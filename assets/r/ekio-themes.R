# EKIO Academy Complete Theme System for R/ggplot2
# Professional data visualization themes for Brazilian urban economics education
# Based on the 6-theme system from EKIO brand guidelines

if (!require(ggplot2)) {
  stop("ggplot2 package is required for EKIO themes")
}

if (!require(scales)) {
  stop("scales package is required for EKIO themes")
}

# ===================================================================
# EKIO COLOR SYSTEMS
# ===================================================================

# Academy Primary (Educational Theme - Main)
ekio_academy_colors <- list(
  primary = "#1abc9c",
  secondary = "#16a085",
  tertiary = "#138d75",
  sequential = c(
    "#e8f8f5",
    "#a3e4d7",
    "#1abc9c",
    "#16a085",
    "#138d75",
    "#0e6b5c",
    "#0a4f44"
  ),
  categorical = c("#1abc9c", "#f39c12", "#e74c3c", "#9b59b6", "#3498db")
)

# Modern Premium (Professional/Business)
ekio_modern_premium_colors <- list(
  primary = "#2C6BB3",
  secondary = "#3c7bc3",
  tertiary = "#1E5F9F",
  sequential = c(
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
  categorical = c("#2C6BB3", "#1abc9c", "#f39c12", "#e74c3c", "#9b59b6")
)

# Academic Authority (Research/Government)
ekio_academic_colors <- list(
  primary = "#0F3A65",
  secondary = "#1f4a75",
  tertiary = "#092238",
  sequential = c("#f2f4f7", "#ced8e3", "#7090b5", "#0F3A65", "#092238"),
  categorical = c("#0F3A65", "#2C6BB3", "#5F9EA0", "#4682B4", "#1E5F9F")
)

# Sophisticated Unique (International Clients)
ekio_sophisticated_colors <- list(
  primary = "#5F9EA0",
  secondary = "#6faeb0",
  tertiary = "#2c4e50",
  sequential = c("#f6fafa", "#d9efef", "#96ced1", "#5F9EA0", "#2c4e50"),
  categorical = c("#5F9EA0", "#1abc9c", "#2C6BB3", "#f39c12", "#e74c3c")
)

# Institutional Oxford (Banking/Financial)
ekio_institutional_colors <- list(
  primary = "#1E5F9F",
  secondary = "#2e6faf",
  tertiary = "#0e2b47",
  sequential = c("#f3f6fa", "#d1deee", "#659cc4", "#1E5F9F", "#0e2b47"),
  categorical = c("#1E5F9F", "#2C6BB3", "#5F9EA0", "#4682B4", "#0F3A65")
)

# Premium Steel (Executive/Investment)
ekio_premium_steel_colors <- list(
  primary = "#4682B4",
  secondary = "#5692c4",
  tertiary = "#193664",
  sequential = c("#f4f7fa", "#cddde9", "#7da9c4", "#4682B4", "#193664"),
  categorical = c("#4682B4", "#2C6BB3", "#1abc9c", "#5F9EA0", "#1E5F9F")
)

# ===================================================================
# UNIVERSAL THEME FUNCTION
# ===================================================================

#' EKIO Academy Universal Theme Function
#'
#' Creates ggplot2 themes optimized for Brazilian urban economics education
#'
#' @param style Character string specifying theme style. Options:
#'   - "academy_primary" (default): Educational teal theme
#'   - "modern_premium": Professional sapphire blue
#'   - "academic_authority": Research-focused deep blue
#'   - "sophisticated_unique": International cadet blue
#'   - "institutional_oxford": Banking oxford blue
#'   - "premium_steel": Executive steel blue
#' @param base_size Base font size in points (default: 12)
#' @param base_family Base font family (default: "Avenir")
#'
#' @return A ggplot2 theme object
#'
#' @examples
#' library(ggplot2)
#'
#' # Basic usage with academy theme
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_ekio()
#'
#' # Professional presentation theme
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_ekio("modern_premium")
#'
#' # Government/academic reports
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_ekio("academic_authority")

theme_ekio <- function(
  style = "academy_primary",
  base_size = 12,
  base_family = "Avenir"
) {
  # Theme color configurations
  theme_configs <- list(
    academy_primary = list(
      colors = ekio_academy_colors,
      font = "Avenir"
    ),
    modern_premium = list(
      colors = ekio_modern_premium_colors,
      font = "Avenir"
    ),
    academic_authority = list(
      colors = ekio_academic_colors,
      font = "Lato"
    ),
    sophisticated_unique = list(
      colors = ekio_sophisticated_colors,
      font = "Avenir"
    ),
    institutional_oxford = list(
      colors = ekio_institutional_colors,
      font = "Helvetica Neue"
    ),
    premium_steel = list(
      colors = ekio_premium_steel_colors,
      font = "Avenir"
    )
  )

  # Get theme configuration or default to academy_primary
  config <- theme_configs[[style]]
  if (is.null(config)) {
    warning(paste("Theme", style, "not found. Using academy_primary."))
    config <- theme_configs$academy_primary
  }

  # Override font family if specified
  if (base_family != "Avenir") {
    config$font <- base_family
  }

  # Build theme
  theme_minimal(base_size = base_size, base_family = config$font) +
    theme(
      # Text elements
      text = element_text(family = config$font, color = "#2c3e50"),

      # Plot titles and labels
      plot.title = element_text(
        size = base_size * 1.6,
        color = config$colors$primary,
        face = "plain",
        margin = margin(b = 20),
        hjust = 0
      ),

      plot.subtitle = element_text(
        size = base_size * 1.1,
        color = "#7f8c8d",
        face = "plain",
        margin = margin(b = 25),
        hjust = 0
      ),

      plot.caption = element_text(
        size = base_size * 0.8,
        color = "#7f8c8d",
        face = "plain",
        hjust = 0,
        margin = margin(t = 15)
      ),

      # Axis elements
      axis.title = element_text(
        size = base_size * 0.9,
        color = "#7f8c8d",
        face = "plain"
      ),

      axis.text = element_text(
        size = base_size * 0.8,
        color = "#2c3e50"
      ),

      axis.line = element_line(color = "#bdc3c7", size = 0.5),
      axis.ticks = element_line(color = "#bdc3c7", size = 0.5),

      # Grid
      panel.grid.major = element_line(
        color = config$colors$sequential[2],
        size = 0.5,
        linetype = "solid"
      ),

      panel.grid.minor = element_blank(),

      # Panel and plot background
      panel.background = element_rect(fill = "white", color = NA),
      plot.background = element_rect(fill = "white", color = NA),

      # Legend
      legend.position = "bottom",
      legend.title = element_text(size = base_size * 0.9, color = "#2c3e50"),
      legend.text = element_text(size = base_size * 0.8, color = "#2c3e50"),
      legend.box.background = element_blank(),
      legend.key = element_blank(),

      # Margins
      plot.margin = margin(25, 25, 25, 25),

      # Strip text (for facets)
      strip.text = element_text(
        size = base_size * 0.9,
        color = config$colors$primary,
        face = "plain",
        margin = margin(5, 5, 5, 5)
      ),

      strip.background = element_rect(
        fill = config$colors$sequential[1],
        color = NA
      )
    )
}

# ===================================================================
# COLOR SCALE FUNCTIONS
# ===================================================================

#' EKIO Academy Sequential Color Scale (Fill)
#'
#' @param style Theme style matching theme_ekio options
#' @param n Number of colors to generate (default: 7)
#' @param direction Direction of color scale: 1 = normal, -1 = reversed
#' @param ... Additional arguments passed to scale_fill_gradientn
#'
#' @examples
#' # Brazilian state choropleth
#' ggplot(data, aes(fill = gdp_index)) +
#'   geom_sf() +
#'   scale_fill_ekio_seq("modern_premium") +
#'   theme_ekio("modern_premium")

scale_fill_ekio_seq <- function(
  style = "academy_primary",
  n = 7,
  direction = 1,
  ...
) {
  colors <- switch(
    style,
    academy_primary = ekio_academy_colors$sequential,
    modern_premium = ekio_modern_premium_colors$sequential,
    academic_authority = ekio_academic_colors$sequential,
    sophisticated_unique = ekio_sophisticated_colors$sequential,
    institutional_oxford = ekio_institutional_colors$sequential,
    premium_steel = ekio_premium_steel_colors$sequential,
    ekio_academy_colors$sequential # default
  )

  if (direction == -1) {
    colors <- rev(colors)
  }

  scale_fill_gradientn(colors = colorRampPalette(colors)(n), ...)
}

#' EKIO Academy Sequential Color Scale (Color)
#'
#' @param style Theme style matching theme_ekio options
#' @param n Number of colors to generate (default: 7)
#' @param direction Direction of color scale: 1 = normal, -1 = reversed
#' @param ... Additional arguments passed to scale_color_gradientn

scale_color_ekio_seq <- function(
  style = "academy_primary",
  n = 7,
  direction = 1,
  ...
) {
  colors <- switch(
    style,
    academy_primary = ekio_academy_colors$sequential,
    modern_premium = ekio_modern_premium_colors$sequential,
    academic_authority = ekio_academic_colors$sequential,
    sophisticated_unique = ekio_sophisticated_colors$sequential,
    institutional_oxford = ekio_institutional_colors$sequential,
    premium_steel = ekio_premium_steel_colors$sequential,
    ekio_academy_colors$sequential
  )

  if (direction == -1) {
    colors <- rev(colors)
  }

  scale_color_gradientn(colors = colorRampPalette(colors)(n), ...)
}

#' EKIO Academy Categorical Color Scale (Fill)
#'
#' @param style Theme style matching theme_ekio options
#' @param ... Additional arguments passed to scale_fill_manual

scale_fill_ekio_cat <- function(style = "academy_primary", ...) {
  colors <- switch(
    style,
    academy_primary = ekio_academy_colors$categorical,
    modern_premium = ekio_modern_premium_colors$categorical,
    academic_authority = ekio_academic_colors$categorical,
    sophisticated_unique = ekio_sophisticated_colors$categorical,
    institutional_oxford = ekio_institutional_colors$categorical,
    premium_steel = ekio_premium_steel_colors$categorical,
    ekio_academy_colors$categorical
  )

  scale_fill_manual(values = colors, ...)
}

#' EKIO Academy Categorical Color Scale (Color)
#'
#' @param style Theme style matching theme_ekio options
#' @param ... Additional arguments passed to scale_color_manual

scale_color_ekio_cat <- function(style = "academy_primary", ...) {
  colors <- switch(
    style,
    academy_primary = ekio_academy_colors$categorical,
    modern_premium = ekio_modern_premium_colors$categorical,
    academic_authority = ekio_academic_colors$categorical,
    sophisticated_unique = ekio_sophisticated_colors$categorical,
    institutional_oxford = ekio_institutional_colors$categorical,
    premium_steel = ekio_premium_steel_colors$categorical,
    ekio_academy_colors$categorical
  )

  scale_color_manual(values = colors, ...)
}

# ===================================================================
# BRAZILIAN MAP UTILITIES
# ===================================================================

#' Quick Brazilian choropleth map with EKIO styling
#'
#' Convenience function for creating Brazilian state/municipal maps
#'
#' @param data Spatial data frame with geographic boundaries
#' @param fill_var Variable name for choropleth coloring
#' @param style EKIO theme style
#' @param title Plot title
#' @param subtitle Plot subtitle
#' @param caption Plot caption (default includes EKIO branding)
#'
#' @examples
#' # Brazilian states with GDP data
#' library(geobr)
#' states <- read_state(year = 2020)
#' states$gdp_index <- runif(nrow(states), 60, 140)
#'
#' ekio_choropleth_br(states, "gdp_index",
#'                   title = "Brazilian GDP Index by State",
#'                   style = "modern_premium")

ekio_choropleth_br <- function(
  data,
  fill_var,
  style = "academy_primary",
  title = NULL,
  subtitle = NULL,
  caption = "Source: IBGE | EKIO Analytics"
) {
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("sf package is required for Brazilian choropleth maps")
  }

  ggplot(data) +
    geom_sf(aes(fill = .data[[fill_var]]), color = "white", size = 0.2) +
    scale_fill_ekio_seq(
      style,
      name = stringr::str_to_title(gsub("_", " ", fill_var))
    ) +
    theme_ekio(style) +
    theme(
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      axis.line = element_blank(),
      panel.grid = element_blank()
    ) +
    labs(
      title = title,
      subtitle = subtitle,
      caption = caption
    )
}

# ===================================================================
# SETUP MESSAGE
# ===================================================================

# Display setup confirmation
cat("🎨 EKIO Academy Theme System Loaded Successfully!\n")
cat("═══════════════════════════════════════════════════\n")
cat("Available themes:\n")
cat("• theme_ekio('academy_primary') - Educational teal [DEFAULT]\n")
cat("• theme_ekio('modern_premium') - Professional sapphire blue\n")
cat("• theme_ekio('academic_authority') - Research deep blue\n")
cat("• theme_ekio('sophisticated_unique') - International cadet blue\n")
cat("• theme_ekio('institutional_oxford') - Banking oxford blue\n")
cat("• theme_ekio('premium_steel') - Executive steel blue\n")
cat("═══════════════════════════════════════════════════\n")
cat("💡 Pro tip: Use with Brazilian data from geobr, sidrar, GetBCBData\n\n")
