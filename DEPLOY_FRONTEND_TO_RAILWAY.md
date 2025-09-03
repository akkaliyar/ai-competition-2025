# 🚀 Deploy Frontend to Railway

## 📋 Your Backend is Ready

✅ **Backend URL**: `https://ai-competition-2025-production.up.railway.app/`

## 🎯 Deploy Frontend to Railway

### **Step 1: Create Frontend Service**

1. Go to Railway dashboard: https://railway.app
2. Open your existing project (where backend is deployed)
3. Click **"+ Add Service"**
4. Select **"GitHub Repo"**
5. Choose your repository
6. **IMPORTANT**: Set **Root Directory** to `frontend`

### **Step 2: Configure Environment Variables**

In your **Frontend Service** → **Variables** tab, add:

```bash
NODE_ENV=production
REACT_APP_API_URL=https://ai-competition-2025-production.up.railway.app/api
```

### **Step 3: Deploy**

Railway will automatically:
1. Detect React application
2. Run `npm ci` (install dependencies)
3. Run `npm run build` (build React app)
4. Run `npm start` (serve built app)

## 🔗 API Configuration

I've updated your frontend code to automatically use the correct API URL:

### **Development** (localhost):
```
API_BASE_URL = 'http://localhost:3001/api'
```

### **Production** (Railway):
```
API_BASE_URL = 'https://ai-competition-2025-production.up.railway.app/api'
```

## ✅ Test Your Deployment

### **1. Check Backend Health**
```bash
curl https://ai-competition-2025-production.up.railway.app/healthz
# Expected: "OK"
```

### **2. Check API Endpoints**
```bash
curl https://ai-competition-2025-production.up.railway.app/api/files
# Expected: JSON response with files
```

### **3. Access Frontend**
After deployment, you'll get a frontend URL like:
```
https://your-frontend-service.railway.app
```

### **4. Test Frontend-Backend Communication**
1. Open frontend URL in browser
2. Check browser console - should see:
   ```
   🔗 API Base URL: https://ai-competition-2025-production.up.railway.app/api
   🌍 Environment: production
   ```
3. Try uploading a file to test API calls

## 🎯 Expected URLs

After deployment:
- **Frontend**: `https://[frontend-service].railway.app` ← **Users access this**
- **Backend**: `https://ai-competition-2025-production.up.railway.app` ← **API for frontend**

## 📱 How Users Will Use Your App

1. **Visit**: Your frontend Railway URL
2. **Upload files**: Through the React interface
3. **View results**: Processed files from backend database
4. **Use dashboard**: Analytics and file management

All API calls from frontend will automatically go to your Railway backend!

## 🔧 Files Updated

✅ **frontend/src/config/api.ts**: Centralized API configuration
✅ **frontend/src/App.tsx**: Uses Railway backend URL in production
✅ **frontend/src/components/Dashboard.tsx**: Updated API imports
✅ **frontend/src/components/ResultsDisplay.tsx**: Updated API imports
✅ **frontend/package.json**: Removed localhost proxy

## 🎉 Success Indicators

Your deployment is successful when:

✅ Frontend loads on Railway URL
✅ Browser console shows Railway API URL
✅ File upload works (calls backend API)
✅ Results display shows files from database
✅ No CORS or network errors

🚀 **Your AI CRM will be fully functional on Railway!**