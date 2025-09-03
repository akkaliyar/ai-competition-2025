#!/bin/bash
set -e

echo "🧪 Testing Docker Build for Railway"
echo "==================================="

# Step 1: Clean up
echo ""
echo "🧹 Cleaning up..."
docker system prune -f

# Step 2: Build with no cache
echo ""
echo "🐳 Building Docker image..."
docker build --no-cache -t ai-backend-test .

# Step 3: Test run
echo ""
echo "🚀 Testing container..."
docker run --rm -d --name test-backend -p 3001:3001 ai-backend-test

# Wait for startup
echo ""
echo "⏳ Waiting for app to start..."
sleep 15

# Test health endpoint
echo ""
echo "🏥 Testing health endpoint..."
if curl -f http://localhost:3001/health > /dev/null 2>&1; then
    echo "✅ Health endpoint working!"
else
    echo "❌ Health endpoint failed"
fi

# Cleanup
echo ""
echo "🧹 Cleaning up..."
docker stop test-backend
docker rm test-backend

echo ""
echo "🎉 Docker build test successful!"
echo "Ready for Railway deployment!"
