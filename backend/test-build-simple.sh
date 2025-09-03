#!/bin/bash
set -e

echo "🧪 Testing Backend Build Process"
echo "================================"

cd backend

echo ""
echo "🔧 Installing dependencies..."
npm install

echo ""
echo "🔨 Running build..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo ""
    echo "📁 Build output:"
    ls -la dist/
    
    if [ -d "dist/entities" ]; then
        echo "✅ Entities directory copied successfully"
        ls -la dist/entities/
    else
        echo "⚠️  Entities directory not found in dist/"
    fi
    
    echo ""
    echo "🎉 Backend build test passed!"
else
    echo "❌ Build failed!"
    exit 1
fi
