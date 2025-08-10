    - name: Combine sites for deployment
      run: |
        mkdir -p _combined
        cp -r _site/* _combined/
        mkdir -p _combined/pt
        cp -r _site-pt/* _combined/pt/

    - name: Deploy to Netlify (Production)
      if: github.ref == 'refs/heads/main'
      uses: netlify/actions/cli@master
      with:
        args: deploy --prod --dir=_combined
      env:
        NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
        NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}

    - name: Deploy to Netlify (Preview)
      if: github.event_name == 'pull_request'
      uses: netlify/actions/cli@master
      with:
        args: deploy --dir=_combined
      env:
        NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
        NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
EOF

# Step 19: Create build scripts
cat > scripts/netlify-build.sh << 'EOF'
#!/bin/bash
# Netlify build script for EKIO Academy

set -e

echo "🚀 Starting EKIO Academy build..."

# Setup R environment
echo "📦 Setting up R environment..."
Rscript -e "
if(!require(renv)) install.packages('renv')
renv::restore()
"

# Install system dependencies for R packages
echo "🔧 Installing additional dependencies..."

# Build English version
echo "🇺🇸 Building English site..."
quarto render --profile default

# Build Portuguese version  
echo "🇧🇷 Building Portuguese site..."
quarto render --profile portuguese

# Combine sites
echo "🔗 Combining sites..."
mkdir -p _combined
cp -r _site/* _combined/

# Only copy Portuguese if it exists
if [ -d "_site-pt" ]; then
    mkdir -p _combined/pt
    cp -r _site-pt/* _combined/pt/
fi

# Copy additional assets
if [ -d "assets" ]; then
    cp -r assets _combined/
fi

# Copy robots.txt and sitemap if they exist
[ -f "robots.txt" ] && cp robots.txt _combined/
[ -f "sitemap.xml" ] && cp sitemap.xml _combined/

echo "✅ Build complete!"
EOF

chmod +x scripts/netlify-build.sh

# Step 20: Create local build script
cat > scripts/build.sh << 'EOF'
#!/bin/bash
# Local build script for EKIO Academy

echo "🏗️  Building EKIO Academy locally..."

# Check if Quarto is installed
if ! command -v quarto &> /dev/null; then
    echo "❌ Quarto is not installed. Please install from https://quarto.org"
    exit 1
fi

# Build English version
echo "🇺🇸 Building English site..."
quarto render --profile default

# Check if Portuguese content exists and build
if [ -d "pt" ] && [ "$(ls -A pt)" ]; then
    echo "🇧🇷 Building Portuguese site..."
    quarto render --profile portuguese
    
    # Combine sites
    echo "🔗 Combining sites..."
    mkdir -p _combined
    cp -r _site/* _combined/
    mkdir -p _combined/pt
    cp -r _site-pt/* _combined/pt/
else
    echo "ℹ️  Portuguese content not found, building English only"
    mkdir -p _combined
    cp -r _site/* _combined/
fi

# Copy additional assets
if [ -d "assets" ]; then
    cp -r assets _combined/ 2>/dev/null || true
fi

echo "✅ Build complete!"
echo "📁 Output in _combined/ directory"
echo "🌐 Open _combined/index.html to view locally"

# Optional: Open in browser (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    read -p "Open in browser? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open _combined/index.html
    fi
fi
EOF

chmod +x scripts/build.sh

# Step 21: Create Portuguese homepage
cat > pt/index.qmd << 'EOF'
---
title: "EKIO Academy"
subtitle: "R & Ciência de Dados para Economia e Análise Urbana"
page-layout: custom
lang: pt
---

::: {.hero-section}
::: {.container}
# Aprenda R & Ciência de Dados {.hero-title}
## para Economia & Análise Urbana {.hero-subtitle}

Domine programação em R, econometria e visualização de dados com tutoriais práticos desenvolvidos especificamente para economistas e planejadores urbanos trabalhando com dados brasileiros.

[Começar a Aprender](tutoriais/index.qmd){.btn .btn-light .btn-lg .me-3}
[Recursos Gratuitos](livros/index.qmd){.btn .btn-outline-light .btn-lg}
:::
:::

## O Que Você Encontrará Aqui

::: {.row .g-4 .my-5}
::: {.col-lg-4}
::: {.tutorial-card .h-100}
### 📚 Tutoriais
Guias passo a passo cobrindo desde o básico do R até técnicas econométricas avançadas, tudo usando dados econômicos brasileiros reais.

**Tópicos em Destaque:**
- Fundamentos do R para Economistas
- ggplot2 com Identidade Visual EKIO
- Análise de Dados Municipais Brasileiros
- Econometria do Mercado Imobiliário
- Dashboards Interativos com Shiny

[Explorar Tutoriais →](tutoriais/index.qmd){.btn .btn-ekio .mt-3}
:::
:::

::: {.col-lg-4}
::: {.tutorial-card .h-100}
### 📖 Livros
Recursos abrangentes e eBooks cobrindo tópicos especializados em economia urbana, programação em R e análise de dados brasileiros.

**Recursos Disponíveis:**
- R para Economia Urbana (eBook)
- Guia de Fontes de Dados Brasileiros
- Manual de Métodos EKIO
- Econometria com R - Livro de Receitas
- Melhores Práticas de Visualização

[Navegar pelos Livros →](livros/index.qmd){.btn .btn-ekio .mt-3}
:::
:::

::: {.col-lg-4}
::: {.tutorial-card .h-100}
### 🎓 Cursos
Trilhas de aprendizado estruturadas que te levam do iniciante ao especialista em análise econômica baseada em R e ciência de dados urbanos.

**Trilhas de Curso:**
- R Completo para Economistas
- Análise Urbana Avançada
- Dados Econômicos Brasileiros - Domínio
- Métodos de Consultoria Profissional
- Fluxo de Trabalho para Artigos

[Ver Cursos →](cursos/index.qmd){.btn .btn-ekio .mt-3}
:::
:::
:::

::: {.ekio-cta}
## Precisa de Suporte Profissional?

::: {.row}
::: {.col-md-6}
::: {.ekio-message}
### 🎯 Pronto para aplicar essas habilidades em projetos reais?
A EKIO oferece serviços de consultoria profissional para análise econômica urbana complexa
:::
:::

::: {.col-md-6}
::: {.ekio-message}
### ⚡ Qualquer que seja seu desafio de dados, a EKIO tem a solução
Desde análise de orçamento municipal até previsão do mercado imobiliário
:::
:::

::: {.col-md-6}
::: {.ekio-message}
### 👥 Quer uma experiência de aprendizado mais personalizada?
Consulte diretamente com a EKIO para treinamento e análise customizados
:::
:::

::: {.col-md-6}
::: {.ekio-message}
### 🚀 Transforme as capacidades de dados da sua organização
A EKIO oferece treinamento de equipes e parcerias institucionais
:::
:::
:::

[Descubra os Serviços Profissionais EKIO →](https://ekio.com.br){.btn .btn-light .btn-lg}
:::

## Por Que Escolher a EKIO Academy?

::: {.row .g-4 .my-5}
::: {.col-md-4 .text-center}
### 🇧🇷 Foco Brasileiro
Todos os tutoriais usam dados econômicos brasileiros reais do IBGE, BCB, IPEA e fontes municipais.
:::

::: {.col-md-4 .text-center}
### 💼 Métodos Profissionais
Aprenda as mesmas técnicas de R usadas em consultoria econômica profissional com mais de 7 anos de experiência real.
:::

::: {.col-md-4 .text-center}
### 🎯 Aplicações Práticas
Cada lição inclui exercícios práticos com projetos reais de economia urbana e análise de políticas públicas.
:::
:::

## Histórias de Sucesso dos Estudantes

::: {.row .g-4 .my-5}
::: {.col-md-4}
::: {.tutorial-card}
> "A EKIO Academy me ensinou tudo que precisava para analisar dados municipais brasileiros para minha dissertação. Os tutoriais são práticos e diretamente aplicáveis."

**Maria Rodriguez**  
Doutoranda, Economia USP
:::
:::

::: {.col-md-4}
::: {.tutorial-card}
> "Finalmente, tutoriais de R que entendem o contexto brasileiro. O curso de análise do mercado imobiliário me ajudou a fazer a transição para consultoria em ciência de dados."

**João Silva**  
Analista Econômico, Banco Central
:::
:::

::: {.col-md-4}
::: {.tutorial-card}
> "A implementação da identidade visual EKIO me poupou horas de trabalho. Meus relatórios agora parecem tão profissionais quanto os de grandes consultorias."

**Ana Ferreira**  
Planejadora Urbana, Prefeitura SP
:::
:::
:::
EOF

# Step 22: Create Portuguese tutorials index
cat > pt/tutoriais/index.qmd << 'EOF'
---
title: "Tutoriais"
subtitle: "Guias passo a passo de R para economistas"
lang: pt
---

Bem-vindos à coleção abrangente de tutoriais da EKIO Academy. Cada tutorial inclui exemplos práticos usando dados econômicos brasileiros reais e segue metodologias de consultoria profissional.

## 🔰 Fundamentos do R

Perfeito para economistas novos na programação R.

::: {.tutorial-card}
### [R Básico para Economistas](fundamentos-r/basico-r/index.qmd)
::: {.tutorial-level .beginner}
Iniciante
:::

Aprenda sintaxe R, tipos de dados e operações básicas com exemplos econômicos. Cobre variáveis, funções e configuração do ambiente R especificamente para análise econômica.

**Tópicos:** Instalação, RStudio, sintaxe básica, tipos de dados econômicos  
**Tempo estimado:** 2 horas  
**Pré-requisitos:** Nenhum
:::

::: {.tutorial-card}
### [Importação e Limpeza de Dados](fundamentos-r/importacao-dados/index.qmd)
::: {.tutorial-level .beginner}
Iniciante
:::

Domine a importação de dados econômicos brasileiros de várias fontes (IBGE, BCB, FipeZap) e técnicas de limpeza para análise.

**Tópicos:** CSV, Excel, APIs, limpeza de dados, valores ausentes  
**Tempo estimado:** 3 horas  
**Pré-requisitos:** R básico
:::

::: {.tutorial-card}
### [Trabalhando com Fontes de Dados Brasileiros](fundamentos-r/dados-brasileiros/index.qmd)
::: {.tutorial-level .intermediate}
Intermediário
:::

Navegue e utilize as principais fontes de dados brasileiros incluindo IBGE, Banco Central, IPEA e bases municipais.

**Tópicos:** API SIDRA, API BCB, pacote geobr, dados municipais  
**Tempo estimado:** 4 horas  
**Pré-requisitos:** Importação de dados básica
:::

## 📊 Visualização de Dados

Crie gráficos profissionais com a identidade visual da EKIO.

::: {.tutorial-card}
### [Essenciais do ggplot2](visualizacao-dados/ggplot2-basico/index.qmd)
::: {.tutorial-level .beginner}
Iniciante
:::

Domine a gramática dos gráficos com ggplot2, criando gráficos prontos para publicação para análise econômica.

**Tópicos:** Gramática dos gráficos, estéticas, geometrias, temas  
**Tempo estimado:** 3 horas  
**Pré-requisitos:** Fundamentos do R
:::

::: {.tutorial-card}
### [Identidade Visual EKIO no R](visualizacao-dados/identidade-visual-ekio/index.qmd)
::: {.tutorial-level .intermediate}
Intermediário
:::

Implemente o sistema completo de identidade visual da EKIO em seus gráficos R, incluindo cores, tipografia e padrões de layout.

**Tópicos:** Temas customizados, paletas de cores, fontes, branding  
**Tempo estimado:** 2 horas  
**Pré-requisitos:** ggplot2 básico
:::

{{< include ../../_includes/ekio-cta.qmd >}}
EOF

# Step 23: Create robots.txt
cat > robots.txt << 'EOF'
User-agent: *
Allow: /

# Sitemap
Sitemap: https://academy.ekio.com.br/sitemap.xml

# Crawl delay for politeness
Crawl-delay: 1

# Block crawling of admin/private areas
Disallow: /admin/
Disallow: /_includes/
Disallow: /_extensions/
Disallow: /scripts/

# Block temporary files
Disallow: /*.tmp
Disallow: /*.log
EOF

# Step 24: Create package.json for Node.js dependencies (optional)
cat > package.json << 'EOF'
{
  "name": "ekio-academy",
  "version": "1.0.0",
  "description": "EKIO Academy - R & Data Science for Economics",
  "scripts": {
    "build": "quarto render",
    "preview": "quarto preview",
    "build:css": "sass custom.scss assets/css/ekio-theme.css",
    "deploy": "netlify deploy --prod"
  },
  "keywords": ["R", "economics", "data-science", "Brazil", "urban-economics"],
  "author": "EKIO Analytics",
  "license": "MIT",
  "devDependencies": {
    "sass": "^1.69.5",
    "netlify-cli": "^17.10.1"
  }
}
EOF

# =============================================================================
# PHASE 7: TESTING AND QUALITY ASSURANCE
# =============================================================================

# Step 25: Create basic tests
mkdir -p tests

cat > tests/test-links.py << 'EOF'
#!/usr/bin/env python3
"""
Basic link checker for EKIO Academy
Tests internal links within the generated site
"""

import os
import re
from pathlib import Path

def find_broken_links(site_dir="_combined"):
    """Find broken internal links in the generated site"""
    
    if not os.path.exists(site_dir):
        print(f"❌ Site directory {site_dir} not found. Run build first.")
        return
    
    broken_links = []
    html_files = list(Path(site_dir).rglob("*.html"))
    
    print(f"🔍 Checking {len(html_files)} HTML files for broken links...")
    
    for html_file in html_files:
        try:
            with open(html_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Find all href links
            links = re.findall(r'href=["\']([^"\']+)["\']', content)
            
            for link in links:
                # Skip external links, anchors, and special protocols
                if (link.startswith('http') or 
                    link.startswith('#') or 
                    link.startswith('mailto:') or
                    link.startswith('javascript:')):
                    continue
                
                # Convert relative links to absolute paths
                if link.startswith('/'):
                    target_path = Path(site_dir) / link.lstrip('/')
                else:
                    target_path = html_file.parent / link
                
                # Remove anchor fragments
                target_path = str(target_path).split('#')[0]
                
                # Check if target exists
                if not os.path.exists(target_path):
                    # Try with .html extension
                    if not os.path.exists(target_path + '.html'):
                        # Try as directory with index.html
                        index_path = os.path.join(target_path, 'index.html')
                        if not os.path.exists(index_path):
                            broken_links.append({
                                'source': str(html_file),
                                'link': link,
                                'target': target_path
                            })
        
        except Exception as e:
            print(f"⚠️  Error checking {html_file}: {e}")
    
    if broken_links:
        print(f"\n❌ Found {len(broken_links)} broken links:")
        for broken in broken_links[:10]:  # Show first 10
            print(f"  📄 {broken['source']}")
            print(f"     ➜ {broken['link']} → {broken['target']}")
        
        if len(broken_links) > 10:
            print(f"  ... and {len(broken_links) - 10} more")
    else:
        print("✅ No broken internal links found!")
    
    return len(broken_links) == 0

if __name__ == "__main__":
    success = find_broken_links()
    exit(0 if success else 1)
EOF

chmod +x tests/test-links.py

# Step 26: Create documentation
cat > docs/getting-started.md << 'EOF'
# EKIO Academy - Getting Started Guide

## Prerequisites

Before you begin, ensure you have:

- **R** (4.3.2 or later) - Download from [CRAN](https://cran.r-project.org/)
- **RStudio** (recommended) - Download from [Posit](https://posit.co/download/rstudio-desktop/)
- **Quarto** (1.4.0 or later) - Download from [Quarto.org](https://quarto.org/docs/get-started/)
- **Git** - Download from [Git-SCM](https://git-scm.com/)

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/ekio-academy.git
   cd ekio-academy
   ```

2. **Install R dependencies:**
   ```r
   # In R console
   if (!require(renv)) install.packages("renv")
   renv::restore()
   ```

3. **Preview the site:**
   ```bash
   quarto preview
   ```

4. **Build the site:**
   ```bash
   ./scripts/build.sh
   ```

## Project Structure

```
ekio-academy/
├── _quarto.yml          # Main configuration
├── index.qmd            # Homepage
├── tutorials/           # Tutorial content
├── books/              # Book resources  
├── courses/            # Course content
├── pt/                 # Portuguese content
├── assets/             # Static assets
├── _includes/          # Reusable components
└── scripts/            # Build scripts
```

## Content Creation Workflow

### Adding a New Tutorial

1. **Create directory structure:**
   ```bash
   mkdir -p tutorials/new-topic/
   ```

2. **Create index.qmd:**
   ```yaml
   ---
   title: "Tutorial Title"
   subtitle: "Brief description"
   author: "EKIO Academy"
   date: "2024-03-15"
   categories: [tag1, tag2]
   ---
   
   ## Content here...
   ```

3. **Update navigation:**
   - Add link to `tutorials/index.qmd`
   - Update `_quarto.yml` if needed

### Bilingual Content

1. **English content** goes in root directories
2. **Portuguese content** goes in `pt/` directories
3. **Maintain parallel structure** between languages
4. **Use language switching** in navigation

## Development Best Practices

### EKIO Branding
- Always use EKIO color palette
- Include EKIO CTAs in strategic locations
- Apply professional typography standards
- Add EKIO watermarks to visualizations

### Content Quality
- Use real Brazilian economic data
- Include practical exercises
- Provide complete R code examples
- Add proper source citations

### Technical Standards
- Test all R code before publishing
- Optimize images for web
- Ensure mobile responsiveness
- Validate internal links

## Deployment

### Local Testing
```bash
# Build and test locally
./scripts/build.sh

# Check for broken links
python tests/test-links.py
```

### Production Deployment
1. **Push to GitHub main branch**
2. **GitHub Actions automatically builds**
3. **Netlify deploys to production**

## Troubleshooting

### Common Issues

**R packages not installing:**
```r
# Clear renv cache and reinstall
renv::clean()
renv::restore()
```

**Quarto render errors:**
```bash
# Clear Quarto cache
quarto render --cache-refresh
```

**Build script fails:**
```bash
# Make script executable
chmod +x scripts/build.sh
```

### Getting Help

- Check existing [documentation](../docs/)
- Review [tutorial examples](../tutorials/)
- Test with sample content first
- Validate R code in RStudio before adding to tutorials

## Contributing

1. Create feature branch: `git checkout -b feature/new-tutorial`
2. Add content following style guidelines
3. Test locally: `./scripts/build.sh`
4. Submit pull request for review

## Performance Optimization

- Optimize images: Use WebP format when possible
- Minimize R computation: Cache expensive operations
- Test mobile: Ensure responsive design
- Monitor analytics: Track user engagement
EOF

# =============================================================================
# PHASE 8: FINALIZATION AND GIT SETUP
# =============================================================================

# Step 27: Create comprehensive README
cat > README.md << 'EOF'
# 🎯 EKIO Academy

**R & Data Science for Economics and Urban Analysis**

A bilingual educational platform built with Quarto, designed to teach R programming and econometrics specifically for economists and urban planners working with Brazilian data.

[![Netlify Status](https://api.netlify.com/api/v1/badges/your-badge-id/deploy-status)](https://app.netlify.com/sites/ekio-academy/deploys)

## 🌟 Features

- **📚 Comprehensive Tutorials** - From R basics to advanced econometrics
- **📖 Free Resources** - eBooks and guides for Brazilian economic data
- **🎓 Professional Courses** - Structured learning paths with certificates
- **🇧🇷 Brazilian Focus** - Real data from IBGE, BCB, IPEA, and municipal sources
- **🌍 Bilingual** - Full content in English and Portuguese
- **💼 Professional Methods** - Based on 7+ years of consulting experience

## 🚀 Quick Start

### Prerequisites
- R (4.3.2+)
- Quarto (1.4.0+)
- Git

### Local Development
```bash
# Clone repository
git clone https://github.com/yourusername/ekio-academy.git
cd ekio-academy

# Install R dependencies
Rscript -e "renv::restore()"

# Preview site
quarto preview

# Build site
./scripts/build.sh
```

## 📁 Project Structure

```
ekio-academy/
├── 🏠 Configuration
│   ├── _quarto.yml              # Main config (English)
│   ├── _quarto-pt.yml           # Portuguese config
│   ├── custom.scss              # EKIO visual identity
│   └── netlify.toml             # Deployment config
│
├── 📚 English Content
│   ├── tutorials/               # Step-by-step guides
│   ├── books/                   # Free & premium resources
│   └── courses/                 # Structured learning
│
├── 🇧🇷 Portuguese Content (/pt/)
│   ├── tutoriais/               # Guias passo a passo
│   ├── livros/                  # Recursos gratuitos
│   └── cursos/                  # Aprendizado estruturado
│
├── 🎨 Assets & Components
│   ├── assets/                  # Images, CSS, JS
│   ├── _includes/               # Reusable components
│   └── _extensions/             # Custom Quarto extensions
│
└── 🚀 Deployment
    ├── .github/workflows/       # CI/CD pipelines
    ├── scripts/                 # Build scripts
    └── tests/                   # Quality assurance
```

## 🎨 EKIO Visual Identity

The site implements EKIO's Modern Premium visual identity:

- **Primary Color:** `#2C6BB3` (Sapphire Blue)
- **Secondary Color:** `#1abc9c` (Turquoise)
- **Typography:** Avenir font family
- **Professional Themes:** Consistent with EKIO consulting materials

## 🌍 Bilingual Implementation

### Language Structure
- **English:** Root directories (`/tutorials/`, `/books/`, `/courses/`)
- **Portuguese:** `/pt/` subdirectories (`/pt/tutoriais/`, `/pt/livros/`, `/pt/cursos/`)

### Language Switching
- Automatic browser language detection
- Flag-based language switcher
- Persistent user preferences

## 📊 Content Categories

### 📚 Tutorials
- **R Fundamentals:** Basics for economists
- **Data Visualization:** ggplot2 + EKIO themes
- **Econometrics:** Statistical analysis in R
- **Urban Economics:** Specialized applications

### 📖 Books & Resources
- **R for Urban Economics** (Free)
- **Brazilian Data Sources Guide** (Free)
- **EKIO Methods Handbook** (Premium)
- **Econometrics with R Cookbook** (Coming Soon)

### 🎓 Courses
- **Complete R for Economists** (8 weeks, R$ 497)
- **Advanced Urban Analytics** (6 weeks, R$ 697)
- **Brazilian Data Mastery** (4 weeks, R$ 397)
- **Professional Consulting Methods** (10 weeks, R$ 1,297)

## 🚀 Deployment

### Automatic Deployment (Recommended)
1. **GitHub → Netlify** integration
2. **Push to main** triggers build
3. **Automatic preview** for pull requests
4. **Custom domain:** `academy.ekio.com.br`

### Manual Deployment
```bash
# Build locally
./scripts/build.sh

# Deploy to Netlify
netlify deploy --prod --dir=_combined
```

## 🧪 Testing

```bash
# Check for broken links
python tests/test-links.py

# Validate R code
Rscript -e "source('tests/test-r-code.R')"

# Build test
./scripts/build.sh
```

## 📈 Analytics & Performance

- **Google Analytics 4** integration
- **Netlify Analytics** for technical metrics
- **Performance targets:** LCP < 2.5s, FID < 100ms
- **SEO optimization** for Brazilian economics keywords

## 🤝 Contributing

1. **Fork repository**
2. **Create feature branch:** `git checkout -b feature/new-content`
3. **Follow style guidelines** in `docs/contributing.md`
4. **Test locally:** `./scripts/build.sh`
5. **Submit pull request**

## 💼 Professional Context

EKIO Academy serves as the educational arm of [EKIO Analytics](https://ekio.com.br), providing:

- **Lead generation** for consulting services
- **Authority building** in Brazilian economics R space
- **Revenue diversification** through courses and premium content
- **Community building** around R for economics in Brazil

## 📞 Support

- **Documentation:** [docs/](docs/)
- **Issues:** [GitHub Issues](https://github.com/yourusername/ekio-academy/issues)
- **Email:** academy@ekio.com.br
- **Main Site:** [ekio.com.br](https://ekio.com.br)

## 📄 License

Content is licensed under [Creative Commons Attribution 4.0](LICENSE).  
Code is licensed under [MIT License](LICENSE-CODE).

---

**Built with ❤️ for the Brazilian economics community**

Part of the [EKIO Analytics](https://ekio.com.br) ecosystem.
EOF

# Step 28: Initial Git commit
echo "📝 Creating initial Git commit..."

git add .
git commit -m "🎯 Initial EKIO Academy setup

- Complete Quarto website structure
- Bilingual support (EN/PT)
- EKIO Modern Premium visual identity
- Sample content for tutorials, books, courses
- Automated deployment configuration
- Professional R environment setup

Ready for content migration and customization."

# =============================================================================
# SUCCESS MESSAGE AND NEXT STEPS
# =============================================================================

echo ""
echo "🎉 EKIO Academy project created successfully!"
echo ""
echo "📁 Project structure:"
echo "   • Complete bilingual Quarto website"
echo "   • EKIO Modern Premium visual identity"
echo "   • Sample content in all sections"
echo "   • Deployment-ready configuration"
echo ""
echo "🔧 What's configured:"
echo "   ✅ Quarto with bilingual support"
echo "   ✅ R environment with renv"
echo "   ✅ EKIO visual identity theme"
echo "   ✅ GitHub Actions for CI/CD"
echo "   ✅ Netlify deployment configuration"
echo "   ✅ Sample content structure"
echo ""
echo "🚀 Next steps:"
echo "   1. Customize _quarto.yml with your details"
echo "   2. Add your EKIO logo to assets/images/logos/"
echo "   3. Migrate existing content to new structure"
echo "   4. Push to GitHub and configure Netlify"
echo "   5. Set up custom domain (academy.ekio.com.br)"
echo ""
echo "📝 To preview locally:"
echo "   quarto preview"
echo ""
echo "🏗️ To build:"
echo "   ./scripts/build.sh"
echo ""
echo "🌐 To deploy:"
echo "   git push origin main## 📈 Econometrics

Statistical analysis and modeling in R.

::: {.tutorial-card}
### [Linear Regression in R](econometrics/linear-regression/index.qmd)
::: {.tutorial-level .intermediate}
Intermediate
:::

Comprehensive guide to linear regression analysis for economic data, including diagnostics and interpretation.

**Topics:** OLS, assumptions, diagnostics, interpretation  
**Estimated time:** 4 hours  
**Prerequisites:** R fundamentals, basic statistics
:::

::: {.tutorial-card}
### [Time Series Analysis](econometrics/time-series/index.qmd)
::: {.tutorial-level .advanced}
Advanced
:::

Analyze Brazilian economic time series data including inflation, GDP, and financial indicators.

**Topics:** ARIMA, seasonality, forecasting, structural breaks  
**Estimated time:** 6 hours  
**Prerequisites:** Linear regression, econometrics basics
:::

::: {.tutorial-card}
### [Panel Data Methods](econometrics/panel-data/index.qmd)
::: {.tutorial-level .advanced}
Advanced
:::

Work with panel data from Brazilian municipalities and states using fixed effects and random effects models.

**Topics:** Fixed effects, random effects, municipal panels  
**Estimated time:** 5 hours  
**Prerequisites:** Linear regression, intermediate econometrics
:::

## 🏙️ Urban Economics Applications

Specialized tutorials for urban economic analysis.

::: {.tutorial-card}
### [Housing Market Analysis](urban-economics/housing-market/index.qmd)
::: {.tutorial-level .advanced}
Advanced
:::

Complete econometric analysis of Brazilian housing markets using FipeZap and IBGE data.

**Topics:** Price indices, hedonic models, spatial analysis  
**Estimated time:** 5 hours  
**Prerequisites:** Econometrics, data visualization
:::

::: {.tutorial-card}
### [Municipal Finance Analysis](urban-economics/municipal-finance/index.qmd)
::: {.tutorial-level .advanced}
Advanced
:::

Analyze municipal budgets, debt levels, and fiscal performance across Brazilian cities.

**Topics:** FINBRA data, fiscal indicators, panel analysis  
**Estimated time:** 4 hours  
**Prerequisites:** Panel data methods
:::

{{< include _includes/ekio-cta.qmd >}}
EOF

# Step 14: Create a sample tutorial
cat > tutorials/data-visualization/ekio-visual-identity/index.qmd << 'EOF'
---
title: "EKIO Visual Identity in R"
subtitle: "Professional Data Visualization with Brand Consistency"
author: "EKIO Academy"
date: "2024-03-15"
categories: [visualization, branding, ggplot2]
image: "thumbnail.png"
---

## Overview

Learn how to implement EKIO's complete visual identity system in your R visualizations. This tutorial covers the Modern Premium theme, color scales, typography, and professional styling techniques used in actual EKIO consulting projects.

::: {.callout-tip}
## Prerequisites
- Basic ggplot2 knowledge
- R and RStudio installed
- Understanding of data visualization principles
:::

## Learning Objectives

By the end of this tutorial, you will be able to:

1. Install and configure EKIO's visual identity system
2. Apply EKIO themes to your ggplot2 charts
3. Use EKIO color scales for different data types
4. Create professional, branded visualizations
5. Export charts with consistent styling for reports and presentations

## Setup

First, let's load the required packages and set up our environment:

```{r setup}
#| message: false
#| warning: false

# Load required packages
library(tidyverse)
library(scales)
library(geobr)

# EKIO Modern Premium color palette
ekio_colors <- list(
  primary = "#2C6BB3",
  secondary = "#1abc9c",
  accent = c("#f39c12", "#e74c3c", "#9b59b6"),
  sequential = c("#f4f7fb", "#e3ecf5", "#d2e1ef", "#a0bfdb", 
                 "#6d9dc7", "#2C6BB3", "#265c9a", "#204d81", "#1a3e68"),
  categorical = c("#2C6BB3", "#1abc9c", "#f39c12", "#e74c3c", "#9b59b6")
)

# EKIO theme function
theme_ekio <- function(base_size = 12) {
  theme_minimal(base_size = base_size) +
  theme(
    text = element_text(family = "sans", color = "#2c3e50"),
    plot.title = element_text(
      size = base_size * 1.6, 
      color = ekio_colors$primary,
      margin = margin(b = 20)
    ),
    plot.subtitle = element_text(
      size = base_size * 1.1, 
      color = "#7f8c8d", 
      margin = margin(b = 25)
    ),
    plot.caption = element_text(
      size = base_size * 0.8, 
      color = "#7f8c8d",
      hjust = 0,
      margin = margin(t = 15)
    ),
    axis.title = element_text(size = base_size * 0.9, color = "#7f8c8d"),
    axis.text = element_text(size = base_size * 0.8, color = "#2c3e50"),
    panel.grid.major = element_line(color = "#e3ecf5", size = 0.5),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    plot.margin = margin(25, 25, 25, 25)
  )
}

# Set as default theme
theme_set(theme_ekio())
```

## EKIO Color System

The EKIO Modern Premium theme uses a sophisticated blue-based color palette designed for professional economic analysis:

```{r color-system}
# Display the EKIO sequential color palette
tibble(
  color = ekio_colors$sequential,
  value = 1:length(ekio_colors$sequential),
  hex = ekio_colors$sequential
) %>%
  ggplot(aes(x = value, y = 1, fill = color)) +
  geom_col(width = 1, color = "white", size = 0.5) +
  geom_text(aes(label = hex), angle = 45, hjust = 0.5, vjust = 0.5, 
            color = "white", size = 3, fontface = "bold") +
  scale_fill_identity() +
  theme_void() +
  labs(title = "EKIO Sapphire Sequential Scale",
       subtitle = "Professional color palette for economic data visualization") +
  theme(plot.title = element_text(hjust = 0.5, size = 16, color = ekio_colors$primary),
        plot.subtitle = element_text(hjust = 0.5, size = 12, color = "#7f8c8d"))
```

## Basic Chart with EKIO Theme

Let's create a simple chart using Brazilian economic data:

```{r basic-chart}
# Sample Brazilian GDP data
gdp_data <- tibble(
  year = 2015:2024,
  gdp_growth = c(-3.5, -3.3, 1.3, 1.8, 1.2, -3.9, 4.2, 2.9, 3.1, 2.8),
  region = "Brazil"
)

# Create chart with EKIO theme
gdp_chart <- gdp_data %>%
  ggplot(aes(x = year, y = gdp_growth)) +
  geom_line(size = 1.2, color = ekio_colors$primary) +
  geom_point(size = 3, color = ekio_colors$primary) +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.6) +
  scale_y_continuous(labels = percent_format(scale = 1, suffix = "%")) +
  labs(
    title = "Brazilian GDP Growth Rate",
    subtitle = "Annual percentage change in real GDP, 2015-2024",
    x = "Year",
    y = "GDP Growth Rate",
    caption = "Source: IBGE (2024) | EKIO Analytics"
  )

gdp_chart
```

## Professional Choropleth Map

Now let's create a professional choropleth map using Brazilian state data:

```{r choropleth-map}
#| fig-width: 10
#| fig-height: 8

# Load Brazilian states (using sample data for demo)
# In practice: states <- read_state(year = 2020, showProgress = FALSE)

# Sample economic data for demonstration
set.seed(123)
state_data <- tibble(
  state_code = c("11", "12", "13", "14", "15", "16", "17", "21", "22", "23", 
                 "24", "25", "26", "27", "28", "29", "31", "32", "33", "35", 
                 "41", "42", "43", "50", "51", "52", "53"),
  state_name = c("Rondônia", "Acre", "Amazonas", "Roraima", "Pará", "Amapá", 
                 "Tocantins", "Maranhão", "Piauí", "Ceará", "Rio Grande do Norte", 
                 "Paraíba", "Pernambuco", "Alagoas", "Sergipe", "Bahia", 
                 "Minas Gerais", "Espírito Santo", "Rio de Janeiro", "São Paulo", 
                 "Paraná", "Santa Catarina", "Rio Grande do Sul", "Mato Grosso do Sul", 
                 "Mato Grosso", "Goiás", "Distrito Federal"),
  gdp_index = runif(27, min = 60, max = 140)
) %>%
  mutate(
    gdp_category = case_when(
      gdp_index < 80 ~ "Low",
      gdp_index < 100 ~ "Medium-Low", 
      gdp_index < 120 ~ "Medium-High",
      TRUE ~ "High"
    )
  )

# Create a sample visualization (text-based for demo)
state_data %>%
  arrange(desc(gdp_index)) %>%
  slice_head(n = 10) %>%
  ggplot(aes(x = reorder(state_name, gdp_index), y = gdp_index, fill = gdp_category)) +
  geom_col() +
  scale_fill_manual(values = ekio_colors$categorical[1:4]) +
  coord_flip() +
  labs(
    title = "Top 10 Brazilian States by Economic Performance Index",
    subtitle = "Relative economic development indicators by state",
    x = "State",
    y = "GDP Index",
    fill = "Performance Category",
    caption = "Source: IBGE Regional Accounts | EKIO Analytics"
  )
```

## Multiple Series Chart

For categorical data, use EKIO's categorical color palette:

```{r multiple-series}
# Sample sectoral employment data
sector_data <- expand_grid(
  year = 2020:2024,
  sector = c("Agriculture", "Industry", "Services")
) %>%
  mutate(
    employment_growth = case_when(
      sector == "Agriculture" ~ c(2.1, -1.2, 3.4, 1.8, 2.3),
      sector == "Industry" ~ c(-8.7, 4.5, 2.1, 3.2, 1.9),
      sector == "Services" ~ c(-7.8, 8.2, 4.1, 2.8, 3.1)
    )
  )

# Create multi-series chart
sector_chart <- sector_data %>%
  ggplot(aes(x = year, y = employment_growth, color = sector)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  scale_color_manual(values = ekio_colors$categorical[1:3]) +
  scale_y_continuous(labels = percent_format(scale = 1, suffix = "%")) +
  labs(
    title = "Employment Growth by Economic Sector",
    subtitle = "Annual percentage change in employment, Brazil 2020-2024",
    x = "Year",
    y = "Employment Growth",
    color = "Sector",
    caption = "Source: IBGE, PNAD Contínua | EKIO Analytics"
  )

sector_chart
```

## Best Practices for EKIO Branding

::: {.callout-important}
## EKIO Visual Identity Standards

1. **Always use EKIO color palettes** for consistency across all materials
2. **Include proper source attribution** in captions with "| EKIO Analytics"
3. **Use professional typography** with appropriate font weights
4. **Maintain adequate white space** around chart elements
5. **Export at high resolution** (300 DPI) for professional presentations
:::

## Professional Export Settings

To maintain quality across different formats:

```{r export-settings}
#| eval: false

# Export settings for presentations (PowerPoint, PDF)
ggsave("gdp_chart_presentation.png", gdp_chart,
       width = 12, height = 8, dpi = 300, bg = "white")

# Export settings for reports (high-quality print)
ggsave("sector_chart_report.pdf", sector_chart,
       width = 10, height = 6, device = "pdf")

# Export for web/social media use
ggsave("chart_web.png", gdp_chart,
       width = 10, height = 6, dpi = 150, bg = "white")
```

## Next Steps

Now that you've mastered EKIO's visual identity system:

1. **Apply these techniques** to your own economic datasets
2. **Explore advanced customization** options in the [EKIO Methods Handbook](../../books/ekio-methods/index.qmd)
3. **Learn spatial analysis** in our [Brazilian Maps & Choropleth](../choropleth-maps/index.qmd) tutorial
4. **Build interactive dashboards** with our [Shiny tutorial series](../interactive-dashboards/index.qmd)

{{< include ../../../_includes/ekio-cta.qmd >}}
EOF

# Step 15: Create books index
cat > books/index.qmd << 'EOF'
---
title: "Books & Resources"
subtitle: "Comprehensive guides for R and economic analysis"
---

## 📖 Available Books

Our collection of comprehensive resources covering R programming, econometrics, and Brazilian data analysis developed from years of professional consulting experience.

::: {.row .g-4}
::: {.col-lg-6}
::: {.tutorial-card .h-100}
### [R for Urban Economics](r-urban-economics/index.qmd)
::: {.badge .bg-success .mb-3}
Free Download
:::

Complete guide to using R for urban economic analysis, covering data import, visualization, and econometric modeling with Brazilian urban data.

**What's included:**
- 250+ pages of content
- Real Brazilian datasets
- Complete R code examples
- Professional visualization templates
- Urban economic indicators

**Topics covered:**
- Urban data sources in Brazil
- Spatial analysis techniques  
- Housing market modeling
- Municipal finance analysis
- Transport economics

[Download Free →](r-urban-economics/download.qmd){.btn .btn-ekio .mt-3}
:::
:::

::: {.col-lg-6}
::: {.tutorial-card .h-100}
### [Brazilian Data Sources Guide](brazilian-data-guide/index.qmd)
::: {.badge .bg-success .mb-3}
Free Download
:::

Comprehensive reference for accessing and using Brazilian economic data sources including IBGE, BCB, IPEA, and municipal databases.

**What's included:**
- 180+ pages + R scripts
- API documentation
- Data dictionaries
- Working code examples
- Troubleshooting guides

**Data sources covered:**
- IBGE (Census, PNAD, PME)
- Banco Central APIs
- IPEA databases
- Municipal FINBRA data
- Real estate indices (FipeZap)

[Download Free →](brazilian-data-guide/download.qmd){.btn .btn-ekio .mt-3}
:::
:::

::: {.col-lg-6}
::: {.tutorial-card .h-100}
### [EKIO Methods Handbook](ekio-methods/index.qmd)
::: {.badge .bg-warning .mb-3}
Premium - R$ 197
:::

Professional methodologies used in EKIO's consulting practice, including advanced econometric techniques and visualization standards.

**What's included:**
- 320+ pages of advanced content
- Complete R package with functions
- Professional templates
- Case study examples
- Client presentation standards

**Advanced topics:**
- Causal inference methods
- Spatial econometrics
- Panel data techniques
- Professional reporting workflows
- Client presentation standards

[Purchase →](ekio-methods/purchase.qmd){.btn .btn-ekio .mt-3}
[Preview →](ekio-methods/preview.qmd){.btn .btn-outline-primary .mt-3}
:::
:::

::: {.col-lg-6}
::: {.tutorial-card .h-100}
### [Econometrics with R Cookbook](econometrics-cookbook/index.qmd)
::: {.badge .bg-info .mb-3}
Coming Soon
:::

Practical recipes for common econometric problems using R, with emphasis on Brazilian economic applications and real-world consulting scenarios.

**Planned content:**
- 280+ pages of recipes
- Step-by-step solutions
- Brazilian economic examples
- Diagnostic techniques
- Advanced modeling approaches

**Topics:**
- Model selection and validation
- Endogeneity and instrument variables
- Non-linear models and machine learning
- Forecasting and time series
- Spatial econometrics

**Release date:** May 2024  
**Pre-order price:** R$ 147

[Join Waitlist →](econometrics-cookbook/waitlist.qmd){.btn .btn-outline-primary .mt-3}
:::
:::
:::

## 🎯 Recommended Learning Paths

Choose your path based on your current experience level:

### **For Beginners (New to R):**
1. **Start here:** [R for Urban Economics](r-urban-economics/index.qmd) chapters 1-3
2. **Practice with:** [R Basics tutorial](../tutorials/r-fundamentals/r-basics/index.qmd)
3. **Apply knowledge:** [Brazilian Data Sources Guide](brazilian-data-guide/index.qmd)
4. **Build skills:** Complete [Tutorials section](../tutorials/index.qmd)

### **For Intermediate Users (Some R Experience):**
1. **Dive deeper:** [R for Urban Economics](r-urban-economics/index.qmd) chapters 4-8
2. **Master data sources:** [Brazilian Data Sources Guide](brazilian-data-guide/index.qmd) advanced sections
3. **Specialize:** Selected [advanced tutorials](../tutorials/index.qmd)
4. **Consider:** [Complete R for Economists course](../courses/complete-r-economists/index.qmd)

### **For Advanced Practitioners (Professional Work):**
1. **Professional methods:** [EKIO Methods Handbook](ekio-methods/index.qmd)
2. **Advanced techniques:** [Econometrics with R Cookbook](econometrics-cookbook/index.qmd) (when available)
3. **Structured learning:** [Professional courses](../courses/index.qmd)
4. **Consider:** Corporate training or consulting

## 📊 Why These Resources Are Different

### **Real-World Application:**
- Based on 7+ years of professional consulting experience
- Uses actual Brazilian economic data and scenarios
- Covers problems you'll encounter in practice
- Includes troubleshooting for common issues

### **Professional Quality:**
- Same methodologies used in EKIO consulting projects
- Professional visualization and reporting standards
- Client-ready templates and frameworks
- Industry best practices and standards

### **Brazilian Context:**
- Specific focus on Brazilian data sources and challenges
- Understanding of local economic conditions and data peculiarities
- Portuguese and English documentation
- Relevant examples for local economists and planners

{{< include _includes/ekio-cta.qmd >}}
EOF

# Step 16: Create courses index
cat > courses/index.qmd << 'EOF'
---
title: "Courses"
subtitle: "Structured learning paths for mastering R and economic analysis"
---

Transform your analytical capabilities with comprehensive, structured courses that take you from beginner to expert in R-based economic analysis. All courses include real Brazilian data, practical exercises, and professional methodologies used in consulting practice.

## 🎓 Available Courses

### [Complete R for Economists](complete-r-economists/index.qmd)
::: {.row}
::: {.col-md-8}
::: {.badge .bg-success .mb-3}
Most Popular
:::

**Duration:** 8 weeks | **Level:** Beginner to Intermediate | **Price:** R$ 497

Master R programming specifically for economic analysis, from basic syntax to advanced econometric modeling using Brazilian economic data.

**What you'll master:**
- R fundamentals with economic examples
- Professional data import and cleaning for Brazilian sources
- Publication-quality data visualization with EKIO identity
- Statistical analysis and hypothesis testing
- Linear and multiple regression analysis
- Time series basics and forecasting
- Professional report generation with R Markdown
- Real-world project: Complete housing market analysis

**Course structure:**
- 8 weekly modules with HD video lessons (3-4 hours each)
- Hands-on exercises using real Brazilian economic datasets
- Weekly live Q&A sessions with instructor
- Access to private student community
- Final capstone project with portfolio piece
- Certificate of completion
- Lifetime access to all materials
:::

::: {.col-md-4}
::: {.tutorial-card}
**🎯 Perfect for:**
- Economics students and professionals
- Government analysts
- Research assistants
- Career changers into data science
- Anyone working with Brazilian economic data

**💼 Career outcomes:**
- Qualify for data analyst positions
- Enhance research capabilities
- Build professional portfolio
- Prepare for advanced courses

[Enroll Now →](complete-r-economists/enroll.qmd){.btn .btn-ekio .btn-lg .mb-2}
[View Curriculum →](complete-r-economists/curriculum.qmd){.btn .btn-outline-primary}
:::
:::
:::

---

### [Advanced Urban Analytics](advanced-urban-analytics/index.qmd)
::: {.row}
::: {.col-md-8}
::: {.badge .bg-warning .mb-3}
Advanced Level
:::

**Duration:** 6 weeks | **Level:** Advanced | **Price:** R$ 697

Specialized course focusing on urban economics applications using Brazilian municipal data. Learn the advanced techniques used in professional urban consulting.

**Advanced skills you'll develop:**
- Spatial data analysis and GIS in R
- Urban economic indicator construction
- Housing market econometric modeling
- Municipal finance and budget analysis
- Transport accessibility metrics and analysis
- Urban development impact modeling
- Professional spatial visualization
- Policy impact assessment methods

**Prerequisites:** 
- Basic R knowledge or completion of "Complete R for Economists"
- Understanding of basic econometrics
- Familiarity with urban economics concepts

**Real-world projects:**
- Municipal budget efficiency analysis
- Housing affordability assessment
- Transport accessibility study
- Urban development impact evaluation
:::

::: {.col-md-4}
::: {.tutorial-card}
**🎯 Perfect for:**
- Urban planners
- Municipal government analysts
- Real estate professionals
- Transportation analysts
- Policy researchers

**💼 Career outcomes:**
- Qualify for urban planning positions
- Lead municipal analysis projects
- Consult on urban development
- Advanced research capabilities

[Enroll Now →](advanced-urban-analytics/enroll.qmd){.btn .btn-ekio .btn-lg .mb-2}
[Sample Lessons →](advanced-urban-analytics/preview.qmd){.btn .btn-outline-primary}
:::
:::
:::

---

### [Brazilian Economic Data Mastery](brazilian-data-mastery/index.qmd)
::: {.row}
::: {.col-md-8}
**Duration:** 4 weeks | **Level:** Intermediate | **Price:** R$ 397

Deep dive into Brazilian data sources and practical applications for economic research. Master every major data source used in professional analysis.

**Data mastery you'll achieve:**
- Complete IBGE data ecosystem navigation
- Banco Central API integration and automation
- IPEA and government database utilization
- Municipal and state-level data acquisition
- Data quality assessment and validation techniques
- Automated data pipeline construction
- Cross-source data integration methods
- Professional data documentation standards

**Hands-on experience with:**
- SIDRA (IBGE) advanced queries
- BCB APIs for financial data
- FINBRA municipal finance data
- Census and survey microdata
- Regional accounts and statistics
- Real estate and price indices
:::

::: {.col-md-4}
::: {.tutorial-card}
**🎯 Perfect for:**
- Research analysts
- Economic consultants
- Graduate students
- Government economists
- Data journalists

**💼 Career outcomes:**
- Become the Brazilian data expert
- Lead data acquisition projects
- Streamline research workflows
- Build automated data systems

[Enroll Now →](brazilian-data-mastery/enroll.qmd){.btn .btn-ekio .btn-lg}
:::
:::
:::

---

### [Professional Consulting Methods](professional-consulting/index.qmd)
::: {.row}
::: {.col-md-8}
::: {.badge .bg-danger .mb-3}
Premium Program
:::

**Duration:** 10 weeks | **Level:** Expert | **Price:** R$ 1,297

Learn EKIO's professional consulting methodologies and business application techniques. This is the same training EKIO consultants receive.

**Professional skills you'll master:**
- Client-ready economic analysis frameworks
- Professional presentation and communication techniques
- Business problem structuring and solution design
- Advanced econometric methods for consulting
- Project management for analytical projects
- Proposal writing and client development
- Quality assurance and review processes
- Consulting business development

**Premium program includes:**
- 4 individual 1-on-1 mentoring sessions
- Real client project case studies and simulations
- Professional toolkit and presentation templates
- Networking opportunities with EKIO consultants
- Job placement assistance and recommendations
- Access to EKIO professional development events
:::

::: {.col-md-4}
::: {.tutorial-card}
**🎯 Perfect for:**
- Experienced analysts ready to consult
- Career changers into consulting
- Economists seeking advancement
- Independent consultants
- Corporate analysts

**💼 Career outcomes:**
- Launch consulting career
- Transition to senior analyst roles
- Start independent practice
- Join consulting firms

**📋 Application required**
Limited to 20 students per cohort

[Apply Now →](professional-consulting/apply.qmd){.btn .btn-ekio .btn-lg}
:::
:::
:::

## 💼 Corporate Training

::: {.row .g-4 .my-5}
::: {.col-md-8}
### Custom Training for Teams and Organizations

We offer tailored training programs designed specifically for your organization's needs and data challenges.

**Ideal for:**
- Government agencies and ministries
- Financial institutions and banks
- Urban planning departments
- Economic research organizations
- Consulting firms building R capabilities

**Available formats:**
- **In-person workshops** (2-5 days intensive)
- **Virtual training sessions** (flexible scheduling)
- **Hybrid learning programs** (online + in-person)
- **Self-paced team licenses** (entire organization access)
- **Custom curriculum development** (your specific needs)

**Recent corporate clients:**
- Municipal planning departments
- Regional development agencies
- Economic research institutes
- Financial services firms
:::

::: {.col-md-4}
::: {.tutorial-card}
**🏢 Corporate Benefits:**
- Customized to your data and challenges
- Team building and knowledge sharing
- Immediate application to current projects
- Ongoing support and consultation
- Volume discounts available

**💬 Client testimonial:**
> "The EKIO corporate training transformed our team's analytical capabilities. We now produce professional-quality analysis internally."
> 
> **— Planning Director, Major Brazilian Municipality**

[Request Corporate Training →](corporate-training.qmd){.btn .btn-ekio .btn-lg}
:::
:::
:::

## 🎯 Choose Your Learning Path

**New to R and Economics?**  
→ Start with [Complete R for Economists](complete-r-economists/index.qmd)

**Have R basics but want to specialize?**  
→ Choose [Brazilian Economic Data Mastery](brazilian-data-mastery/index.qmd) + [Advanced Urban Analytics](advanced-urban-analytics/index.qmd)

**Ready to consult professionally?**  
→ Complete sequence ending with [Professional Consulting Methods](professional-consulting/index.qmd)

**Leading a team or organization?**  
→ Consider [Corporate Training](corporate-training.qmd) for customized solutions

## 💳 Student-Friendly Policies

- **💰 Payment plans available** for all courses (3-6 month options)
- **🔄 30-day money-back guarantee** if not completely satisfied
- **♾️ Lifetime access** to all course materials and updates
- **🧾 Brazilian tax invoices** provided (CPF/CNPJ accepted)
- **🎓 Student discounts** available with proof of enrollment (20% off)
- **👥 Group discounts** for 3+ people enrolling together (15% off)

{{< include _includes/ekio-cta.qmd >}}
EOF

# =============================================================================
# PHASE 6: DEPLOYMENT CONFIGURATION
# =============================================================================

# Step 17: Create Netlify configuration
cat > netlify.toml << 'EOF'
[build]
  command = "chmod +x scripts/netlify-build.sh && ./scripts/netlify-build.sh"
  publish = "_combined"

[build.environment]
  R_VERSION = "4.3.2"
  QUARTO_VERSION = "1.4.550"

# Language-based redirects
[[redirects]]
  from = "/"
  to = "/en/"
  status = 302
  conditions = {Language = ["en"]}

[[redirects]]
  from = "/"
  to = "/pt/"
  status = 302
  conditions = {Language = ["pt"]}

# SPA-style routing for search
[[redirects]]
  from = "/search/*"
  to = "/search/index.html"
  status = 200

# Security headers
[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-XSS-Protection = "1; mode=block"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "strict-origin-when-cross-origin"

# Cache optimization
[[headers]]
  for = "/assets/*"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"
EOF

# Step 18: Create GitHub Actions workflow
mkdir -p .github/workflows

cat > .github/workflows/deploy-netlify.yml << 'EOF'
name: Deploy to Netlify

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4
      with:
        fetch-depth: 0

    - name: Setup Quarto
      uses: quarto-dev/quarto-actions/setup@v2
      with:
        version: pre-release

    - name: Setup R
      uses: r-lib/actions/setup-r@v2
      with:
        r-version: '4.3.2'
        use-public-rspm: true

    - name: Setup renv
      uses: r-lib/actions/setup-renv@v2

    - name: Install system dependencies
      run: |
        sudo apt-get update
        sudo apt-get install -y libcurl4-openssl-dev libxml2-dev libssl-dev

    - name: Build English site
      run: quarto render --profile default
        
    - name: Build Portuguese site  
      run: quarto render --profile portuguese

    - name: Combine sites for deployment
      run: |
        mkdir -p _# EKIO Academy - ClaudeCode Implementation Plan
# Execute these steps in order to build the complete project

# =============================================================================
# PHASE 1: PROJECT SETUP
# =============================================================================

# Step 1: Create project directory and navigate
mkdir ekio-academy
cd ekio-academy

# Step 2: Initialize Git repository
git init
echo "# EKIO Academy - R & Data Science for Economics" > README.md

# Step 3: Create .gitignore
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

# Dependencies
node_modules/

# Environment
.env
.env.local
EOF

# Step 4: Create complete directory structure
echo "📁 Creating directory structure..."

# Main directories
mkdir -p assets/{images/logos,css,js,fonts,data}
mkdir -p _includes
mkdir -p _extensions/ekio-academy
mkdir -p scripts
mkdir -p tests
mkdir -p docs

# English content structure
mkdir -p tutorials/{r-fundamentals,data-visualization,econometrics,urban-economics}
mkdir -p tutorials/r-fundamentals/{r-basics,data-import,brazilian-data}
mkdir -p tutorials/data-visualization/{ggplot2-basics,ekio-visual-identity,choropleth-maps,interactive-dashboards}
mkdir -p tutorials/econometrics/{linear-regression,time-series,panel-data,causal-inference}
mkdir -p tutorials/urban-economics/{housing-market,municipal-finance,transport-analysis}

mkdir -p books/{r-urban-economics,brazilian-data-guide,ekio-methods,econometrics-cookbook}
mkdir -p books/r-urban-economics/{chapters,datasets,code,exercises}
mkdir -p books/brazilian-data-guide/{api-reference,data-dictionaries,example-scripts}
mkdir -p books/ekio-methods/{advanced-methods,consulting-frameworks}

mkdir -p courses/{complete-r-economists,advanced-urban-analytics,brazilian-data-mastery,professional-consulting}
mkdir -p courses/complete-r-economists/{modules,resources,final-project}
mkdir -p courses/advanced-urban-analytics/{modules,case-studies}

# Portuguese content structure
mkdir -p pt/{tutoriais,livros,cursos}
mkdir -p pt/tutoriais/{fundamentos-r,visualizacao-dados,econometria,economia-urbana}
mkdir -p pt/livros/{r-economia-urbana,guia-dados-brasileiros,metodos-ekio}
mkdir -p pt/cursos/{r-completo-economistas,analytics-urbana-avancada,dados-brasileiros-dominio}

echo "✅ Directory structure created"

# =============================================================================
# PHASE 2: CONFIGURATION FILES
# =============================================================================

# Step 5: Create main Quarto configuration
cat > _quarto.yml << 'EOF'
project:
  type: website
  title: "EKIO Academy"
  
profiles:
  default:
    output-dir: _site
    website:
      site-url: "https://academy.ekio.com.br"
      
  portuguese:
    output-dir: _site-pt  
    website:
      site-url: "https://academy.ekio.com.br/pt"

website:
  title: "EKIO Academy"
  description: "R & Data Science for Economics and Urban Analysis"
  
  google-analytics: "G-XXXXXXXXXX"
  
  navbar:
    logo: "assets/images/logos/ekio-academy-logo.png"
    title: false
    background: "#2C6BB3"
    foreground: white
    collapse: true
    left:
      - text: "Tutorials"
        href: tutorials/index.qmd
      - text: "Books" 
        href: books/index.qmd
      - text: "Courses"
        href: courses/index.qmd
      - text: "About"
        href: about.qmd
    right:
      - icon: "github"
        href: "https://github.com/yourusername/ekio-academy"
        aria-label: "GitHub"
      - icon: "linkedin"
        href: "https://linkedin.com/in/yourprofile"
        aria-label: "LinkedIn"
      - text: "🇺🇸/🇧🇷"
        menu:
          - text: "🇺🇸 English"
            href: "/"
          - text: "🇧🇷 Português" 
            href: "/pt/"

  search: 
    type: overlay
    placeholder: "Search tutorials, books, courses..."
    copy-button: true

  page-footer:
    background: "#2c3e50"
    foreground: white
    left: |
      © 2024 EKIO Academy. Part of [EKIO Analytics](https://ekio.com.br).
    center: |
      Professional R training for economists and urban planners.
    right: |
      [Privacy Policy](privacy.qmd) | [Terms](terms.qmd)

format:
  html:
    theme: 
      - cosmo
      - custom.scss
    toc: true
    toc-depth: 3
    number-sections: false
    smooth-scroll: true
    link-external-newwindow: true
    citations-hover: true
    footnotes-hover: true
    code-fold: false
    code-tools: true
    highlight-style: github
    css: 
      - styles.css
      - assets/css/ekio-theme.css
    include-in-header: _includes/head-custom.html
    include-after-body: _includes/analytics.html
    
execute:
  echo: true
  warning: false
  message: false
  cache: true
  freeze: auto
EOF

# Step 6: Create Portuguese configuration
cat > _quarto-pt.yml << 'EOF'
project:
  type: website
  title: "EKIO Academy"
  
website:
  title: "EKIO Academy"
  description: "R & Ciência de Dados para Economia e Análise Urbana"
  site-url: "https://academy.ekio.com.br/pt"
  
  navbar:
    logo: "assets/images/logos/ekio-academy-logo.png"
    title: false
    background: "#2C6BB3"
    foreground: white
    left:
      - text: "Tutoriais"
        href: tutoriais/index.qmd
      - text: "Livros" 
        href: livros/index.qmd
      - text: "Cursos"
        href: cursos/index.qmd
      - text: "Sobre"
        href: sobre.qmd
    right:
      - text: "🇺🇸/🇧🇷"
        menu:
          - text: "🇺🇸 English"
            href: "/"
          - text: "🇧🇷 Português" 
            href: "/pt/"

format:
  html:
    theme: 
      - cosmo
      - custom.scss
    toc: true
    css: 
      - styles.css
      - assets/css/ekio-theme.css
    lang: pt
    
execute:
  echo: true
  warning: false
  message: false
  cache: true
EOF

# Step 7: Create EKIO visual identity theme
cat > custom.scss << 'EOF'
/*-- scss:defaults --*/

