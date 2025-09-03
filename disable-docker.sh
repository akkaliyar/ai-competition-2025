#!/bin/bash

echo "🚫 Disabling Docker for Railway deployment..."

# Check if we're in the right directory
if [ ! -f "backend/Dockerfile" ]; then
    echo "❌ Dockerfile not found in backend directory"
    echo "Please run this script from the project root"
    exit 1
fi

# Rename Dockerfile to force Railway to use nixpacks
echo "📝 Renaming Dockerfile to force Railway to use nixpacks..."
cd backend
mv Dockerfile Dockerfile.disabled
echo "✅ Dockerfile renamed to Dockerfile.disabled"

# Use the simplest Railway configuration
if [ -f "railway-final.toml" ]; then
    echo "📝 Using simplified Railway configuration..."
    mv railway.toml railway.toml.backup 2>/dev/null || true
    mv railway-final.toml railway.toml
    echo "✅ Using railway-final.toml"
fi

echo ""
echo "🎉 Docker disabled successfully!"
echo "Railway will now use nixpacks instead of Docker"
echo ""
echo "📋 Next steps:"
echo "1. Commit these changes: git add . && git commit -m 'Disable Docker'"
echo "2. Push to GitHub: git push"
echo "3. Deploy on Railway - it will now use nixpacks"
