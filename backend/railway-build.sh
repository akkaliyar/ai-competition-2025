#!/bin/bash
set -e

echo "🚀 Railway Backend Build Script"
echo "================================"

# Ensure we're in the backend directory
cd /app

echo "📦 Installing dependencies..."
npm install

echo "🔨 Building application..."
npm run build

echo "✅ Build completed successfully!"
echo "📁 Build output:"
ls -la dist/

echo "🎉 Ready for deployment!"