// EKIO Modern Premium Colors
$primary: #2C6BB3;
$secondary: #1abc9c; 
$success: #27ae60;
$info: #3498db;
$warning: #f39c12;
$danger: #e74c3c;
$light: #f8f9fa;
$dark: #2c3e50;

// Typography
$font-family-sans-serif: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
$font-family-monospace: 'Fira Code', 'Source Code Pro', 'Monaco', monospace;

// Navbar
$navbar-bg: linear-gradient(135deg, #{$primary}, #3c7bc3);
$navbar-fg: white;

/*-- scss:rules --*/

// Custom EKIO styling
.navbar-brand {
  font-weight: 300;
  letter-spacing: 2px;
}

.hero-section {
  background: linear-gradient(135deg, #{$primary}, #{$secondary});
  color: white;
  padding: 6rem 0;
  text-align: center;
  margin-bottom: 3rem;
  border-radius: 0 0 2rem 2rem;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 300;
  margin-bottom: 1rem;
  letter-spacing: 2px;
}

.hero-subtitle {
  font-size: 1.4rem;
  opacity: 0.95;
  margin-bottom: 2rem;
  font-weight: 300;
}

.ekio-cta {
  background: linear-gradient(135deg, #{$secondary}, #16a085);
  color: white;
  padding: 4rem 2rem;
  text-align: center;
  border-radius: 12px;
  margin: 3rem 0;
  position: relative;
  overflow: hidden;
}

.ekio-cta::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="white" opacity="0.1"/></svg>');
}

.ekio-message {
  background: rgba(255,255,255,0.15);
  padding: 2rem;
  border-radius: 12px;
  margin-bottom: 1.5rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255,255,255,0.2);
  position: relative;
  z-index: 1;
}

.btn-ekio {
  background: #{$primary};
  color: white;
  border: none;
  padding: 0.8rem 2rem;
  border-radius: 6px;
  font-weight: 500;
  transition: all 0.3s ease;
  text-decoration: none;
  display: inline-block;
}

.btn-ekio:hover {
  background: darken($primary, 10%);
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(0,0,0,0.2);
  color: white;
  text-decoration: none;
}

// Tutorial cards
.tutorial-card {
  background: white;
  border: 1px solid #e3ecf5;
  border-radius: 8px;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
  transition: all 0.3s ease;
}

.tutorial-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.tutorial-level {
  background: #e3ecf5;
  color: #{$primary};
  padding: 0.3rem 0.8rem;
  border-radius: 15px;
  font-size: 0.8rem;
  font-weight: 500;
  display: inline-block;
}

.tutorial-level.beginner {
  background: #d4edda;
  color: #155724;
}

.tutorial-level.intermediate {
  background: #fff3cd;
  color: #856404;
}

.tutorial-level.advanced {
  background: #f8d7da;
  color: #721c24;
}

// Language toggle
.language-toggle {
  position: fixed;
  top: 20px;
  right: 20px;
  z-index: 1000;
  display: flex;
  gap: 0.5rem;
}

.lang-flag {
  width: 30px;
  height: 20px;
  border-radius: 3px;
  cursor: pointer;
  transition: all 0.3s;
  border: 2px solid white;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.lang-flag:hover {
  transform: scale(1.1);
}

.lang-flag.br {
  background: linear-gradient(to bottom, #009c3b 33%, #ffdf00 33%, #ffdf00 66%, #009c3b 66%);
}

.lang-flag.us {
  background: linear-gradient(to bottom, #b22234 46%, white 46%, white 54%, #b22234 54%);
  position: relative;
}

.lang-flag.us::before {
  content: '';
  position: absolute;
  width: 40%;
  height: 46%;
  background: #3c3b6e;
  top: 0;
  left: 0;
}
EOF

# Step 8: Create additional styles
cat > styles.css << 'EOF'
/* EKIO Academy Additional Styles */

/* Language content management */
.lang-content {
  display: block;
}

.lang-content.hidden {
  display: none !important;
}

/* Brazilian data highlighting */
.brazil-highlight {
  background: linear-gradient(135deg, #009c3b, #ffdf00);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 600;
}

/* Code output styling */
.cell-output-display {
  margin: 1rem 0;
  padding: 1rem;
  background: #f8f9fa;
  border: 1px solid #e3ecf5;
  border-radius: 6px;
}

/* EKIO watermark */
.ekio-watermark {
  font-family: 'Avenir', sans-serif;
  font-weight: 300;
  letter-spacing: 2px;
  color: rgba(44, 107, 179, 0.3);
  font-size: 0.8rem;
  position: absolute;
  bottom: 10px;
  right: 15px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .language-toggle {
    position: relative;
    top: auto;
    right: auto;
    margin: 1rem 0;
  }
  
  .ekio-cta {
    padding: 2rem 1rem;
  }
}
EOF

# =============================================================================
# PHASE 3: R ENVIRONMENT SETUP
# =============================================================================

# Step 9: Create R profile
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

# Set default options for better output
options(
  digits = 4,
  scipen = 999,
  width = 80,
  pillar.subtle = FALSE,
  pillar.neg = FALSE
)

# Load common packages for tutorials
if (interactive()) {
  suppressMessages({
    library(tidyverse)
    library(scales)
  })
  
  cat("🎯 EKIO Academy R Environment Loaded\n")
  cat("📦 Packages ready: tidyverse, scales\n")
  cat("🎨 EKIO theme available via source('assets/r/ekio-theme.R')\n")
}
EOF

# Step 10: Initialize renv (R package management)
echo "📦 Setting up R environment..."
# Note: This requires R to be installed
# Rscript -e "if (!require(renv, quietly = TRUE)) install.packages('renv'); renv::init(bare = TRUE)"

# Create renv.lock template for required packages
cat > renv.lock << 'EOF'
{
  "R": {
    "Version": "4.3.2",
    "Repositories": [
      {
        "Name": "CRAN",
        "URL": "https://cran.rstudio.com"
      }
    ]
  },
  "Packages": {
    "tidyverse": {
      "Package": "tidyverse",
      "Version": "2.0.0",
      "Source": "Repository",
      "Repository": "CRAN"
    },
    "ggplot2": {
      "Package": "ggplot2", 
      "Version": "3.4.4",
      "Source": "Repository",
      "Repository": "CRAN"
    },
    "scales": {
      "Package": "scales",
      "Version": "1.3.0",
      "Source": "Repository", 
      "Repository": "CRAN"
    },
    "extrafont": {
      "Package": "extrafont",
      "Version": "0.19",
      "Source": "Repository",
      "Repository": "CRAN"
    },
    "geobr": {
      "Package": "geobr",
      "Version": "1.7.0",
      "Source": "Repository",
      "Repository": "CRAN"
    },
    "sf": {
      "Package": "sf",
      "Version": "1.0-14",
      "Source": "Repository",
      "Repository": "CRAN"
    },
    "DT": {
      "Package": "DT",
      "Version": "0.30",
      "Source": "Repository",
      "Repository": "CRAN"
    },
    "plotly": {
      "Package": "plotly",
      "Version": "4.10.4",
      "Source": "Repository",
      "Repository": "CRAN"
    },
    "shiny": {
      "Package": "shiny",
      "Version": "1.8.0",
      "Source": "Repository",
      "Repository": "CRAN"
    }
  }
}
EOF

# =============================================================================
# PHASE 4: INCLUDES AND COMPONENTS
# =============================================================================

# Step 11: Create reusable includes
mkdir -p _includes

cat > _includes/head-custom.html << 'EOF'
<!-- EKIO Academy Custom Head Elements -->
<meta name="author" content="EKIO Analytics">
<meta name="keywords" content="R programming, economics, econometrics, Brazil, urban economics, data science">
<meta property="og:type" content="website">
<meta property="og:site_name" content="EKIO Academy">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:site" content="@ekio_analytics">

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="/assets/images/logos/favicon.ico">
<link rel="apple-touch-icon" sizes="180x180" href="/assets/images/logos/apple-touch-icon.png">

<!-- Language detection script -->
<script>
  // Auto-detect browser language on first visit
  document.addEventListener('DOMContentLoaded', function() {
    const hasVisited = localStorage.getItem('ekio-academy-visited');
    
    if (!hasVisited) {
      const browserLang = navigator.language.slice(0, 2);
      if (browserLang === 'pt' && !window.location.pathname.startsWith('/pt/')) {
        window.location.href = '/pt/';
      }
      localStorage.setItem('ekio-academy-visited', 'true');
    }
  });
</script>
EOF

cat > _includes/analytics.html << 'EOF'
<!-- EKIO Academy Analytics -->
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>

<!-- Hotjar Tracking (optional) -->
<script>
    (function(h,o,t,j,a,r){
        h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
        h._hjSettings={hjid:XXXXXX,hjsv:6};
        a=o.getElementsByTagName('head')[0];
        r=o.createElement('script');r.async=1;
        r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
        a.appendChild(r);
    })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');
</script>
EOF

cat > _includes/ekio-cta.qmd << 'EOF'
::: {.ekio-cta}
## Need Professional Support?

::: {.row}
::: {.col-md-6}
::: {.ekio-message}
### 🎯 Ready to apply these skills to real projects?
EKIO provides professional consulting services for complex urban economic analysis
:::
:::

::: {.col-md-6}
::: {.ekio-message}
### ⚡ Whatever your data challenge, EKIO has the solution
From municipal budget analysis to housing market forecasting
:::
:::

::: {.col-md-6}
::: {.ekio-message}
### 👥 Want a more personalized learning experience?
Consult directly with EKIO for custom training and analysis
:::
:::

::: {.col-md-6}
::: {.ekio-message}
### 🚀 Transform your organization's data capabilities
EKIO offers team training and institutional partnerships
:::
:::
:::

[Discover EKIO Professional Services →](https://ekio.com.br){.btn .btn-ekio .btn-lg}
:::
EOF

# =============================================================================
# PHASE 5: CORE CONTENT CREATION
# =============================================================================

# Step 12: Create homepage (English)
cat > index.qmd << 'EOF'
---
title: "EKIO Academy"
subtitle: "R & Data Science for Economics and Urban Analysis"
page-layout: custom
---

::: {.hero-section}
::: {.container}
# Learn R & Data Science {.hero-title}
## for Economics & Urban Analysis {.hero-subtitle}

Master R programming, econometrics, and data visualization with practical tutorials designed specifically for economists and urban planners working with Brazilian data.

[Start Learning](tutorials/index.qmd){.btn .btn-light .btn-lg .me-3}
[Free Resources](books/index.qmd){.btn .btn-outline-light .btn-lg}
:::
:::

## What You'll Find Here

::: {.row .g-4 .my-5}
::: {.col-lg-4}
::: {.tutorial-card .h-100}
### 📚 Tutorials
Step-by-step guides covering everything from R basics to advanced econometric techniques, all using real Brazilian economic data.

**Featured Topics:**
- R Fundamentals for Economists  
- ggplot2 with EKIO Visual Identity
- Brazilian Municipal Data Analysis
- Housing Market Econometrics
- Interactive Dashboards with Shiny

[Explore Tutorials →](tutorials/index.qmd){.btn .btn-ekio .mt-3}
:::
:::

::: {.col-lg-4}
::: {.tutorial-card .h-100}
### 📖 Books
Comprehensive resources and eBooks covering specialized topics in urban economics, R programming, and Brazilian data analysis.

**Available Resources:**
- R for Urban Economics (eBook)
- Brazilian Data Sources Guide  
- EKIO Methods Handbook
- Econometrics with R Cookbook
- Data Visualization Best Practices

[Browse Books →](books/index.qmd){.btn .btn-ekio .mt-3}
:::
:::

::: {.col-lg-4}
::: {.tutorial-card .h-100}
### 🎓 Courses
Structured learning paths taking you from beginner to expert in R-based economic analysis and urban data science.

**Course Tracks:**
- Complete R for Economists
- Advanced Urban Analytics
- Brazilian Economic Data Mastery
- Professional Consulting Methods
- Research Paper Workflow

[View Courses →](courses/index.qmd){.btn .btn-ekio .mt-3}
:::
:::
:::

{{< include _includes/ekio-cta.qmd >}}

## Why Choose EKIO Academy?

::: {.row .g-4 .my-5}
::: {.col-md-4 .text-center}
### 🇧🇷 Brazilian Focus
All tutorials use real Brazilian economic data from IBGE, BCB, IPEA, and municipal sources.
:::

::: {.col-md-4 .text-center}
### 💼 Professional Methods  
Learn the same R techniques used in professional economic consulting with 7+ years of real-world experience.
:::

::: {.col-md-4 .text-center}
### 🎯 Practical Applications
Every lesson includes hands-on exercises with actual urban economics and policy analysis projects.
:::
:::

## Student Success Stories

::: {.row .g-4 .my-5}
::: {.col-md-4}
::: {.tutorial-card}
> "EKIO Academy taught me everything I needed to analyze Brazilian municipal data for my dissertation. The tutorials are practical and directly applicable."

**Maria Rodriguez**  
PhD Student, USP Economics
:::
:::

::: {.col-md-4}
::: {.tutorial-card}
> "Finally, R tutorials that understand the Brazilian context. The housing market analysis course helped me transition into data science consulting."

**João Silva**  
Economic Analyst, Banco Central
:::
:::

::: {.col-md-4}
::: {.tutorial-card}
> "The EKIO visual identity implementation saved me hours of work. My reports now look as professional as major consulting firms."

**Ana Ferreira**  
Urban Planner, Prefeitura SP
:::
:::
:::
EOF

# Step 13: Create tutorials index
cat > tutorials/index.qmd << 'EOF'
---
title: "Tutorials"
subtitle: "Step-by-step R guides for economists"
---

Welcome to EKIO Academy's comprehensive tutorial collection. Each tutorial includes practical examples using real Brazilian economic data and follows professional consulting methodologies.

## 🔰 R Fundamentals

Perfect for economists new to R programming.

::: {.tutorial-card}
### [R Basics for Economists](r-fundamentals/r-basics/index.qmd)
::: {.tutorial-level .beginner}
Beginner
:::

Learn R syntax, data types, and basic operations with economic examples. Covers variables, functions, and the R environment setup specifically for economic analysis.

**Topics:** Installation, RStudio, basic syntax, economic data types  
**Estimated time:** 2 hours  
**Prerequisites:** None
:::

::: {.tutorial-card}
### [Data Import & Cleaning](r-fundamentals/data-import/index.qmd)
::: {.tutorial-level .beginner}
Beginner
:::

Master importing Brazilian economic data from various sources (IBGE, BCB, FipeZap) and cleaning techniques for analysis.

**Topics:** CSV, Excel, APIs, data cleaning, missing values  
**Estimated time:** 3 hours  
**Prerequisites:** R basics
:::

::: {.tutorial-card}
### [Working with Brazilian Data Sources](r-fundamentals/brazilian-data/index.qmd)
::: {.tutorial-level .intermediate}
Intermediate
:::

Navigate and utilize major Brazilian data sources including IBGE, Banco Central, IPEA, and municipal databases.

**Topics:** SIDRA API, BCB API, geobr package, municipal data  
**Estimated time:** 4 hours  
**Prerequisites:** Data import basics
:::

## 📊 Data Visualization

Create professional charts with EKIO's visual identity.

::: {.tutorial-card}
### [ggplot2 Essentials](data-visualization/ggplot2-basics/index.qmd)
::: {.tutorial-level .beginner}
Beginner
:::

Master the grammar of graphics with ggplot2, creating publication-ready charts for economic analysis.

**Topics:** Grammar of graphics, aesthetics, geometries, themes  
**Estimated time:** 3 hours  
**Prerequisites:** R fundamentals
:::

::: {.tutorial-card}
### [EKIO Visual Identity in R](data-visualization/ekio-visual-identity/index.qmd)
::: {.tutorial-level .intermediate}
Intermediate
:::

Implement EKIO's complete visual identity system in your R plots, including colors, typography, and layout standards.

**Topics:** Custom themes, color palettes, fonts, branding  
**Estimated time:** 2 hours  
**Prerequisites:** ggplot2 basics
:::

::: {.tutorial-card}
### [Brazilian Maps & Choropleth](data-visualization/choropleth-maps/index.qmd)
::: {.tutorial-level .advanced}
Advanced
:::

Create professional choropleth maps of Brazilian states and municipalities using economic indicators.

**Topics:** geobr, sf package, spatial joins, map projections  
**Estimated time:** 4 hours  
**Prerequisites:** ggplot2, data visualization
:::

## 📈 Econometrics

Statistical analysis and modeling in R.