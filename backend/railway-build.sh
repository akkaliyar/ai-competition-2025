#!/bin/bash
set -e

echo "🚀 Railway Build Script Starting..."
echo "===================================="

# Step 1: Install dependencies using npm install (not npm ci)
echo "📦 Installing dependencies..."
npm install --omit=dev --no-audit --no-fund

# Step 2: Build the application
echo "🏗️ Building application..."
npm run build

# Step 3: Verify build output
echo "✅ Verifying build output..."
if [ -d "dist" ]; then
    echo "✅ Build directory created successfully"
    ls -la dist/
else
    echo "❌ Build failed - no dist directory found"
    exit 1
fi

# Step 4: Create uploads directory if it doesn't exist
echo "📁 Setting up uploads directory..."
mkdir -p uploads
chmod 755 uploads

echo "🎉 Railway build completed successfully!"
echo "🚀 Ready to start the application..."
