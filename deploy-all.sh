#!/bin/bash
set -e

echo "🚀 Deploying Complete AI CRM Application..."
echo "=============================================="

# Step 1: Deploy Backend
echo ""
echo "🔧 Step 1: Deploying Backend to Railway..."
cd backend
chmod +x deploy-backend.sh
./deploy-backend.sh

# Step 2: Deploy Frontend
echo ""
echo "🌐 Step 2: Deploying Frontend..."
cd ../frontend
chmod +x deploy-frontend.sh
./deploy-frontend.sh

echo ""
echo "🎉 Deployment preparation completed for both applications!"
echo ""
echo "📋 Next Steps:"
echo "1. Backend: Deploy on Railway (https://railway.app/dashboard)"
echo "2. Frontend: Deploy on Vercel (https://vercel.com/dashboard)"
echo "3. Configure environment variables in both platforms"
echo "4. Test the complete application"
echo ""
echo "📖 See DEPLOYMENT_GUIDE.md for detailed instructions"
