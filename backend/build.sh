#!/bin/bash
set -e

echo "🔨 Starting build process..."

# Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf dist

# Install dependencies
echo "📦 Installing dependencies..."
npm install --production

# Build the application
echo "🏗️ Building application..."
npm run build

# Ensure entities directory exists in dist
echo "📁 Copying entities..."
mkdir -p dist/src/entities
cp -r src/entities/* dist/src/entities/ 2>/dev/null || echo "No entities to copy"

# Verify build output
echo "✅ Build completed successfully!"
echo "📋 Build contents:"
ls -la dist/

echo "🚀 Ready for deployment!"
