# EKIO Academy - Complete Directory Structure

ekio-academy/
├── README.md                           # Project documentation
├── LICENSE                             # MIT/Creative Commons license
├── .gitignore                          # Git ignore file
├── .github/                           # GitHub Actions workflows
│   └── workflows/
│       ├── deploy-netlify.yml         # Netlify deployment
│       ├── pr-preview.yml             # PR preview builds
│       └── link-checker.yml           # Broken link checking
├── _quarto.yml                        # Main Quarto configuration (EN)
├── _quarto-pt.yml                     # Portuguese configuration
├── custom.scss                        # EKIO visual identity theme
├── styles.css                         # Additional custom styles
├── netlify.toml                       # Netlify configuration
├── package.json                       # Node.js dependencies (if needed)
├── renv.lock                          # R environment lock file
├── .Rprofile                          # R profile for consistent setup
│
├── assets/                            # Static assets
│   ├── images/
│   │   ├── logos/
│   │   │   ├── ekio-academy-logo.png
│   │   │   ├── ekio-academy-logo.svg
│   │   │   └── favicon.ico
│   │   ├── thumbnails/               # Tutorial/course thumbnails
│   │   ├── charts/                   # Sample chart images
│   │   └── backgrounds/              # Hero section backgrounds
│   ├── css/
│   │   └── ekio-theme.css           # Compiled EKIO theme
│   ├── js/
│   │   ├── language-switch.js       # Language switching logic
│   │   ├── analytics.js             # Google Analytics setup
│   │   └── ekio-widgets.js          # Custom interactive elements
│   └── fonts/                       # Custom fonts (Avenir, etc.)
│       ├── avenir/
│       └── fira-code/
│
├── _includes/                         # Reusable components
│   ├── head-custom.html              # Custom head elements
│   ├── navbar-custom.html            # Custom navigation
│   ├── footer-custom.html            # Custom footer
│   ├── ekio-cta.qmd                  # Reusable EKIO CTA component
│   ├── language-toggle.html          # Language switcher
│   └── analytics.html                # Analytics tracking
│
├── _extensions/                       # Quarto extensions
│   └── ekio-academy/                 # Custom EKIO extension
│       ├── _extension.yml
│       ├── ekio-theme.scss
│       └── ekio-filters.lua
│
# ENGLISH CONTENT (ROOT)
├── index.qmd                          # Homepage (EN)
├── about.qmd                          # About page (EN)
├── contact.qmd                        # Contact page (EN)
├── search.qmd                         # Search functionality
│
├── tutorials/                         # English tutorials
│   ├── index.qmd                     # Tutorials index
│   ├── _metadata.yml                 # Shared metadata
│   │
│   ├── r-fundamentals/               # R Basics section
│   │   ├── index.qmd
│   │   ├── r-basics/
│   │   │   ├── index.qmd
│   │   │   ├── data/                 # Sample datasets
│   │   │   │   ├── sample_gdp.csv
│   │   │   │   └── brazil_states.rds
│   │   │   ├── images/               # Tutorial-specific images
│   │   │   └── exercises/            # Practice exercises
│   │   ├── data-import/
│   │   │   ├── index.qmd
│   │   │   ├── data/
│   │   │   └── scripts/              # R scripts for download
│   │   └── brazilian-data/
│   │       ├── index.qmd
│   │       ├── api-examples/
│   │       └── data-sources/
│   │
│   ├── data-visualization/            # Visualization section
│   │   ├── index.qmd
│   │   ├── ggplot2-basics/
│   │   │   ├── index.qmd
│   │   │   ├── examples/
│   │   │   └── exercises/
│   │   ├── ekio-visual-identity/
│   │   │   ├── index.qmd
│   │   │   ├── theme-files/          # EKIO theme R scripts
│   │   │   ├── color-palettes/
│   │   │   └── example-charts/
│   │   ├── choropleth-maps/
│   │   │   ├── index.qmd
│   │   │   ├── shapefiles/
│   │   │   └── examples/
│   │   └── interactive-dashboards/
│   │       ├── index.qmd
│   │       ├── shiny-apps/
│   │       └── plotly-examples/
│   │
│   ├── econometrics/                  # Econometrics section
│   │   ├── index.qmd
│   │   ├── linear-regression/
│   │   │   ├── index.qmd
│   │   │   ├── datasets/
│   │   │   └── model-diagnostics/
│   │   ├── time-series/
│   │   │   ├── index.qmd
│   │   │   ├── brazil-macro-data/
│   │   │   └── forecasting-examples/
│   │   ├── panel-data/
│   │   │   ├── index.qmd
│   │   │   ├── municipal-data/
│   │   │   └── fixed-effects-examples/
│   │   └── causal-inference/
│   │       ├── index.qmd
│   │       ├── did-examples/
│   │       └── iv-applications/
│   │
│   └── urban-economics/               # Urban economics section
│       ├── index.qmd
│       ├── housing-market/
│       │   ├── index.qmd
│       │   ├── fipezap-data/
│       │   └── hedonic-models/
│       ├── municipal-finance/
│       │   ├── index.qmd
│       │   ├── finbra-analysis/
│       │   └── fiscal-indicators/
│       └── transport-analysis/
│           ├── index.qmd
│           ├── accessibility-metrics/
│           └── gtfs-analysis/
│
├── books/                             # English books/resources
│   ├── index.qmd                     # Books index
│   ├── _metadata.yml
│   │
│   ├── r-urban-economics/
│   │   ├── index.qmd                 # Book overview
│   │   ├── download.qmd              # Download page
│   │   ├── chapters/                 # Individual chapters
│   │   │   ├── 01-introduction.qmd
│   │   │   ├── 02-data-sources.qmd
│   │   │   ├── 03-spatial-analysis.qmd
│   │   │   └── ...
│   │   ├── datasets/                 # Book datasets
│   │   ├── code/                     # Book R scripts
│   │   └── exercises/                # Chapter exercises
│   │
│   ├── brazilian-data-guide/
│   │   ├── index.qmd
│   │   ├── download.qmd
│   │   ├── api-reference/
│   │   ├── data-dictionaries/
│   │   └── example-scripts/
│   │
│   ├── ekio-methods/
│   │   ├── index.qmd
│   │   ├── purchase.qmd              # Payment/purchase page
│   │   ├── preview.qmd               # Free preview chapters
│   │   ├── advanced-methods/
│   │   └── consulting-frameworks/
│   │
│   └── econometrics-cookbook/
│       ├── index.qmd
│       ├── waitlist.qmd              # Pre-order signup
│       └── recipe-previews/
│
├── courses/                           # English courses
│   ├── index.qmd                     # Courses index
│   ├── _metadata.yml
│   │
│   ├── complete-r-economists/
│   │   ├── index.qmd                 # Course overview
│   │   ├── curriculum.qmd            # Detailed curriculum
│   │   ├── enroll.qmd                # Enrollment page
│   │   ├── modules/                  # Course modules
│   │   │   ├── week-01/
│   │   │   │   ├── lessons/
│   │   │   │   ├── exercises/
│   │   │   │   └── data/
│   │   │   ├── week-02/
│   │   │   └── ...
│   │   ├── resources/                # Course resources
│   │   └── final-project/
│   │
│   ├── advanced-urban-analytics/
│   │   ├── index.qmd
│   │   ├── enroll.qmd
│   │   ├── preview.qmd               # Sample lessons
│   │   ├── modules/
│   │   └── case-studies/
│   │
│   ├── brazilian-data-mastery/
│   │   ├── index.qmd
│   │   ├── enroll.qmd
│   │   ├── modules/
│   │   └── projects/
│   │
│   ├── professional-consulting/
│   │   ├── index.qmd
│   │   ├── apply.qmd                 # Application process
│   │   ├── modules/
│   │   ├── mentoring/
│   │   └── case-studies/
│   │
│   └── corporate-training/
│       ├── index.qmd
│       ├── request-quote.qmd
│       ├── case-studies/
│       └── testimonials/
│
# PORTUGUESE CONTENT
├── pt/                                # Portuguese root
│   ├── index.qmd                     # Homepage (PT)
│   ├── sobre.qmd                     # About page (PT)
│   ├── contato.qmd                   # Contact page (PT)
│   │
│   ├── tutoriais/                    # Portuguese tutorials
│   │   ├── index.qmd
│   │   ├── fundamentos-r/
│   │   │   ├── index.qmd
│   │   │   ├── basico-r/
│   │   │   ├── importacao-dados/
│   │   │   └── dados-brasileiros/
│   │   ├── visualizacao-dados/
│   │   │   ├── index.qmd
│   │   │   ├── ggplot2-basico/
│   │   │   ├── identidade-visual-ekio/
│   │   │   └── mapas-coropleticos/
│   │   ├── econometria/
│   │   │   ├── index.qmd
│   │   │   ├── regressao-linear/
│   │   │   ├── series-temporais/
│   │   │   └── dados-painel/
│   │   └── economia-urbana/
│   │       ├── index.qmd
│   │       ├── mercado-imobiliario/
│   │       ├── financas-municipais/
│   │       └── analise-transporte/
│   │
│   ├── livros/                       # Portuguese books
│   │   ├── index.qmd
│   │   ├── r-economia-urbana/
│   │   ├── guia-dados-brasileiros/
│   │   ├── metodos-ekio/
│   │   └── econometria-cookbook/
│   │
│   └── cursos/                       # Portuguese courses
│       ├── index.qmd
│       ├── r-completo-economistas/
│       ├── analytics-urbana-avancada/
│       ├── dados-brasileiros-dominio/
│       ├── consultoria-profissional/
│       └── treinamento-corporativo/
│
# DEPLOYMENT & CONFIGURATION
├── scripts/                          # Build and deployment scripts
│   ├── build.sh                     # Local build script
│   ├── deploy.sh                    # Deployment script
│   ├── check-links.py               # Link checker
│   ├── generate-sitemap.R           # Sitemap generation
│   └── update-metadata.R            # Metadata updates
│
├── tests/                           # Testing files
│   ├── test-links.py               # Link testing
│   ├── test-r-code.R               # R code testing
│   └── test-translations.py        # Translation consistency
│
└── docs/                           # Additional documentation
    ├── contributing.md             # Contribution guidelines
    ├── content-style-guide.md      # Writing style guide
    ├── translation-guide.md        # Translation guidelines
    └── deployment.md               # Deployment documentation

# GENERATED DIRECTORIES (gitignored)
├── _site/                          # Generated site (EN)
├── _site-pt/                       # Generated site (PT)
├── .quarto/                        # Quarto cache
├── renv/                          # R environment
└── node_modules/                   # Node.js dependencies (if any)