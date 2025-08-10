#!/bin/bash
# EKIO Academy - Quick Setup Script
# Run this script to set up your local development environment

set -e

echo "🎯 EKIO Academy Setup Script"
echo "================================"

# Check if required tools are installed
check_requirements() {
    echo "📋 Checking requirements..."
    
    # Check Git
    if ! command -v git &> /dev/null; then
        echo "❌ Git is required but not installed"
        exit 1
    fi
    echo "✅ Git found"
    
    # Check R
    if ! command -v R &> /dev/null; then
        echo "❌ R is required but not installed"
        echo "   Install from: https://cran.r-project.org/"
        exit 1
    fi
    echo "✅ R found"
    
    # Check Quarto
    if ! command -v quarto &> /dev/null; then
        echo "❌ Quarto is required but not installed"
        echo "   Install from: https://quarto.org/docs/get-started/"
        exit 1
    fi
    echo "✅ Quarto found"
    
    # Check Node.js (optional)
    if command -v node &> /dev/null; then
        echo "✅ Node.js found (optional features available)"
    else
        echo "⚠️  Node.js not found (optional features will be disabled)"
    fi
}

# Create directory structure
create_structure() {
    echo ""
    echo "📁 Creating directory structure..."
    
    # Main directories
    mkdir -p assets/{images/logos,css,js,fonts}
    mkdir -p _includes
    mkdir -p scripts
    mkdir -p tests
    mkdir -p docs
    
    # English content
    mkdir -p tutorials/{r-fundamentals,data-visualization,econometrics,urban-economics}
    mkdir -p books/{r-urban-economics,brazilian-data-guide,ekio-methods}
    mkdir -p courses/{complete-r-economists,advanced-urban-analytics}
    
    # Portuguese content
    mkdir -p pt/{tutoriais,livros,cursos}
    mkdir -p pt/tutoriais/{fundamentos-r,visualizacao-dados,econometria,economia-urbana}
    mkdir -p pt/livros/{r-economia-urbana,guia-dados-brasileiros,metodos-ekio}
    mkdir -p pt/cursos/{r-completo-economistas,analytics-urbana-avancada}
    
    echo "✅ Directory structure created"
}

# Initialize Git repository
init_git() {
    echo ""
    echo "🔧 Initializing Git repository..."
    
    if [ ! -d ".git" ]; then
        git init
        
        # Create .gitignore
        cat > .gitignore << 'EOF'
# Quarto
_site/
_site-pt/
.quarto/
*.html

# R
.Rproj.user/
.Rhistory
.RData
.Ruserdata
renv/library/
renv/staging/

# OS
.DS_Store
Thumbs.db
*~

# IDE
.vscode/
*.Rproj

# Temporary files
*.log
*.tmp

# Dependencies
node_modules/

# Environment variables
.env
.env.local
EOF
        
        echo "✅ Git repository initialized"
    else
        echo "ℹ️  Git repository already exists"
    fi
}

# Setup R environment
setup_r() {
    echo ""
    echo "📦 Setting up R environment..."
    
    # Create .Rprofile
    cat > .Rprofile << 'EOF'
# EKIO Academy R Profile

# Set CRAN mirror
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.rstudio.com/"
  options(repos = r)
})

# Load renv for package management
if (file.exists("renv/activate.R")) {
  source("renv/activate.R")
}

# Set default options
options(
  digits = 4,
  scipen = 999,
  width = 80
)

if (interactive()) {
  cat("🎯 EKIO Academy R Environment Loaded\n")
}
EOF
    
    # Initialize renv and install packages
    Rscript -e "
    if (!require(renv, quietly = TRUE)) install.packages('renv')
    renv::init(bare = TRUE)
    
    # Install required packages
    packages <- c(
      'tidyverse', 'scales', 'extrafont', 'geobr', 'sf',
      'DT', 'plotly', 'shiny', 'rmarkdown'
    )
    
    cat('Installing R packages...\n')
    renv::install(packages)
    renv::snapshot()
    cat('✅ R environment setup complete\n')
    "
}

