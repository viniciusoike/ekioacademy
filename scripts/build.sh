#!/bin/bash

# EKIO Academy Build Script
# Builds both English and Portuguese versions and combines them

set -e

echo "🎓 Building EKIO Academy..."
echo "════════════════════════════════════════"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf _site _site-pt _combined

# Build CSS assets
echo "🎨 Building CSS themes..."
if command -v sass &> /dev/null; then
    sass custom.scss assets/css/ekio-theme.css --style compressed
else
    echo "⚠️  Sass not found. Skipping CSS compilation."
fi

# Build English version
echo "🇺🇸 Building English version..."
quarto render --profile default

# Build Portuguese version  
echo "🇧🇷 Building Portuguese version..."
quarto render --profile portuguese

# Combine builds
echo "🔄 Combining bilingual builds..."
mkdir -p _combined

# Copy English site to root
cp -r _site/* _combined/

# Copy Portuguese site to /pt subdirectory
mkdir -p _combined/pt
cp -r _site-pt/* _combined/pt/

# Create language switching redirects
echo "🔗 Setting up language redirects..."

# Copy assets to both locations
cp -r assets _combined/assets
cp -r assets _combined/pt/assets

# Generate sitemap
echo "🗺️  Generating sitemap..."
cat > _combined/sitemap.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://academy.ekio.com.br/</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://academy.ekio.com.br/pt/</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://academy.ekio.com.br/tutorials/</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://academy.ekio.com.br/pt/tutoriais/</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://academy.ekio.com.br/courses/</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>https://academy.ekio.com.br/pt/cursos/</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
</urlset>
EOF

# Generate robots.txt
echo "🤖 Generating robots.txt..."
cat > _combined/robots.txt << EOF
User-agent: *
Allow: /

# Sitemaps
Sitemap: https://academy.ekio.com.br/sitemap.xml

# Block development/admin paths
Disallow: /admin/
Disallow: /_site/
Disallow: /_site-pt/
Disallow: /.quarto/
EOF

echo "✅ Build completed successfully!"
echo "📁 Combined site available in: _combined/"
echo "🚀 Ready for deployment to Netlify"