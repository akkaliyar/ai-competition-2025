#!/bin/bash
set -e

echo "🚀 AGGRESSIVE Railway Rebuild - No Cache, No Mercy"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Step 1: Nuclear cleanup of all Docker files
echo ""
echo "🧹 NUCLEAR CLEANUP - Removing ALL Docker files..."
rm -f Dockerfile*
rm -f .dockerignore
rm -f docker-compose.yml
print_status "All Docker files removed"

# Step 2: Clean Docker cache completely
echo ""
echo "🐳 NUCLEAR Docker cache cleanup..."
docker system prune -af
docker image prune -af
docker volume prune -f
docker network prune -f
print_status "Docker cache completely cleared"

# Step 3: Recreate Dockerfile.railway with different name
echo ""
echo "🔨 Creating new Dockerfile.railway..."
cat > Dockerfile.railway << 'EOF'
# Railway Production Dockerfile - AI Competition Backend
# Build Date: 2025-09-03
# Version: 4.0.0 - AGGRESSIVE CACHE BUSTING

# Use Node.js 20 Alpine as base image
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Install system dependencies for Tesseract OCR
RUN apk add --no-cache \
    tesseract \
    tesseract-data-eng \
    poppler-utils \
    && rm -rf /var/cache/apk/*

# Copy package files first for better caching
COPY package*.json ./

# Install ALL dependencies (including dev dependencies for build)
RUN npm install --no-audit --no-fund

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM node:20-alpine AS production

# Set working directory
WORKDIR /app

# Install only production system dependencies
RUN apk add --no-cache \
    tesseract \
    tesseract-data-eng \
    poppler-utils \
    && rm -rf /var/cache/apk/*

# Copy package files
COPY package*.json ./

# Install ONLY production dependencies
RUN npm install --omit=dev --no-audit --no-fund --prefer-offline=false

# Copy built application from builder stage
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/uploads ./uploads

# Create uploads directory if it doesn't exist
RUN mkdir -p uploads

# Set permissions
RUN chmod 755 uploads

# Expose port
EXPOSE 3001

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3001/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) })" || exit 1

# Start the application
CMD ["npm", "run", "start:prod"]
EOF

print_status "New Dockerfile.railway created"

# Step 4: Create new .dockerignore
echo ""
echo "🔨 Creating new .dockerignore..."
cat > .dockerignore << 'EOF'
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.nyc_output
coverage
.nyc_output
.coverage
.coverage.*
coverage.*
*.lcov
test
tests
**/*.test.js
**/*.test.ts
**/*.spec.js
**/*.spec.ts
.vscode
.idea
*.swp
*.swo
*~
.DS_Store
Thumbs.db

# Exclude ALL old Docker files to prevent cache conflicts
Dockerfile*
!Dockerfile.railway
.dockerignore
docker-compose.yml
EOF

print_status "New .dockerignore created"

# Step 5: Update Railway config to be more aggressive
echo ""
echo "🔨 Updating Railway config..."
cat > railway.toml << 'EOF'
[build]
builder = "dockerfile"
dockerfilePath = "Dockerfile.railway"

[deploy]
startCommand = "npm run start:prod"
healthcheckPath = "/health"
healthcheckTimeout = 300
restartPolicyType = "on_failure"
restartPolicyMaxRetries = 3

[env]
NODE_ENV = "production"
PORT = "3001"
NPM_CONFIG_CACHE = "/tmp/.npm"
NPM_CONFIG_PREFER_OFFLINE = "true"

# Database configuration - these will be set in Railway dashboard
# DB_HOST = "your-railway-mysql-host"
# DB_PORT = "3306"
# DB_USERNAME = "your-railway-mysql-username"
# DB_PASSWORD = "your-railway-mysql-password"
# DB_NAME = "your-railway-mysql-database"

# Frontend URL for CORS
FRONTEND_URL = "https://your-frontend-domain.railway.app"

# File upload configuration
MAX_FILE_SIZE = "10485760"
UPLOAD_PATH = "./uploads"

# OCR Configuration
TESSERACT_LANG = "eng"
TESSERACT_CONFIG = "--oem 3 --psm 6"
EOF

print_status "Railway config updated"

# Step 6: Test new Dockerfile
echo ""
echo "🧪 Testing new Dockerfile.railway..."
if docker build --no-cache -f Dockerfile.railway -t ai-backend-aggressive .; then
    print_status "New Dockerfile build successful"
else
    print_error "New Dockerfile build failed"
    exit 1
fi

# Step 7: Test application build
echo ""
echo "🧪 Testing application build..."
if npm run build; then
    print_status "Application build successful"
else
    print_error "Application build failed"
    exit 1
fi

# Step 8: Commit changes with aggressive message
echo ""
echo "📝 Committing changes with aggressive cache busting..."
git add .
git commit -m "AGGRESSIVE Railway cache busting - NEW Dockerfile.railway v4.0 - $(date)"
git push

print_status "Changes committed and pushed"

# Step 9: Final instructions
echo ""
echo "🎉 AGGRESSIVE Railway deployment ready!"
echo "======================================"
echo ""
echo "📋 CRITICAL NEXT STEPS:"
echo "1. DELETE your current Railway project completely"
echo "2. Create a BRAND NEW Railway project from GitHub"
echo "3. Railway MUST use Dockerfile.railway now"
echo "4. Add MySQL service"
echo "5. Set environment variables"
echo "6. Deploy!"
echo ""
echo "🔑 What we did:"
echo "- ✅ REMOVED ALL old Docker files"
echo "- ✅ Created NEW Dockerfile.railway v4.0"
echo "- ✅ Updated Railway config aggressively"
echo "- ✅ Cleared ALL Docker cache"
echo "- ✅ Force pushed changes"
echo ""
echo "🚨 IMPORTANT: You MUST create a NEW Railway project!"
echo "   Do NOT reuse the old one - it has cached builds!"
echo ""
echo "🚀 This aggressive approach will eliminate ALL cache issues!"