# Setup Node.js environment (optional)
setup_node() {
    if command -v node &> /dev/null; then
        echo ""
        echo "📦 Setting up Node.js environment..."
        
        # Create package.json
        cat > package.json << 'EOF'
{
  "name": "ekio-academy",
  "version": "1.0.0",
  "description": "EKIO Academy website",
  "scripts": {
    "build": "quarto render",
    "preview": "quarto preview",
    "build:css": "sass custom.scss assets/css/ekio-theme.css"
  },
  "devDependencies": {
    "sass": "^1.69.5",
    "netlify-cli": "^17.10.1"
  }
}
EOF
        
        npm install
        echo "✅ Node.js environment setup complete"
    else
        echo "⚠️  Skipping Node.js setup (not installed)"
    fi
}

# Create basic configuration files
create_configs() {
    echo ""
    echo "⚙️  Creating configuration files..."
    
    # Create basic _quarto.yml
    cat > _quarto.yml << 'EOF'
project:
  type: website
  title: "EKIO Academy"

website:
  title: "EKIO Academy"
  description: "R & Data Science for Economics and Urban Analysis"
  
  navbar:
    title: "EKIO Academy"
    background: "#2C6BB3"
    foreground: white
    left:
      - text: "Tutorials"
        href: tutorials/index.qmd
      - text: "Books" 
        href: books/index.qmd
      - text: "Courses"
        href: courses/index.qmd

format:
  html:
    theme: cosmo
    toc: true
    css: styles.css
    
execute:
  echo: true
  warning: false
  message: false
  cache: true
EOF
    
    # Create basic styles.css
    cat > styles.css << 'EOF'
/* EKIO Academy Custom Styles */

/* EKIO Colors */
:root {
  --ekio-primary: #2C6BB3;
  --ekio-secondary: #1abc9c;
  --ekio-dark: #2c3e50;
  --ekio-light: #f8f9fa;
}

/* Typography */
body {
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, sans-serif;
}

/* EKIO CTA sections */
.ekio-cta {
  background: linear-gradient(135deg, var(--ekio-secondary), #16a085);
  color: white;
  padding: 3rem 2rem;
  border-radius: 8px;
  text-align: center;
  margin: 2rem 0;
}

.btn-ekio {
  background: var(--ekio-primary);
  border: none;
  color: white;
  padding: 0.75rem 1.5rem;
  border-radius: 4px;
  font-weight: 500;
  text-decoration: none;
  display: inline-block;
  transition: all 0.3s ease;
}

.btn-ekio:hover {
  background: #204d81;
  transform: translateY(-2px);
  color: white;
}
EOF
    
    echo "✅ Configuration files created"
}

# Create sample content
create_sample_content() {
    echo ""
    echo "📝 Creating sample content..."
    
    # Homepage
    cat > index.qmd << 'EOF'
---
title: "EKIO Academy"
subtitle: "R & Data Science for Economics and Urban Analysis"
---

# Welcome to EKIO Academy

Learn R programming, econometrics, and data visualization with practical tutorials designed specifically for economists and urban planners working with Brazilian data.

## What You'll Find Here

### 📚 Tutorials
Step-by-step guides covering everything from R basics to advanced econometric techniques.

### 📖 Books  
Comprehensive resources and eBooks covering specialized topics in urban economics.

### 🎓 Courses
Structured learning paths taking you from beginner to expert.

::: {.ekio-cta}
## Ready for Professional Support?

Whatever your data challenge, EKIO has the solution. From municipal budget analysis to housing market forecasting.

[Discover EKIO Professional Services →](https://ekio.com.br){.btn-ekio}
:::
EOF
    
    # Tutorials index
    cat > tutorials/index.qmd << 'EOF'
---
title: "Tutorials"
subtitle: "Step-by-step R guides for economists"
---

# R Tutorials for Economics

Welcome to our comprehensive tutorial collection. Each tutorial includes practical examples using real Brazilian economic data.

## Getting Started

- [R Basics for Economists](r-fundamentals/index.qmd)
- [Data Import & Cleaning](r-fundamentals/data-import.qmd)
- [Working with Brazilian Data](r-fundamentals/brazilian-data.qmd)

## Data Visualization

- [ggplot2 Essentials](data-visualization/ggplot2-basics.qmd)
- [EKIO Visual Identity in R](data-visualization/ekio-theme.qmd)
- [Brazilian Maps & Choropleth](data-visualization/maps.qmd)
EOF
    
    # Basic tutorial
    cat > tutorials/r-fundamentals/index.qmd << 'EOF'
---
title: "R Fundamentals for Economists"
subtitle: "Getting started with R for economic analysis"
---

# Introduction to R for Economics

This tutorial introduces R programming specifically for economists and urban planners.

## What You'll Learn

- R syntax and basic operations
- Working with economic data
- Creating simple visualizations
- Best practices for reproducible research

## Prerequisites

- No prior programming experience needed
- Basic understanding of economics/statistics helpful

## Setup

First, let's load the packages we'll need:

```{r setup}
library(tidyverse)
library(scales)

# Sample economic data
gdp_data <- data.frame(
  year = 2015:2020,
  gdp_growth = c(-3.5, -3.3, 1.3, 1.8, 1.2, -3.9)
)

gdp_data
```

## Your First Economic Chart

```{r first-chart}
ggplot(gdp_data, aes(x = year, y = gdp_growth)) +
  geom_line(size = 1.2, color = "#2C6BB3") +
  geom_point(size = 3, color = "#2C6BB3") +
  labs(
    title = "Brazilian GDP Growth",
    subtitle = "Annual percentage change",
    x = "Year",
    y = "GDP Growth (%)"
  ) +
  theme_minimal()
```

## Next Steps

Continue with [Data Import & Cleaning](../data-import.qmd) to learn how to work with real Brazilian economic data.
EOF
    
    echo "✅ Sample content created"
}

# Create deployment scripts
create_scripts() {
    echo ""
    echo "🚀 Creating deployment scripts..."
    
    mkdir -p scripts
    
    # Local build script
    cat > scripts/build.sh << 'EOF'
#!/bin/bash
# Local build script for EKIO Academy

echo "🏗️  Building EKIO Academy..."

# Build English version
echo "🇺🇸 Building English site..."
quarto render --profile default

# Check if Portuguese content exists
if [ -d "pt" ]; then
    echo "🇧🇷 Building Portuguese site..."
    quarto render --profile portuguese
    
    # Combine sites
    echo "🔗 Combining sites..."
    mkdir -p _combined
    cp -r _site/* _combined/
    mkdir -p _combined/pt
    cp -r _site-pt/* _combined/pt/ 2>/dev/null || true
else
    echo "ℹ️  Portuguese content not found, building English only"
    mkdir -p _combined
    cp -r _site/* _combined/
fi

echo "✅ Build complete! Open _combined/index.html to view."
EOF
    
    chmod +x scripts/build.sh
    
    # Netlify build script
    cat > scripts/netlify-build.sh << 'EOF'
#!/bin/bash
# Netlify build script

set -e

echo "🚀 Starting EKIO Academy build..."

# Setup R environment
echo "📦 Setting up R environment..."
Rscript -e "if(!require(renv)) install.packages('renv'); renv::restore()"

# Build English version
echo "🇺🇸 Building English site..."
quarto render --profile default

# Build Portuguese version if it exists
if [ -d "pt" ]; then
    echo "🇧🇷 Building Portuguese site..."
    quarto render --profile portuguese
fi

# Combine sites
echo "🔗 Combining sites..."
mkdir -p _combined
cp -r _site/* _combined/
if [ -d "_site-pt" ]; then
    mkdir -p _combined/pt
    cp -r _site-pt/* _combined/pt/
fi

echo "✅ Build complete!"
EOF
    
    chmod +x scripts/netlify-build.sh
    
    echo "✅ Deployment scripts created"
}

# Main execution
main() {
    echo "Starting EKIO Academy setup..."
    echo ""
    
    check_requirements
    create_structure
    init_git
    setup_r
    setup_node
    create_configs
    create_sample_content
    create_scripts
    
    echo ""
    echo "🎉 EKIO Academy setup complete!"
    echo ""
    echo "Next steps:"
    echo "1. 📝 Customize _quarto.yml with your settings"
    echo "2. 🎨 Add your EKIO logo to assets/images/logos/"
    echo "3. 📖 Start creating content in tutorials/, books/, courses/"
    echo "4. 🚀 Push to GitHub and set up Netlify deployment"
    echo ""
    echo "To preview your site locally:"
    echo "  quarto preview"
    echo ""
    echo "To build for deployment:"
    echo "  ./scripts/build.sh"
    echo ""
    echo "Happy coding! 🎯"
}

# Run setup
main "$@"