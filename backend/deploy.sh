#!/bin/bash
set -e

echo "🚀 Deploying Backend to Railway"
echo "================================"

# Step 1: Ensure Dockerfile is ready
echo ""
echo "🐳 Checking Dockerfile for Railway deployment..."
if [ -f "Dockerfile" ]; then
    echo "✅ Dockerfile found and ready"
else
    echo "❌ Dockerfile not found - please create one"
    exit 1
fi

# Step 2: Test Docker build locally
echo ""
echo "🐳 Testing Docker build locally..."
docker build --no-cache -t ai-backend-test .
echo "✅ Docker build successful!"

# Step 3: Test application build
echo ""
echo "🧪 Testing application build..."
npm run build
echo "✅ Application build successful!"

# Step 4: Commit and push
echo ""
echo "📝 Committing changes..."
git add .
git commit -m "Clean Docker setup for Railway - $(date)"
git push

echo ""
echo "🎉 Backend ready for Railway deployment!"
echo ""
echo "📋 Next steps:"
echo "1. Go to Railway Dashboard: https://railway.app/dashboard"
echo "2. Create new project from GitHub repo"
echo "3. Add MySQL service"
echo "4. Set environment variables"
echo "5. Deploy!"
