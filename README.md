# EKIO Academy

Educational platform for R programming and econometrics focused on Brazilian urban economics analysis.

[![R](https://img.shields.io/badge/R-4.3.2+-blue.svg)](https://www.r-project.org/)
[![Quarto](https://img.shields.io/badge/Quarto-1.4.0+-green.svg)](https://quarto.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Overview

EKIO Academy is a bilingual educational platform built with Quarto that provides tutorials, courses, and resources for R programming and econometrics using Brazilian economic data.

### Features

- Interactive R tutorials with executable code
- Bilingual support (English/Portuguese)
- Integration with Brazilian data sources (IBGE, BCB, IPEA, FINBRA)
- Professional course offerings
- Complete R theme system for data visualization

### Technical Stack

- **Frontend**: Quarto + Bootstrap 5 + Custom SCSS
- **R Integration**: Custom ggplot2 themes and data processing workflows
- **Deployment**: Netlify with GitHub Actions CI/CD
- **Content**: Markdown-based with multilingual support

## Development

### Prerequisites

- R (4.3.2+)
- Quarto (1.4.0+)
- Node.js (18+) and npm

### Setup

```bash
git clone https://github.com/viniciusoike/ekioacademy.git
cd ekioacademy

# Install dependencies
npm install

# Install R packages
Rscript -e "source('.Rprofile')"

# Preview site
quarto preview

# Build site
npm run build
```

### Structure

```
ekioacademy/
├── index.qmd              # English homepage
├── tutorials/             # English tutorials
├── books/                 # Resource library
├── courses/               # Course offerings
├── blog/                  # Blog posts
├── pt/                    # Portuguese content
├── assets/r/              # R theme system
└── _includes/             # Reusable components
```

## Data Sources

The platform integrates with major Brazilian economic data providers:

- IBGE (Census, regional accounts)
- Banco Central (financial indicators)
- IPEA (research data)
- FINBRA (municipal finance)
- geobr (geographic boundaries)

## Deployment

Automatic deployment to Netlify on push to main branch.

Manual deployment:
```bash
npm run build
npm run deploy
```

## License

MIT License - see [LICENSE](LICENSE) file for details.

## About

EKIO Academy is developed by [EKIO Analytics](https://ekio.com.br), a consultancy specializing in Brazilian urban economics analysis.
