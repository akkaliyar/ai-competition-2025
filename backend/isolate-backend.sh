#!/bin/bash

echo "🔒 Isolating Backend for Railway Deployment"
echo "=========================================="

# Create a clean backend-only directory
mkdir -p ../railway-backend
cp -r * ../railway-backend/
cd ../railway-backend

echo "✅ Backend isolated in ../railway-backend/"
echo "📋 Files in isolated backend:"
ls -la

echo ""
echo "🚀 Next steps:"
echo "1. Deploy from ../railway-backend/ directory"
echo "2. Or set Railway root directory to 'backend'"
echo "3. This ensures Railway only sees backend files"
