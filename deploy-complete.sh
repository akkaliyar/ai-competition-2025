#!/bin/bash
set -e

echo "🚀 Complete AI CRM Deployment Script"
echo "===================================="

# Step 1: Fix Backend Issues
echo ""
echo "🔧 Step 1: Fixing Backend for Railway..."
cd backend

# Remove Dockerfile completely to force Railway to use nixpacks
if [ -f "Dockerfile" ]; then
    echo "🚫 Removing Dockerfile to force Railway to use nixpacks..."
    mv Dockerfile Dockerfile.disabled
    echo "✅ Dockerfile renamed to Dockerfile.disabled"
fi

# Use the simplest Railway configuration
if [ -f "railway-final.toml" ]; then
    echo "📝 Using simplified Railway configuration..."
    mv railway.toml railway.toml.backup 2>/dev/null || true
    mv railway-final.toml railway.toml
    echo "✅ Using railway-final.toml"
fi

# Fix package-lock.json
echo "🔧 Fixing package-lock.json..."
if [ -f "fix-lock-complete.js" ]; then
    node fix-lock-complete.js
else
    echo "⚠️  Using fallback method..."
    rm -f package-lock.json
    rm -rf node_modules
    npm install
fi

# Test build
echo "🧪 Testing backend build..."
npm run build

# Commit backend changes
echo "📝 Committing backend changes..."
git add .
git commit -m "Fix backend for Railway deployment - $(date)"

cd ..

# Step 2: Prepare Frontend
echo ""
echo "🌐 Step 2: Preparing Frontend..."
cd frontend

# Test frontend build
echo "🧪 Testing frontend build..."
npm install
npm run build

# Commit frontend changes
echo "📝 Committing frontend changes..."
git add .
git commit -m "Prepare frontend for deployment - $(date)"

cd ..

# Step 3: Push Everything
echo ""
echo "📤 Step 3: Pushing all changes..."
git add .
git commit -m "Complete deployment preparation - $(date)"
git push

echo ""
echo "🎉 Deployment preparation completed!"
echo ""
echo "📋 Next Steps:"
echo ""
echo "🔧 Backend (Railway):"
echo "1. Go to https://railway.app/dashboard"
echo "2. Create new project from GitHub repo"
echo "3. Railway will now use nixpacks (no Docker)"
echo "4. Add MySQL service to your project"
echo "5. Set environment variables:"
echo "   - NODE_ENV=production"
echo "   - PORT=3001"
echo "   - DB_HOST=your-mysql-host.railway.app"
echo "   - DB_PORT=3306"
echo "   - DB_USERNAME=your-mysql-username"
echo "   - DB_PASSWORD=your-mysql-password"
echo "   - DB_NAME=your-mysql-database"
echo "   - FRONTEND_URL=https://your-frontend-domain.vercel.app"
echo "6. Deploy!"
echo ""
echo "🌐 Frontend (Vercel):"
echo "1. Go to https://vercel.com/dashboard"
echo "2. Import your GitHub repository"
echo "3. Vercel will auto-detect React app"
echo "4. Set environment variable:"
echo "   - REACT_APP_API_URL=https://your-backend-app.railway.app"
echo "5. Deploy!"
echo ""
echo "🔗 After both are deployed:"
echo "- Test the complete application"
echo "- Verify file uploads work"
echo "- Check OCR processing"
echo "- Monitor logs in both platforms"
echo ""
echo "📖 See DEPLOYMENT_GUIDE.md for detailed instructions"
