#!/bin/bash
set -e

echo "🔍 Verifying Railway Docker Setup"
echo "================================="

echo ""
echo "📁 Checking Docker files..."
if [ -f "Dockerfile.railway.v2" ]; then
    echo "✅ Dockerfile.railway.v2 found"
else
    echo "❌ Dockerfile.railway.v2 missing!"
    exit 1
fi

echo ""
echo "📋 Checking Railway configuration..."
if [ -f "railway.toml" ]; then
    echo "✅ railway.toml found"
    echo "   Dockerfile path: $(grep 'dockerfilePath' railway.toml)"
    echo "   Build command: $(grep 'buildCommand' railway.toml)"
else
    echo "❌ railway.toml missing!"
    exit 1
fi

echo ""
echo "🧪 Testing Docker build locally..."
if docker build -f Dockerfile.railway.v2 -t ai-backend-test .; then
    echo "✅ Docker build successful"
else
    echo "❌ Docker build failed"
    exit 1
fi

echo ""
echo "🧹 Cleaning up test image..."
docker rmi ai-backend-test

echo ""
echo "🎯 Railway Docker setup verification complete!"
echo "📋 Next steps:"
echo "1. Deploy to Railway using Dockerfile.railway.v2"
echo "2. Railway should use the new Dockerfile"
echo "3. Look for 'Using Dockerfile: Dockerfile.railway.v2' in logs"
