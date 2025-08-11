#!/bin/bash

# EKIO Academy Build Script  
# Builds both English and Portuguese versions for Netlify deployment

set -e

echo "🎓 Building EKIO Academy..."
echo "════════════════════════════════════════"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Install Quarto if not available
if ! command -v quarto &> /dev/null; then
    echo "📥 Installing Quarto..."
    curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.550/quarto-1.4.550-linux-amd64.tar.gz
    tar -xzf quarto-1.4.550-linux-amd64.tar.gz
    sudo mkdir -p /opt/quarto
    sudo cp -r quarto-1.4.550/* /opt/quarto/
    sudo ln -sf /opt/quarto/bin/quarto /usr/local/bin/quarto
    quarto --version
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf _site _site-pt

# Build CSS assets
echo "🎨 Building CSS themes..."
npm run build:css

# Build the site
echo "🚀 Building site..."
quarto render

echo "✅ Build completed successfully!"
echo "📁 Site available in: _site/"
echo "🌍 Ready for deployment to ekio.io"