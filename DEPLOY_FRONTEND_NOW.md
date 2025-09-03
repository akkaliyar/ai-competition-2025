# 🚀 Deploy Frontend to Railway - Step by Step

## ✅ Current Status
- **Backend**: ✅ Working at `https://ai-competition-2025-production.up.railway.app/`
- **Frontend**: ❌ Not deployed yet (that's why you see API response instead of UI)

## 🎯 Deploy Frontend Service

### **Step 1: Create Frontend Service on Railway**

1. **Go to Railway Dashboard**: https://railway.app
2. **Open your existing project** (where backend is deployed)
3. **Click "+ Add Service"**
4. **Select "GitHub Repo"**
5. **Choose your repository** (same as backend)
6. **CRITICAL**: Set **Root Directory** to `frontend`
   ```
   Root Directory: frontend
   ```
7. **Click "Deploy"**

### **Step 2: Set Environment Variables**

After frontend service is created:

1. **Go to Frontend Service** → **Variables** tab
2. **Add these variables**:
   ```
   NODE_ENV=production
   REACT_APP_API_URL=https://ai-competition-2025-production.up.railway.app/api
   ```

### **Step 3: Wait for Deployment**

Railway will:
- ✅ Detect React app in `frontend/` folder
- ✅ Run `npm ci` (install dependencies)
- ✅ Run `npm run build` (build React app)
- ✅ Run `npm start` (serve the app)

### **Step 4: Get Frontend URL**

After deployment, Railway will provide a frontend URL like:
```
https://frontend-service-name.railway.app
```

## 🎯 Expected Result

### **Frontend URL** (what users will access):
```
https://your-frontend-service.railway.app
```
- Shows React UI with file upload
- Dashboard, results, analytics
- Full AI CRM interface

### **Backend URL** (API only):
```
https://ai-competition-2025-production.up.railway.app
```
- API endpoints for frontend
- Not meant for direct user access

## 🔧 Why You See API Response Now

Currently accessing:
```
https://ai-competition-2025-production.up.railway.app/
```

This shows:
```json
{
  "message": "AI CRM Backend API",
  "status": "running", 
  "version": "1.0.0",
  "endpoints": ["/healthz", "/health", "/status", "/ping"]
}
```

This is **correct for backend**, but you need **frontend service** for the UI.

## ✅ After Frontend Deployment

You'll have:
- **Backend**: `https://ai-competition-2025-production.up.railway.app` (API)
- **Frontend**: `https://[frontend].railway.app` (User Interface)

Users will access the **frontend URL** to use your AI CRM application!

## 🚨 Quick Fix

**Alternative: Deploy Frontend Only**

If you want to deploy frontend quickly:

1. Create new Railway project
2. Connect GitHub repo
3. Set Root Directory: `frontend`
4. Set environment variable:
   ```
   REACT_APP_API_URL=https://ai-competition-2025-production.up.railway.app/api
   ```

Your frontend will call the existing backend API automatically!