#!/bin/bash
set -e

echo "🚀 Force Fresh Railway Deployment - No Cache"
echo "============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Step 1: Remove old Docker files
echo ""
echo "🧹 Removing old Docker files..."
rm -f Dockerfile
rm -f Dockerfile.backup
rm -f Dockerfile.disabled
print_status "Old Docker files removed"

# Step 2: Clean Docker cache
echo ""
echo "🐳 Cleaning Docker cache..."
docker system prune -f
docker image prune -f
print_status "Docker cache cleaned"

# Step 3: Test new Dockerfile
echo ""
echo "🧪 Testing new Dockerfile.railway..."
if docker build --no-cache -t ai-backend-fresh .; then
    print_status "New Dockerfile build successful"
else
    print_error "New Dockerfile build failed"
    exit 1
fi

# Step 4: Test application build
echo ""
echo "🧪 Testing application build..."
if npm run build; then
    print_status "Application build successful"
else
    print_error "Application build failed"
    exit 1
fi

# Step 5: Commit changes
echo ""
echo "📝 Committing changes..."
git add .
git commit -m "Force fresh Railway deployment - new Dockerfile.railway - $(date)"
git push

print_status "Changes committed and pushed"

# Step 6: Final instructions
echo ""
echo "🎉 Fresh deployment ready!"
echo "=========================="
echo ""
echo "📋 Next steps:"
echo "1. Go to Railway Dashboard: https://railway.app/dashboard"
echo "2. Create new project from GitHub repo"
echo "3. Railway will use Dockerfile.railway automatically"
echo "4. Add MySQL service"
echo "5. Set environment variables"
echo "6. Deploy!"
echo ""
echo "🔑 Key changes made:"
echo "- ✅ New Dockerfile.railway (multi-stage build)"
echo "- ✅ No npm ci (uses npm install)"
echo "- ✅ Railway config points to new Dockerfile"
echo "- ✅ Old Dockerfile completely removed"
echo ""
echo "🚀 This should resolve the npm ci cache issue!"
