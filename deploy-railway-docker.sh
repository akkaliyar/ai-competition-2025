#!/bin/bash

# Railway Docker Deployment Script

echo "🚀 Deploying AI CRM to Railway with Docker..."

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Install it first:"
    echo "npm install -g @railway/cli"
    exit 1
fi

# Login to Railway (if not already logged in)
echo "🔐 Checking Railway authentication..."
railway login

# Create new project or link existing
echo "📋 Setting up Railway project..."
read -p "Do you want to create a new project? (y/n): " create_new

if [ "$create_new" = "y" ]; then
    railway init
else
    railway link
fi

# Add MySQL database
echo "🗄️  Adding MySQL database..."
railway add mysql

# Deploy with Docker
echo "🐳 Deploying with Docker..."
cp railway-docker.toml railway.toml
railway up

echo "✅ Deployment initiated!"
echo "📋 Next steps:"
echo "1. Go to Railway dashboard"
echo "2. Set environment variables manually"
echo "3. Get MySQL connection details"
echo "4. Update backend service variables"

# Cleanup
rm railway.toml