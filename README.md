# EKIO Academy - R & Data Science for Economics

🎓 **Educational platform for Brazilian urban economics and data science**

[![Deploy Status](https://api.netlify.com/api/v1/badges/YOUR_SITE_ID/deploy-status)](https://app.netlify.com/sites/YOUR_SITE_NAME/deploys)
[![R](https://img.shields.io/badge/R-4.3.2+-blue.svg)](https://www.r-project.org/)
[![Quarto](https://img.shields.io/badge/Quarto-1.4.0+-green.svg)](https://quarto.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 🚀 Live Site

- **English**: [https://academy.ekio.com.br](https://academy.ekio.com.br)
- **Portuguese**: [https://academy.ekio.com.br/pt](https://academy.ekio.com.br/pt)

## 📋 Project Overview

EKIO Academy is a comprehensive bilingual educational platform designed to teach R programming and econometrics specifically for Brazilian urban economics analysis. Built with Quarto, it features:

### 🎯 Core Features

- **📚 Interactive Tutorials**: Step-by-step R guides with executable code
- **📖 Free Resources**: eBooks and guides for Brazilian economic data analysis  
- **🎓 Professional Courses**: Structured learning paths from beginner to expert
- **🌐 Bilingual Support**: Full English/Portuguese content with automatic detection
- **📊 Brazilian Data Integration**: Real examples using IBGE, BCB, IPEA, FINBRA data
- **🎨 Professional Branding**: Complete EKIO visual identity system

### 🏗️ Technical Architecture

- **Frontend**: Quarto + Bootstrap 5 + Custom SCSS
- **R Integration**: Complete theme system for ggplot2 visualizations
- **Deployment**: Netlify with GitHub Actions CI/CD
- **Content Management**: Markdown-based with multilingual support
- **Analytics**: Google Analytics 4 with educational engagement tracking

## 🛠️ Development Setup

### Prerequisites

- **R** (4.3.2+) with packages:
  ```r
  install.packages(c("tidyverse", "ggplot2", "scales", "DT", "plotly", 
                     "sf", "geobr", "sidrar", "cli"))
  ```
- **Quarto** (1.4.0+): [Download](https://quarto.org/docs/get-started/)
- **Node.js** (18+) and npm: [Download](https://nodejs.org/)

### Quick Start

```bash
# Clone repository
git clone https://github.com/ekio-brazil/ekio-academy.git
cd ekio-academy

# Install Node.js dependencies
npm install

# Install R dependencies (run in R)
source(".Rprofile")  # Will install required packages

# Preview English site
quarto preview

# Preview Portuguese site  
quarto preview --profile portuguese

# Build both versions
npm run build
```

## 📝 Content Structure

```
ekio-academy/
├── index.qmd                    # English homepage
├── tutorials/                   # English tutorials
│   ├── r-fundamentals/         # R basics for economists
│   ├── data-visualization/     # ggplot2 + EKIO themes
│   ├── econometrics/          # Statistical modeling
│   └── urban-economics/       # Brazilian urban data
├── books/                      # Free and premium resources
├── courses/                    # Professional course offerings
├── pt/                        # Portuguese content mirror
│   ├── index.qmd             # Portuguese homepage
│   ├── tutoriais/            # Translated tutorials
│   ├── livros/               # Translated books
│   └── cursos/               # Translated courses
├── assets/                    # Static assets
│   ├── r/ekio-themes.R       # Complete R theme system
│   ├── css/                  # Compiled CSS themes
│   └── images/               # Logos and graphics
└── _includes/                 # Reusable components
    ├── head-custom.html      # SEO and analytics
    ├── analytics.html        # GA4 tracking
    └── ekio-cta.qmd         # Call-to-action component
```

## 🎨 EKIO Brand System

The platform implements a complete 6-theme visual identity system:

### Color Themes

1. **Academy Primary** (`#1abc9c`) - Main educational theme
2. **Modern Premium** (`#2C6BB3`) - Professional presentations  
3. **Academic Authority** (`#0F3A65`) - Research/government contexts
4. **Sophisticated Unique** (`#5F9EA0`) - International clients
5. **Institutional Oxford** (`#1E5F9F`) - Banking/financial
6. **Premium Steel** (`#4682B4`) - Executive/investment

### R Theme Usage

```r
# Load EKIO theme system
source("assets/r/ekio-themes.R")

# Apply educational theme (default)
ggplot(data, aes(x, y)) + 
  geom_point() + 
  theme_ekio("academy_primary") +
  scale_color_ekio_cat("academy_primary")

# Professional presentation theme
ggplot(data, aes(x, y, fill = category)) + 
  geom_col() + 
  theme_ekio("modern_premium") +
  scale_fill_ekio_seq("modern_premium")
```

## 🚀 Deployment

### Automatic Deployment

Pushes to `main` branch automatically deploy to Netlify via GitHub Actions:

- **Production**: [https://academy.ekio.com.br](https://academy.ekio.com.br)
- **Preview**: Pull requests generate preview deployments

### Manual Deployment

```bash
# Build for production
npm run build

# Deploy to Netlify (requires netlify-cli)
npm run deploy
```

## 📊 Brazilian Data Integration

The platform showcases real Brazilian economic data sources:

- **IBGE**: Census, PNAD, regional accounts via `sidrar` package
- **Banco Central**: Financial indicators via `rbcb` package  
- **IPEA**: Research data via `ipeadatar` package
- **FINBRA**: Municipal finance data
- **FipeZap**: Real estate price indices
- **geobr**: Brazilian geographic boundaries for choropleth maps

## 🧪 Testing

```bash
# Run link checker
npm run test:links

# Test R code in tutorials
npm run test:r-code

# Lint CSS
npm run lint:css

# Format content
npm run format:md
```

## 📈 Performance

- **Lighthouse Score**: 90+ for Performance, Accessibility, SEO
- **Brazilian Optimization**: CDN optimized for Brazilian users
- **Mobile-First**: Responsive design for all devices
- **SEO**: Comprehensive meta tags and structured data

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-tutorial`
3. Commit changes: `git commit -m 'Add amazing tutorial on municipal data'`
4. Push branch: `git push origin feature/amazing-tutorial`
5. Submit pull request

### Content Guidelines

- **Tutorials**: Include executable R code with Brazilian data examples
- **Bilingual**: All content must have English and Portuguese versions
- **EKIO Branding**: Follow visual identity guidelines in `custom.scss`
- **Professional Standard**: Maintain consulting-grade quality

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🏢 About EKIO

EKIO Academy is part of [EKIO Analytics](https://ekio.com.br), Brazil's leading urban economics consultancy. Founded on the principle of making complex economic analysis accessible and actionable, EKIO combines academic rigor with practical implementation.

**Professional Services**: Municipal analysis, housing market research, economic development strategies, and custom R training.

---

**Built with ❤️ for the Brazilian economics community**

🎓 Learn • 📊 Analyze • 🚀 Succeed