#!/bin/bash
set -e

echo "🌐 Deploying Frontend to Vercel"
echo "================================"

# Step 1: Ensure Dockerfile is ready for Railway
echo ""
echo "🐳 Checking Dockerfile for Railway deployment..."
if [ -f "Dockerfile" ]; then
    echo "✅ Dockerfile found and ready"
else
    echo "❌ Dockerfile not found - please create one"
    exit 1
fi

# Step 2: Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install

# Step 2: Build the application
echo ""
echo "🏗️ Building application..."
npm run build

# Step 3: Verify build output
echo ""
echo "✅ Verifying build output..."
if [ -d "build" ]; then
    echo "✅ Build directory created successfully"
    ls -la build/
else
    echo "❌ Build failed - no build directory found"
    exit 1
fi

# Step 4: Commit and push
echo ""
echo "📝 Committing and pushing changes..."
git add .
git commit -m "Prepare frontend for deployment - $(date)"
git push

echo ""
echo "🎉 Frontend ready for Vercel deployment!"
echo ""
echo "📋 Next steps:"
echo "1. Go to Vercel Dashboard: https://vercel.com/dashboard"
echo "2. Import your GitHub repository"
echo "3. Vercel will auto-detect React app"
echo "4. Set REACT_APP_API_URL environment variable"
echo "5. Deploy!"
