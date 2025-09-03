#!/bin/bash
set -e

echo "🚀 Force Railway Rebuild - No Cache"
echo "===================================="

# Step 1: Clean up any existing Docker images
echo ""
echo "🧹 Cleaning up Docker images..."
docker system prune -f
docker image prune -f

# Step 2: Force rebuild with no cache
echo ""
echo "🐳 Building Docker image with no cache..."
docker build --no-cache --pull -t ai-backend-railway .

# Step 3: Test the image
echo ""
echo "🧪 Testing the built image..."
docker run --rm -d --name test-backend -p 3001:3001 ai-backend-railway

# Wait a moment for the app to start
sleep 10

# Test health endpoint
echo ""
echo "🏥 Testing health endpoint..."
if curl -f http://localhost:3001/health > /dev/null 2>&1; then
    echo "✅ Health endpoint working!"
else
    echo "❌ Health endpoint failed"
fi

# Clean up test container
echo ""
echo "🧹 Cleaning up test container..."
docker stop test-backend
docker rm test-backend

echo ""
echo "🎉 Docker image ready for Railway deployment!"
echo ""
echo "📋 Next steps:"
echo "1. Push this to GitHub"
echo "2. Railway will automatically rebuild with no cache"
echo "3. Monitor the build logs in Railway dashboard"
