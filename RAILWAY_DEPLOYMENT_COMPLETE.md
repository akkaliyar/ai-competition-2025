# 🚀 Complete Railway Deployment Guide

## 📋 **Overview**
This guide will help you deploy both your backend and frontend applications on Railway using Docker containers.

## 🔧 **Backend Deployment (Railway)**

### **Step 1: Prepare Backend**
```bash
cd backend
chmod +x deploy.sh
./deploy.sh
```

### **Step 2: Deploy on Railway**
1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your repository
5. Railway will automatically detect the `railway.toml` and use Docker

### **Step 3: Add MySQL Service**
1. In your Railway project, click "New Service"
2. Select "MySQL"
3. Railway will provide connection details automatically

### **Step 4: Configure Environment Variables**
In Railway dashboard → Variables tab, add:
```
NODE_ENV=production
PORT=3001
DB_HOST=your-mysql-host.railway.app
DB_PORT=3306
DB_USERNAME=your-mysql-username
DB_PASSWORD=your-mysql-password
DB_NAME=your-mysql-database
FRONTEND_URL=https://your-frontend-domain.railway.app
MAX_FILE_SIZE=10485760
UPLOAD_PATH=./uploads
TESSERACT_LANG=eng
TESSERACT_CONFIG=--oem 3 --psm 6
```

### **Step 5: Deploy**
- Railway will automatically build using Docker
- Monitor build logs for any errors
- Check health endpoint: `https://your-app.railway.app/health`

## 🌐 **Frontend Deployment (Railway)**

### **Step 1: Prepare Frontend**
```bash
cd frontend
chmod +x deploy.sh
./deploy.sh
```

### **Step 2: Deploy on Railway**
1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your repository
5. Railway will use the frontend `railway.toml` configuration

### **Step 3: Configure Environment Variables**
In Railway dashboard → Variables tab, add:
```
NODE_ENV=production
REACT_APP_API_URL=https://your-backend-app.railway.app
PORT=80
```

### **Step 4: Deploy**
- Railway will build using Docker
- Frontend will be served by nginx
- Your app will be available at: `https://your-frontend-app.railway.app`

## 🐳 **Docker Configuration Details**

### **Backend Dockerfile Features:**
- Node.js 20 Alpine base image
- Tesseract OCR dependencies
- Optimized npm install (no npm ci)
- Health check endpoint
- Production-ready configuration

### **Frontend Dockerfile Features:**
- Multi-stage build (Node.js + nginx)
- Optimized static file serving
- React Router support
- Gzip compression
- Security headers
- Asset caching

## 🔗 **Connect Frontend to Backend**

### **Update API Configuration**
After both are deployed, ensure your frontend API calls use the Railway backend URL.

### **CORS Configuration**
The backend is configured to allow CORS from your frontend domain.

## 📊 **Monitoring & Maintenance**

### **Backend (Railway)**
- Monitor logs in Railway dashboard
- Check health endpoint regularly
- Set up alerts for failed deployments

### **Frontend (Railway)**
- Monitor build status
- Check for build errors
- Review deployment logs

## 🚨 **Troubleshooting**

### **Build Failures**
- Check Railway build logs
- Verify Dockerfile syntax
- Ensure all dependencies are in package.json

### **Runtime Errors**
- Check application logs in Railway dashboard
- Verify environment variables are set correctly
- Ensure database connectivity

### **Common Docker Issues**
1. **Build timeouts**: Check Dockerfile optimization
2. **Memory issues**: Optimize multi-stage builds
3. **Port conflicts**: Verify port configurations

## 🎯 **Success Checklist**

- ✅ Backend deployed on Railway with Docker
- ✅ Frontend deployed on Railway with Docker
- ✅ MySQL database connected
- ✅ Environment variables configured
- ✅ Health endpoint responding
- ✅ Frontend can connect to backend
- ✅ File upload working
- ✅ OCR processing functional

## 🔄 **Continuous Deployment**

Both applications will automatically redeploy when you push changes to your GitHub repository.

## 📞 **Support**

- **Railway**: Check their [documentation](https://docs.railway.app/)
- **Docker**: Check [Docker documentation](https://docs.docker.com/)

---

**Happy Deploying with Docker! 🐳🚀**
