#!/bin/bash

# AI CRM File Processing System - Quick Start Script
echo "🗂️ Starting AI CRM File Processing System..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js v16 or higher."
    exit 1
fi

# Check if MySQL is running (optional check)
echo "⚠️ Make sure MySQL is running and database 'ai_crm' is created"

# Install backend dependencies
echo "📦 Installing backend dependencies..."
cd backend
npm install

# Create uploads directory
mkdir -p uploads

# Start backend in background
echo "🚀 Starting backend server..."
npm run start:dev &
BACKEND_PID=$!

# Wait for backend to start
sleep 5

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd ../frontend
npm install

# Start frontend
echo "🚀 Starting frontend application..."
echo "Backend PID: $BACKEND_PID"
echo "Frontend will open at: http://localhost:3000"
echo "Backend API available at: http://localhost:3001"
echo ""
echo "Press Ctrl+C to stop both servers"

npm start

# Cleanup function
cleanup() {
    echo ""
    echo "🛑 Stopping servers..."
    kill $BACKEND_PID 2>/dev/null
    exit 0
}

trap cleanup SIGINT SIGTERM

