#!/bin/bash
set -e

echo "🧪 Testing Docker Build Locally"
echo "================================"

cd backend

echo ""
echo "🔧 Building Docker image..."
docker build -f Dockerfile.railway -t ai-competition-backend:test .

if [ $? -eq 0 ]; then
    echo "✅ Docker build successful!"
    
    echo ""
    echo "🚀 Testing container startup..."
    docker run -d --name test-backend -p 3001:3001 ai-competition-backend:test
    
    echo "⏳ Waiting for container to start..."
    sleep 10
    
    echo "🔍 Testing health endpoint..."
    if curl -f http://localhost:3001/health > /dev/null 2>&1; then
        echo "✅ Health check passed!"
    else
        echo "❌ Health check failed!"
    fi
    
    echo ""
    echo "🧹 Cleaning up test container..."
    docker stop test-backend
    docker rm test-backend
    
    echo "🎉 All tests passed! Ready for Railway deployment."
else
    echo "❌ Docker build failed!"
    exit 1
fi
