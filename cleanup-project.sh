#!/bin/bash
set -e

echo "🧹 Complete Project Cleanup"
echo "==========================="

# Backend cleanup
echo ""
echo "🔧 Cleaning backend..."
cd backend
node remove-console-logs.js
npm run build
echo "✅ Backend cleaned and built successfully"

# Frontend cleanup
echo ""
echo "🌐 Cleaning frontend..."
cd ../frontend
node remove-console-logs.js
npm run build
echo "✅ Frontend cleaned and built successfully"

# Commit changes
echo ""
echo "📝 Committing cleanup changes..."
cd ..
git add .
git commit -m "Cleanup: Remove console.log statements and unused files - $(date)"
git push

echo ""
echo "🎉 Project cleanup completed!"
echo "✅ All console.log statements removed"
echo "✅ All builds successful"
echo "✅ Changes committed and pushed"
