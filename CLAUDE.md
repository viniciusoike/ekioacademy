# EKIO Academy - Project Documentation

## Project Goal

Create EKIO Academy - a **Portuguese-language** educational website built entirely with Quarto that serves as:

* Educational hub for R programming and economic analysis tutorials
* Lead generation engine for EKIO consulting services
* Revenue source through courses and premium content
* Authority building platform in Brazilian economics/R space

## Current Status (October 2025)

**Recent Major Changes:**
- Converted from bilingual (EN/PT) to Portuguese-only website (August 2025)
- Implemented McKinsey-style featured insights approach for blog
- Added comprehensive typography system and code output styling
- Active development on 2025 blog content focusing on R basics and tidyverse

**Current Branch:** `feature/mckinsey-replication-post`
- Improving site typography
- Adding tibble output styling for better readability
- Cleaning up blog post cache files

## Technical Architecture

### Core Stack
- **Framework:** Quarto 1.7.32 (website project type)
- **Frontend:** Bootstrap 5 + Custom SCSS theme system
- **Build System:** Node.js 18+ with npm scripts
- **Styling:** Sass with 6-theme color system
- **Deployment:** Netlify with automated CI/CD
- **R Integration:** Custom ggplot2 themes and plotting utilities

### Theme System

EKIO Academy uses a comprehensive 6-theme color system defined in `custom.scss`:

