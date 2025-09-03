#!/bin/bash
set -e

echo "🚀 Railway Deployment - Backend & Frontend"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Step 1: Deploy Backend
echo ""
echo "🔧 Deploying Backend to Railway..."
echo "=================================="

cd backend

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
    print_error "Dockerfile not found in backend directory"
    exit 1
fi

# Test Docker build
echo ""
echo "🐳 Testing Docker build..."
if docker build --no-cache -t ai-backend-railway .; then
    print_status "Docker build successful"
else
    print_error "Docker build failed"
    exit 1
fi

# Test application build
echo ""
echo "🧪 Testing application build..."
if npm run build; then
    print_status "Application build successful"
else
    print_error "Application build failed"
    exit 1
fi

# Commit and push backend changes
echo ""
echo "📝 Committing backend changes..."
git add .
git commit -m "Deploy backend to Railway - $(date)"
git push

print_status "Backend ready for Railway deployment"

cd ..

# Step 2: Deploy Frontend
echo ""
echo "🌐 Deploying Frontend to Railway..."
echo "==================================="

cd frontend

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
    print_error "Dockerfile not found in frontend directory"
    exit 1
fi

# Test Docker build
echo ""
echo "🐳 Testing Docker build..."
if docker build --no-cache -t ai-frontend-railway .; then
    print_status "Docker build successful"
else
    print_error "Docker build failed"
    exit 1
fi

# Test application build
echo ""
echo "🧪 Testing application build..."
if npm run build; then
    print_status "Application build successful"
else
    print_error "Application build failed"
    exit 1
fi

# Commit and push frontend changes
echo ""
echo "📝 Committing frontend changes..."
git add .
git commit -m "Deploy frontend to Railway - $(date)"
git push

print_status "Frontend ready for Railway deployment"

cd ..

# Step 3: Final Instructions
echo ""
echo "🎉 Both applications are ready for Railway deployment!"
echo "====================================================="
echo ""
echo "📋 Next steps:"
echo ""
echo "🔧 BACKEND DEPLOYMENT:"
echo "1. Go to Railway Dashboard: https://railway.app/dashboard"
echo "2. Create new project from GitHub repo"
echo "3. Add MySQL service"
echo "4. Set environment variables:"
echo "   - NODE_ENV=production"
echo "   - PORT=3001"
echo "   - DB_HOST=your-mysql-host.railway.app"
echo "   - DB_PORT=3306"
echo "   - DB_USERNAME=your-mysql-username"
echo "   - DB_PASSWORD=your-mysql-password"
echo "   - DB_NAME=your-mysql-database"
echo "   - FRONTEND_URL=https://your-frontend-domain.railway.app"
echo "   - MAX_FILE_SIZE=10485760"
echo "   - UPLOAD_PATH=./uploads"
echo "   - TESSERACT_LANG=eng"
echo "   - TESSERACT_CONFIG=--oem 3 --psm 6"
echo ""
echo "🌐 FRONTEND DEPLOYMENT:"
echo "1. Create another Railway project from GitHub repo"
echo "2. Set environment variables:"
echo "   - NODE_ENV=production"
echo "   - REACT_APP_API_URL=https://your-backend-app.railway.app"
echo "   - PORT=80"
echo ""
echo "🔗 CONNECT THEM:"
echo "1. Update FRONTEND_URL in backend with your frontend Railway URL"
echo "2. Update REACT_APP_API_URL in frontend with your backend Railway URL"
echo ""
echo "📊 MONITOR:"
echo "- Check build logs in Railway dashboard"
echo "- Verify health endpoints are working"
echo "- Test file upload and OCR functionality"
echo ""
echo "🚀 Happy Deploying! 🐳"
