#!/bin/bash
set -e

echo "🌐 Deploying Frontend..."

# Step 1: Install dependencies
echo "📦 Step 1: Installing dependencies..."
npm install

# Step 2: Build the application
echo "🏗️ Step 2: Building application..."
npm run build

# Step 3: Verify build output
echo "✅ Step 3: Verifying build output..."
if [ -d "build" ]; then
    echo "✅ Build directory created successfully"
    ls -la build/
else
    echo "❌ Build failed - no build directory found"
    exit 1
fi

# Step 4: Commit and push changes
echo "📝 Step 4: Committing and pushing changes..."
git add .
git commit -m "Build frontend for deployment - $(date)"
git push

echo "✅ Frontend deployment preparation completed!"
echo ""
echo "📋 Deployment Options:"
echo ""
echo "🚀 Vercel (Recommended):"
echo "1. Go to https://vercel.com"
echo "2. Import your GitHub repository"
echo "3. Vercel will auto-detect React app"
echo "4. Set REACT_APP_API_URL environment variable"
echo "5. Deploy!"
echo ""
echo "🌐 Netlify:"
echo "1. Go to https://netlify.com"
echo "2. Import your GitHub repository"
echo "3. Build command: npm run build"
echo "4. Publish directory: build"
echo "5. Set REACT_APP_API_URL environment variable"
echo "6. Deploy!"
echo ""
echo "🔗 Both platforms will automatically deploy on git push"
