#!/bin/bash
set -e

echo "🔍 Verifying Railway Setup"
echo "=========================="

# Check what Docker files exist
echo ""
echo "📁 Docker files in directory:"
ls -la Dockerfile* 2>/dev/null || echo "No Dockerfile* found"

# Check Railway config
echo ""
echo "📋 Railway configuration:"
if [ -f "railway.toml" ]; then
    cat railway.toml
else
    echo "❌ railway.toml not found!"
fi

# Check if Dockerfile.railway exists
echo ""
echo "🐳 Dockerfile.railway status:"
if [ -f "Dockerfile.railway" ]; then
    echo "✅ Dockerfile.railway exists"
    echo "📏 Size: $(wc -l < Dockerfile.railway) lines"
    echo "🔍 First few lines:"
    head -5 Dockerfile.railway
else
    echo "❌ Dockerfile.railway not found!"
fi

# Check .dockerignore
echo ""
echo "🚫 .dockerignore status:"
if [ -f ".dockerignore" ]; then
    echo "✅ .dockerignore exists"
    echo "🔍 Docker file exclusions:"
    grep -i docker .dockerignore || echo "No Docker exclusions found"
else
    echo "❌ .dockerignore not found!"
fi

# Check .railwayignore
echo ""
echo "🚫 .railwayignore status:"
if [ -f ".railwayignore" ]; then
    echo "✅ .railwayignore exists"
    echo "🔍 Docker file exclusions:"
    grep -i docker .railwayignore || echo "No Docker exclusions found"
else
    echo "❌ .railwayignore not found!"
fi

echo ""
echo "🎯 Summary:"
if [ -f "Dockerfile.railway" ] && [ -f "railway.toml" ]; then
    echo "✅ Setup looks good for Railway"
    echo "🚀 Railway should use Dockerfile.railway"
else
    echo "❌ Setup incomplete - run the aggressive rebuild script"
fi
