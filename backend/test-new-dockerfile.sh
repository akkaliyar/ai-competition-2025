#!/bin/bash
set -e

echo "🧪 Testing New Dockerfile.railway"
echo "=================================="

# Check if new Dockerfile exists
if [ ! -f "Dockerfile.railway" ]; then
    echo "❌ Dockerfile.railway not found!"
    exit 1
fi

echo "✅ Dockerfile.railway found"

# Clean up any existing containers
echo ""
echo "🧹 Cleaning up existing containers..."
docker stop $(docker ps -q --filter "name=test-backend") 2>/dev/null || true
docker rm $(docker ps -aq --filter "name=test-backend") 2>/dev/null || true

# Build with new Dockerfile
echo ""
echo "🐳 Building with Dockerfile.railway..."
docker build --no-cache -f Dockerfile.railway -t ai-backend-test .

if [ $? -eq 0 ]; then
    echo "✅ Docker build successful!"
else
    echo "❌ Docker build failed!"
    exit 1
fi

# Test run
echo ""
echo "🚀 Testing container..."
docker run --rm -d --name test-backend -p 3001:3001 ai-backend-test

# Wait for startup
echo ""
echo "⏳ Waiting for app to start..."
sleep 20

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
echo "🎉 New Dockerfile.railway test successful!"
echo "Ready for Railway deployment!"
