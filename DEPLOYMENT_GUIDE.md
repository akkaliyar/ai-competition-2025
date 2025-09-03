# 🚀 Complete Deployment Guide

This guide will help you deploy both the backend and frontend of your AI CRM application.

## 📋 **Prerequisites**

- ✅ GitHub repository with your code
- ✅ Railway account (for backend)
- ✅ Vercel or Netlify account (for frontend)
- ✅ MySQL database (can be provisioned through Railway)

## 🔧 **Backend Deployment (Railway)**

### Step 1: Prepare Backend
```bash
cd backend
chmod +x deploy-backend.sh
./deploy-backend.sh
```

### Step 2: Deploy on Railway
1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your repository
5. Railway will automatically detect your `railway.toml` configuration

### Step 3: Add MySQL Service
1. In your Railway project, click "New Service"
2. Select "MySQL"
3. Railway will provide connection details automatically

### Step 4: Configure Environment Variables
In Railway dashboard → Variables tab, add:
```
NODE_ENV=production
PORT=3001
DB_HOST=your-mysql-host.railway.app
DB_PORT=3306
DB_USERNAME=your-mysql-username
DB_PASSWORD=your-mysql-password
DB_NAME=your-mysql-database
FRONTEND_URL=https://your-frontend-domain.vercel.app
MAX_FILE_SIZE=10485760
UPLOAD_PATH=./uploads
TESSERACT_LANG=eng
TESSERACT_CONFIG=--oem 3 --psm 6
```

### Step 5: Deploy
- Railway will automatically build and deploy
- Monitor build logs for any errors
- Check health endpoint: `https://your-app.railway.app/health`

## 🌐 **Frontend Deployment (Vercel - Recommended)**

### Step 1: Prepare Frontend
```bash
cd frontend
chmod +x deploy-frontend.sh
./deploy-frontend.sh
```

### Step 2: Deploy on Vercel
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "New Project"
3. Import your GitHub repository
4. Vercel will auto-detect React app settings

### Step 3: Configure Environment Variables
In Vercel dashboard → Settings → Environment Variables, add:
```
REACT_APP_API_URL=https://your-backend-app.railway.app
```

### Step 4: Deploy
- Vercel will automatically build and deploy
- Your app will be available at: `https://your-app.vercel.app`

## 🌐 **Frontend Deployment (Netlify - Alternative)**

### Step 1: Deploy on Netlify
1. Go to [Netlify Dashboard](https://netlify.com/dashboard)
2. Click "New site from Git"
3. Connect your GitHub repository
4. Configure build settings:
   - Build command: `npm run build`
   - Publish directory: `build`

### Step 2: Configure Environment Variables
In Netlify dashboard → Site settings → Environment variables, add:
```
REACT_APP_API_URL=https://your-backend-app.railway.app
```

## 🔗 **Connect Frontend to Backend**

### Update API Configuration
After both are deployed, update your frontend API calls to use the Railway backend URL.

### CORS Configuration
The backend is already configured to allow CORS from your frontend domain.

## 📊 **Monitoring & Maintenance**

### Backend (Railway)
- Monitor logs in Railway dashboard
- Check health endpoint regularly
- Set up alerts for failed deployments

### Frontend (Vercel/Netlify)
- Monitor build status
- Check for build errors
- Review deployment logs

## 🚨 **Troubleshooting**

### Backend Issues
- Check Railway build logs
- Verify environment variables
- Ensure database connectivity
- Run `node test-build.js` locally

### Frontend Issues
- Check build logs in Vercel/Netlify
- Verify environment variables
- Ensure API URL is correct
- Test build locally with `npm run build`

### Common Problems
1. **CORS errors**: Verify FRONTEND_URL in backend environment variables
2. **API connection failed**: Check REACT_APP_API_URL in frontend
3. **Build failures**: Check package-lock.json synchronization
4. **Database errors**: Verify MySQL connection details

## 🎯 **Success Checklist**

- ✅ Backend deployed on Railway
- ✅ Frontend deployed on Vercel/Netlify
- ✅ MySQL database connected
- ✅ Environment variables configured
- ✅ Health endpoint responding
- ✅ Frontend can connect to backend
- ✅ File upload working
- ✅ OCR processing functional

## 🔄 **Continuous Deployment**

Both Railway and Vercel/Netlify will automatically redeploy when you push changes to your GitHub repository.

## 📞 **Support**

- **Railway**: Check their [documentation](https://docs.railway.app/)
- **Vercel**: Check their [documentation](https://vercel.com/docs)
- **Netlify**: Check their [documentation](https://docs.netlify.com/)

---

**Happy Deploying! 🚀**
