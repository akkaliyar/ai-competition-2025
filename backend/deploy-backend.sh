#!/bin/bash
set -e

echo "🚀 Deploying Backend to Railway..."

# Step 1: Fix package-lock.json
echo "🔧 Step 1: Fixing package-lock.json..."
if [ -f "fix-package-lock.js" ]; then
    node fix-package-lock.js
else
    echo "⚠️  fix-package-lock.js not found, manually removing lock file..."
    rm -f package-lock.json
    rm -rf node_modules
    npm install
fi

# Step 2: Test build locally
echo "🧪 Step 2: Testing build locally..."
node test-build.js

# Step 3: Commit changes
echo "📝 Step 3: Committing changes..."
git add .
git commit -m "Prepare backend for Railway deployment - $(date)"

# Step 4: Push to GitHub
echo "📤 Step 4: Pushing to GitHub..."
git push

echo "✅ Backend deployment preparation completed!"
echo ""
echo "📋 Next steps:"
echo "1. Go to Railway Dashboard: https://railway.app/dashboard"
echo "2. Create new project from GitHub repo"
echo "3. Add MySQL service to your project"
echo "4. Set environment variables in Railway dashboard"
echo "5. Deploy!"
echo ""
echo "🔗 Railway will automatically detect your railway.toml configuration"
