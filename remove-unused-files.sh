#!/bin/bash
set -e

echo "🗑️ Removing Unused Files"
echo "========================"

cd backend

# Remove redundant deployment scripts (keep only the main ones)
echo ""
echo "🧹 Removing redundant deployment scripts..."
rm -f force-fresh-railway-deploy.sh
rm -f test-new-dockerfile.sh
rm -f test-docker-build.sh
rm -f force-railway-rebuild.sh
rm -f fix-lock-complete.js
rm -f RAILWAY_DEPLOYMENT.md
rm -f .nixpacks

echo "✅ Removed redundant files"

# Keep only essential files:
# - Dockerfile.railway (main Docker file)
# - railway.toml (Railway config)
# - .railwayignore (Railway ignore rules)
# - .dockerignore (Docker ignore rules)
# - deploy.sh (main deployment script)
# - force-railway-rebuild-aggressive.sh (aggressive rebuild script)
# - verify-railway-setup.sh (verification script)

echo ""
echo "📋 Essential files kept:"
echo "- Dockerfile.railway"
echo "- railway.toml"
echo "- .railwayignore"
echo "- .dockerignore"
echo "- deploy.sh"
echo "- force-railway-rebuild-aggressive.sh"
echo "- verify-railway-setup.sh"

echo ""
echo "🎉 Unused files removed successfully!"