1. **Academy Primary** (#1abc9c) - Main educational theme
2. **Modern Premium** (#2C6BB3) - Professional/Business content
3. **Academic Authority** (#0F3A65) - Research/Government
4. **Sophisticated Unique** (#5F9EA0) - International clients
5. **Institutional Oxford** (#1E5F9F) - Banking/Financial
6. **Premium Steel** (#4682B4) - Executive/Investment

### Build Commands

```bash
npm run build          # Full build (CSS + Quarto)
npm run build:css      # Compile SCSS to CSS
npm run watch          # Watch SCSS changes
npm run preview        # Preview site locally
npm run dev            # Watch CSS + preview simultaneously
npm run clean          # Clean build artifacts
```

### File Structure

```
ekioacademy/
├── _quarto.yml                 # Main Quarto configuration
├── custom.scss                 # Theme system (983 lines)
├── index.qmd                   # Homepage
│
├── blog/                       # Blog posts (Portuguese)
│   ├── posts/                  # 10 active posts (2025 focus)
│   └── categories/             # Category pages
│
├── tutorials/                  # Educational content by category
│   ├── time-series/           # 7 tutorials
│   ├── data-visualization/    # Multiple tutorials + ggplot2 series
│   ├── econometrics/          # Economic theory
│   ├── tutorial-r/            # R basics and advanced
│   └── urban-economics/       # Urban analysis
│
├── courses/                    # Course offerings
│   ├── complete-r-economists/
│   ├── brazilian-data-mastery/
│   ├── advanced-urban-analytics/
│   └── professional-consulting/
│
├── weekly-charts/              # Visual-focused content
│   └── charts/                 # 13 chart posts
│
├── books/                      # Resource library
│
├── R/                          # R utilities
│   ├── ekio_plotting.R        # Custom ggplot2 themes
│   ├── weekly_charts_template.R
│   ├── svg_export_guide.md
│   └── test_svg_export.R
│
├── assets/                     # Static assets
│   ├── css/                   # Compiled CSS
│   ├── themes/                # Syntax highlighting themes
│   ├── images/                # Images
│   ├── fonts/                 # Web fonts
│   └── r/                     # R theme files
│
└── content-archive/           # Old content being migrated
```

## Content Organization

### Blog Posts (10 active posts)
Focus on R programming fundamentals and tidyverse:
- Definindo objetos no R
- Pipes in R (native vs magrittr)
- Tidyverse philosophy and learning
- Brazilian economic data packages
- Real estate market analysis

### Tutorials (Organized by Category)
1. **Time Series** (7 tutorials): ARIMA, SARIMA, Hamilton trend, seasonality, moving averages
2. **Data Visualization**: ggplot2 series, demographic pyramids, plotting techniques
3. **Econometrics**: Regression, optimization, asymptotic theory
4. **R Programming**: Basics to advanced techniques
5. **Urban Economics**: Brazilian urban data analysis

### Courses (4 offerings - structure defined)
- Complete R for Economists
- Brazilian Data Mastery
- Advanced Urban Analytics
- Professional Consulting

### Weekly Charts (13 posts)
Visual-first content with minimal text, infinite scroll design

## Development Patterns

### R Code Conventions
* Follow tidyverse style guide
* Use `{cli}` package for messages
* Use `|>` as pipe operator (native pipe)
* Custom EKIO plotting themes for consistency

### Content Workflow
1. Create `.qmd` files with YAML frontmatter
2. R code chunks with `freeze: true` for caching
3. Generate figures in `_freeze/` directory
4. Quarto renders to `_site/`

### Git Workflow
* Feature branches for new content
* Descriptive commit messages
* Cache files tracked in `_freeze/` for reproducibility
* Archive old content in `content-archive/`

## Deployment Configuration

**Platform:** Netlify
**Build Command:** Custom (downloads Quarto + npm build)
**Publish Directory:** `_site`

**Features:**
- Security headers (CSP, X-Frame-Options, etc.)
- Asset caching (1 year for static assets)
- Form handling for course enrollment and contact
- Language-based redirects (legacy)

## Recent Development (Last 20 commits)

Key themes:
1. **Typography improvements** - Better font system and readability
2. **Code output styling** - Smaller tibble outputs, better code blocks
3. **Content cleanup** - Removing old cache, fixing broken references
4. **Blog structure** - 2025 content focusing on R fundamentals
5. **Site conversion** - Multilingual to Portuguese-only
6. **Syntax highlighting** - Material Palenight R theme integration

## Next Steps & Suggestions

### Content Development
- [ ] Complete ggplot2 tutorial series (currently 4 tutorials in data-viz)
- [ ] Expand blog to 20+ posts (currently 10)
- [ ] Create featured insights content with professional imagery
- [ ] Develop course content for the 4 defined course offerings
- [ ] Add more weekly charts (target: 50+ for good infinite scroll)

### Technical Enhancements
- [ ] Set up Google Analytics (GA-XXXXXXXXXX placeholder in _quarto.yml)
- [ ] Implement newsletter signup integration
- [ ] Add social sharing functionality for posts
- [ ] Optimize SEO metadata for all pages
- [ ] Implement actual infinite scroll backend for weekly charts
- [ ] Add search functionality improvements
- [ ] Consider adding comments system (utterances/giscus)

### R Ecosystem
- [ ] Document custom ggplot2 themes in R/ekio_plotting.R
- [ ] Create package from EKIO R utilities
- [ ] Add more Brazilian data source integrations
- [ ] Develop reusable templates for common visualizations

### Marketing & Growth
- [ ] Create lead magnets (downloadable R cheatsheets)
- [ ] Develop email course sequences
- [ ] Add testimonials section
- [ ] Create case studies from consulting work
- [ ] Integrate with EKIO main site (ekio.io)

### Code Quality
- [ ] Add linting for R code (lintr package)
- [ ] Set up automated testing for R utilities
- [ ] Document all custom SCSS components
- [ ] Create style guide for contributors
- [ ] Add pre-commit hooks for code formatting

## Key Files to Understand

1. **`_quarto.yml`** - Site configuration, navigation, rendering options
2. **`custom.scss`** - Complete theme system (983 lines)
3. **`package.json`** - Build scripts and dependencies
4. **`netlify.toml`** - Deployment configuration
5. **`R/ekio_plotting.R`** - Custom ggplot2 themes
6. **`SITE-RESTRUCTURE-SUMMARY.md`** - McKinsey-style restructure documentation

## Coding Conventions

### R Code
* Follow tidyverse style guide
* Use `{cli}` package for messages and user communication
* Use `|>` as pipe operator (native pipe preferred over `%>%`)
* Function names: snake_case
* Variable names: snake_case
* File names: kebab-case.R

### Quarto/Markdown
* File names: kebab-case.qmd
* YAML frontmatter required for all content
* Use freeze: true for computational content
* Include thumbnail images for blog posts

### CSS/SCSS
* Follow BEM-like naming for components
* Use theme variables defined in custom.scss
* Mobile-first responsive design
* Comment complex styling rules

## Performance Considerations

* Quarto freeze enabled to cache R computations
* Aggressive asset caching (1 year) on Netlify
* Optimized images in assets/
* Minified CSS in production
* Code splitting for better load times

## Useful Resources

* [Quarto Documentation](https://quarto.org)
* [EKIO Main Site](https://ekio.io)
* [Deployment Guide](DEPLOYMENT.md)
* [Site Restructure Summary](SITE-RESTRUCTURE-SUMMARY.md)
* R Theme Documentation: R/svg_export_guide.md
