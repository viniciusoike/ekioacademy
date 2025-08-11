# EKIO Academy Deployment Guide

This guide covers all steps needed to deploy EKIO Academy from development to production.

## 🚀 Quick Deployment (Recommended)

### Prerequisites
- GitHub account
- Netlify account (free tier available)
- Domain name: `academy.ekio.com.br`

### Step 1: Push to GitHub Repository

```bash
# Create GitHub repository (if not already done)
# Go to github.com and create a new repository named 'ekio-academy'

# Add remote and push
git remote add origin https://github.com/YOUR_USERNAME/ekio-academy.git
git push -u origin main
```

### Step 2: Deploy to Netlify

1. **Connect to Netlify:**
   - Go to [netlify.com](https://netlify.com) and sign in
   - Click "Add new site" → "Import an existing project"
   - Choose "GitHub" and authorize Netlify
   - Select your `ekio-academy` repository

2. **Configure Build Settings:**
   ```
   Build command: npm run build
   Publish directory: _combined
   ```

3. **Set Environment Variables:**
   - Go to Site settings → Environment variables
   - Add any required environment variables (if applicable)

4. **Deploy:**
   - Click "Deploy site"
   - Netlify will automatically build and deploy your site

### Step 3: Configure Custom Domain

1. **In Netlify Dashboard:**
   - Go to Site settings → Domain management
   - Click "Add custom domain"
   - Enter: `academy.ekio.com.br`
   - Netlify will provide DNS instructions

2. **Configure DNS (at your domain provider):**
   ```
   Type: CNAME
   Name: academy
   Value: your-site-name.netlify.app
   ```

3. **Enable HTTPS:**
   - Netlify will automatically provision SSL certificate
   - Force HTTPS redirect will be enabled

## 🔧 Detailed Manual Deployment

### Local Development Setup

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/ekio-academy.git
cd ekio-academy

# Install Node.js dependencies
npm install

# Install R packages (run in R console)
install.packages(c("tidyverse", "ggplot2", "scales", "DT", "plotly", 
                   "sf", "geobr", "sidrar", "GetBCBData", "cli"))

# Install Quarto
# Download from: https://quarto.org/docs/get-started/

# Build site locally
npm run build

# Preview site locally
npm run preview
```

### Alternative Deployment Options

#### Option 1: GitHub Pages

```bash
# Install Quarto GitHub Pages extension
quarto install extension quarto-ext/github-pages

# Configure for GitHub Pages
# Add to _quarto.yml:
# project:
#   type: website
#   output-dir: docs

# Deploy to GitHub Pages
quarto publish gh-pages
```

#### Option 2: Vercel

1. **Connect to Vercel:**
   - Go to [vercel.com](https://vercel.com)
   - Import your GitHub repository
   - Configure build settings:
     ```
     Build Command: npm run build
     Output Directory: _combined
     ```

#### Option 3: Self-Hosted (VPS/Server)

```bash
# On your server
sudo apt update
sudo apt install nginx nodejs npm r-base

# Clone and build
git clone https://github.com/YOUR_USERNAME/ekio-academy.git
cd ekio-academy
npm install
npm run build

# Configure Nginx
sudo cp deployment/nginx.conf /etc/nginx/sites-available/ekio-academy
sudo ln -s /etc/nginx/sites-available/ekio-academy /etc/nginx/sites-enabled/
sudo systemctl reload nginx
```

## ⚙️ Configuration Updates Needed

### 1. Update Google Analytics

Edit `_includes/head-custom.html` and `_includes/analytics.html`:

```html
<!-- Replace G-XXXXXXXXXX with your actual GA4 measurement ID -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-YOUR_ACTUAL_ID"></script>
```

### 2. Update Site URLs

Edit `_quarto.yml` and `_quarto-pt.yml`:

```yaml
website:
  site-url: "https://academy.ekio.com.br"  # Your actual domain
```

### 3. Configure GitHub Actions Secrets

If using GitHub Actions deployment, add these secrets in your GitHub repository:

- `NETLIFY_AUTH_TOKEN`: Your Netlify personal access token
- `NETLIFY_SITE_ID`: Your Netlify site ID

### 4. Update README Badge URLs

Edit `README.md`:

```markdown
[![Deploy Status](https://api.netlify.com/api/v1/badges/YOUR_SITE_ID/deploy-status)](https://app.netlify.com/sites/YOUR_SITE_NAME/deploys)
```

## 🔍 Testing Before Production

### Local Testing Checklist

```bash
# Test English site
quarto preview

# Test Portuguese site
quarto preview --profile portuguese

# Test build process
npm run build

# Check for broken links
npm run test:links

# Test R code execution
npm run test:r-code
```

### Manual Testing Checklist

- [ ] Homepage loads correctly (EN/PT)
- [ ] All navigation links work
- [ ] Tutorial pages display properly
- [ ] Blog posts render with correct formatting
- [ ] R code blocks execute without errors
- [ ] Language switching functions
- [ ] Mobile responsiveness works
- [ ] Forms submit correctly
- [ ] Analytics tracking works
- [ ] Site search functions
- [ ] RSS feeds generate properly

## 📊 Post-Deployment Setup

### 1. Google Analytics Configuration

1. **Create GA4 Property:**
   - Go to [analytics.google.com](https://analytics.google.com)
   - Create new property for `academy.ekio.com.br`
   - Note your Measurement ID (G-XXXXXXXXXX)

2. **Update Site Code:**
   ```bash
   # Replace placeholder IDs with real measurement ID
   find . -name "*.html" -exec sed -i 's/G-XXXXXXXXXX/G-YOUR_REAL_ID/g' {} +
   git add . && git commit -m "Update Google Analytics measurement ID"
   git push
   ```

### 2. Google Search Console

1. **Add Property:**
   - Go to [search.google.com/search-console](https://search.google.com/search-console)
   - Add `academy.ekio.com.br` as property
   - Verify ownership via HTML tag or DNS

2. **Submit Sitemap:**
   - Submit `https://academy.ekio.com.br/sitemap.xml`
   - Monitor indexing status

### 3. Content Optimization

```bash
# Optimize images for web delivery
npm run optimize:images

# Generate additional sitemaps if needed
npm run generate:sitemap

# Test site performance
npm run analyze
```

## 🔧 Maintenance and Updates

### Regular Updates

```bash
# Update dependencies monthly
npm update

# Update R packages quarterly
# In R console:
update.packages()

# Update Quarto as needed
# Download latest from quarto.org
```

### Content Updates

```bash
# Add new blog post
# Create file: blog/posts/YYYY-MM-DD-title.qmd
# Build and deploy
npm run build
git add . && git commit -m "Add new blog post: [title]"
git push
```

### Monitoring

1. **Site Performance:**
   - Google PageSpeed Insights
   - Lighthouse audits
   - Core Web Vitals monitoring

2. **Analytics:**
   - Monthly traffic reports
   - Course enrollment tracking
   - Blog engagement metrics

3. **Technical Health:**
   - Broken link checking
   - SSL certificate renewal (automatic with Netlify)
   - Dependency security updates

## 🆘 Troubleshooting

### Common Issues

**Build Failures:**
```bash
# Clear cache and rebuild
rm -rf .quarto _site _site-pt _combined
npm run clean
npm run build
```

**R Code Execution Errors:**
```bash
# Check R package installations
Rscript -e "source('.Rprofile')"

# Update R packages
Rscript -e "update.packages(ask = FALSE)"
```

**Deployment Issues:**
```bash
# Check build logs in Netlify dashboard
# Verify environment variables
# Check DNS configuration
```

### Support Resources

- **Quarto Documentation:** [quarto.org/docs](https://quarto.org/docs)
- **Netlify Support:** [docs.netlify.com](https://docs.netlify.com)
- **R Package Issues:** Check individual package documentation
- **GitHub Actions:** [docs.github.com/actions](https://docs.github.com/en/actions)

## 🎯 Performance Optimization

### After Deployment

1. **Enable Compression:**
   - Netlify automatically enables gzip compression
   - Verify in browser dev tools

2. **Configure Caching:**
   - Headers already configured in `netlify.toml`
   - Monitor cache hit rates

3. **Image Optimization:**
   ```bash
   # Convert images to WebP format
   npm run optimize:images
   
   # Compress existing images
   # Use tools like ImageOptim, TinyPNG, or automated solutions
   ```

4. **Performance Monitoring:**
   - Set up PageSpeed Insights monitoring
   - Monitor Core Web Vitals
   - Track load times for Brazilian users

## 🔐 Security Considerations

### Production Security

1. **HTTPS Enforcement:**
   - Enabled automatically with Netlify
   - Verify all resources load over HTTPS

2. **Security Headers:**
   - Configured in `netlify.toml`
   - Test with securityheaders.com

3. **Regular Updates:**
   - Keep dependencies updated
   - Monitor security advisories
   - Update R packages regularly

---

## ✅ Deployment Checklist

### Pre-Deployment
- [ ] All code committed and pushed to GitHub
- [ ] Local build test successful
- [ ] All R code executes without errors
- [ ] Responsive design tested
- [ ] Content reviewed and proofread

### Deployment
- [ ] GitHub repository created and pushed
- [ ] Netlify site connected and deployed
- [ ] Custom domain configured
- [ ] SSL certificate active
- [ ] DNS settings updated

### Post-Deployment
- [ ] Google Analytics configured
- [ ] Search Console property added
- [ ] Site performance tested
- [ ] All forms and functionality tested
- [ ] Analytics tracking verified
- [ ] Team members notified of launch

🚀 **Your EKIO Academy is ready for production!**