#!/bin/bash
set -e

echo "🔍 Verifying Railway Setup"
echo "=========================="

echo ""
echo "📁 Checking for Docker files..."
if [ -f "backend/Dockerfile.railway" ]; then
    echo "✅ Backend Dockerfile.railway found"
else
    echo "❌ Backend Dockerfile.railway missing!"
    exit 1
fi

if [ -f "Dockerfile" ]; then
    echo "⚠️  Root Dockerfile found - this might cause conflicts!"
    echo "   Consider removing it or Railway might use it instead"
else
    echo "✅ No root Dockerfile found (good for Railway)"
fi

echo ""
echo "📋 Checking Railway configuration..."
if [ -f "backend/railway.toml" ]; then
    echo "✅ Backend railway.toml found"
    echo "   Dockerfile path: $(grep 'dockerfilePath' backend/railway.toml)"
else
    echo "❌ Backend railway.toml missing!"
    exit 1
fi

echo ""
echo "🔧 Testing backend build locally..."
cd backend

if npm run build > /dev/null 2>&1; then
    echo "✅ Backend build successful"
else
    echo "❌ Backend build failed"
    exit 1
fi

echo ""
echo "🎯 Railway setup verification complete!"
echo "📋 Next steps:"
echo "1. Deploy to Railway using backend/Dockerfile.railway"
echo "2. Ensure Railway project is set to use backend directory"
echo "3. Monitor build logs for any remaining issues"
