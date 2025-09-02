@echo off
REM AI CRM File Processing System - Quick Start Script for Windows

echo 🗂️ Starting AI CRM File Processing System...

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js is not installed. Please install Node.js v16 or higher.
    pause
    exit /b 1
)

echo ⚠️ Make sure MySQL is running and database 'ai_crm' is created

REM Install backend dependencies
echo 📦 Installing backend dependencies...
cd backend
call npm install

REM Create uploads directory
if not exist "uploads" mkdir uploads

REM Start backend in background
echo 🚀 Starting backend server...
start "AI CRM Backend" cmd /c "npm run start:dev"

REM Wait for backend to start
timeout /t 5 /nobreak >nul

REM Install frontend dependencies
echo 📦 Installing frontend dependencies...
cd ..\frontend
call npm install

REM Start frontend
echo 🚀 Starting frontend application...
echo Frontend will open at: http://localhost:3000
echo Backend API available at: http://localhost:3001
echo.
echo Press Ctrl+C in both console windows to stop the servers

call npm start

pause
