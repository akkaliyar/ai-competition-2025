#!/bin/bash
set -e

echo "🚀 Complete AI CRM Deployment"
echo "============================="

# Step 1: Deploy Backend
echo ""
echo "🔧 Step 1: Deploying Backend to Railway..."
cd backend
chmod +x deploy.sh
./deploy.sh
cd ..

# Step 2: Deploy Frontend
echo ""
echo "🌐 Step 2: Deploying Frontend to Vercel..."
cd frontend
chmod +x deploy.sh
./deploy.sh
cd ..

echo ""
echo "🎉 Both applications are ready for deployment!"
echo ""
echo "📋 Deployment Steps:"
echo ""
echo "🔧 Backend (Railway):"
echo "1. Go to https://railway.app/dashboard"
echo "2. Create new project from GitHub repo"
echo "3. Add MySQL service"
echo "4. Set environment variables"
echo "5. Deploy!"
echo ""
echo "🌐 Frontend (Vercel):"
echo "1. Go to https://vercel.com/dashboard"
echo "2. Import GitHub repository"
echo "3. Set REACT_APP_API_URL"
echo "4. Deploy!"
echo ""
echo "📖 See DEPLOYMENT_GUIDE.md for detailed instructions"
