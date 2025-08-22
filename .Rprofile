# EKIO Academy R Profile
# Enhanced R environment for Brazilian urban economics education

# Set CRAN mirror to Brazilian server for faster downloads
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.fiocruz.br/"
  options(repos = r)
})

if (require(ggplot2, quietly = TRUE)) {
  theme_set(
    theme(
      plot.background = element_rect(fill = "transparent", color = NA),
      panel.backgroudn = element_rect(fill = "transparent", color = NA),
      legend.background = element_rect(fill = "transparent", color = NA)
    )
  )
}

# Direct package management - no renv dependency
# Packages will be installed directly to user library

# Set default options optimized for Brazilian economic analysis
options(
  digits = 4,
  scipen = 999, # Avoid scientific notation for Brazilian currency
  width = 80,
  pillar.subtle = FALSE,
  pillar.neg = FALSE,
  encoding = "UTF-8" # Proper Portuguese character support
)

# EKIO Academy color palette for immediate use
if (interactive()) {
  # Define EKIO Academy colors
  .GlobalEnv$ekio_colors <- list(
    # Academy Primary Theme (Educational Teal)
    academy_primary = "#1abc9c",
    academy_secondary = "#16a085",

    # EKIO Professional Themes
    modern_premium = "#2C6BB3",
    academic_authority = "#0F3A65",
    sophisticated_unique = "#5F9EA0",
    institutional_oxford = "#1E5F9F",
    professional_deep = "#0F3A65",
    premium_steel = "#4682B4",

    # Sequential scales for Brazilian data
    sapphire_seq = c(
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

    # Categorical palette for economic sectors
    categorical = c("#2C6BB3", "#1abc9c", "#f39c12", "#e74c3c", "#9b59b6"),

    # Brazilian context colors
    brazil_green = "#009c3b",
    brazil_yellow = "#ffdf00"
  )

  # Load essential packages for Brazilian economic analysis
  suppressMessages({
    # Set ggplot2 defaults to EKIO theme
    if (require(ggplot2, quietly = TRUE)) {
      theme_set(
        theme_minimal(base_size = 12, base_family = "Avenir") +
          theme(
            plot.background = element_rect(fill = "transparent", color = NA),
            panel.backgroudn = element_rect(fill = "transparent", color = NA),
            legend.background = element_rect(fill = "transparent", color = NA)
          )
      )
      update_geom_defaults(
        "point",
        list(color = .GlobalEnv$ekio_colors$modern_premium)
      )
      update_geom_defaults(
        "line",
        list(color = .GlobalEnv$ekio_colors$modern_premium)
      )
    }
  })

  # Welcome message with EKIO Academy branding
  cat("\n")
  cat("═══════════════════════════════════════════════════════════════\n")
  cat("   EKIO ACADEMY - R Environment for Urban Economics Education\n")
  cat("═══════════════════════════════════════════════════════════════\n")
  cat("📚 Educational Focus: Brazilian Urban Economics & Data Science\n")
  cat("🎨 EKIO Visual Identity: Available via 'ekio_colors' object\n")
  cat("🇧🇷 Brazilian Data Ready: geobr, sidrar, GetBCBData packages\n")
  cat("💼 Professional Standards: Consulting-grade methodologies\n")
  cat("═══════════════════════════════════════════════════════════════\n\n")

  # Display quick color palette reference
  cat("🎨 EKIO Academy Color Palette Quick Reference:\n")
  cat(
    "   • Academy Primary (Educational): ",
    .GlobalEnv$ekio_colors$academy_primary,
    "\n"
  )
  cat(
    "   • Modern Premium (Professional): ",
    .GlobalEnv$ekio_colors$modern_premium,
    "\n"
  )
  cat(
    "   • Academic Authority (Research): ",
    .GlobalEnv$ekio_colors$academic_authority,
    "\n\n"
  )

  cat(
    "💡 Pro Tip: Use 'source(\"assets/r/ekio-themes.R\")' for complete theme functions\n\n"
  )
}
