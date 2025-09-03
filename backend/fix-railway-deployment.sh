#!/bin/bash
set -e

echo "🔧 Fixing Railway Deployment Issues..."
echo "======================================"

# Step 1: Fix package-lock.json completely
echo ""
echo "🧹 Step 1: Completely fixing package-lock.json..."
if [ -f "fix-lock-complete.js" ]; then
    node fix-lock-complete.js
else
    echo "⚠️  Using fallback method..."
    rm -f package-lock.json
    rm -rf node_modules
    npm install
fi

# Step 2: Rename Dockerfile to prevent Railway from using it
echo ""
echo "🚫 Step 2: Preventing Railway from using Dockerfile..."
if [ -f "Dockerfile" ]; then
    mv Dockerfile Dockerfile.backup
    echo "✅ Dockerfile renamed to Dockerfile.backup"
    echo "   Railway will now use nixpacks instead"
else
    echo "ℹ️  Dockerfile not found, continuing..."
fi

# Step 3: Test the build
echo ""
echo "🧪 Step 3: Testing build..."
npm run build

# Step 4: Commit all changes
echo ""
echo "📝 Step 4: Committing changes..."
git add .
git commit -m "Fix Railway deployment: regenerate package-lock.json and disable Docker - $(date)"

# Step 5: Push to GitHub
echo ""
echo "📤 Step 5: Pushing to GitHub..."
git push

echo ""
echo "🎉 Railway deployment issues fixed!"
echo ""
echo "📋 What was fixed:"
echo "✅ package-lock.json regenerated and synchronized"
echo "✅ Dockerfile renamed (Railway will use nixpacks)"
echo "✅ Build tested locally"
echo "✅ Changes committed and pushed"
echo ""
echo "📋 Next steps:"
echo "1. Go to Railway Dashboard: https://railway.app/dashboard"
echo "2. Create new project from GitHub repo"
echo "3. Railway will now use nixpacks + railway.toml"
echo "4. Add MySQL service to your project"
echo "5. Set environment variables"
echo "6. Deploy!"
echo ""
echo "🔧 If you still get errors:"
echo "   - Use railway-force.toml instead of railway.toml"
echo "   - Clear Railway build cache"
echo "   - Check build logs for specific errors"
