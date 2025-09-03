# 🚀 Complete Railway Deployment Guide with MySQL

## 📋 Prerequisites

- GitHub repository with your AI CRM code
- Railway account (https://railway.app)
- Basic understanding of environment variables

## 🎯 Step-by-Step Deployment

### **Step 1: Create Railway Project**

1. Go to https://railway.app
2. Click **"Start a New Project"**
3. Select **"Deploy from GitHub repo"**
4. Connect your GitHub account
5. Select your AI CRM repository

### **Step 2: Add MySQL Database**

1. In your Railway project dashboard
2. Click **"+ New Service"**
3. Select **"Database"**
4. Choose **"MySQL"**
5. Railway will automatically provision a MySQL database

### **Step 3: Deploy Backend Service**

1. Click **"+ New Service"**
2. Select **"GitHub Repo"**
3. Choose your repository again
4. **Important**: Set **Root Directory** to `.` (current setup)
5. Railway will auto-detect Node.js and start building

### **Step 4: Configure Environment Variables**

Go to your **Backend Service** → **Variables** tab and add:

```
NODE_ENV=production
SERVICE_TYPE=backend
PORT=3001
```

**Database Variables** (get these from your MySQL service):
```
DATABASE_URL=mysql://root:[PASSWORD]@[HOST]:3306/railway
DB_HOST=[MYSQL_HOST]
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=[MYSQL_PASSWORD]
DB_NAME=railway
```

### **Step 5: Get MySQL Connection Details**

1. Go to your **MySQL Database service**
2. Click **"Variables"** tab
3. Copy these values:
   - `MYSQLHOST` → use for `DB_HOST`
   - `MYSQL_ROOT_PASSWORD` → use for `DB_PASSWORD`
   - `MYSQLDATABASE` → use for `DB_NAME`

4. Create `DATABASE_URL`:
   ```
   mysql://root:[MYSQL_ROOT_PASSWORD]@[MYSQLHOST]:3306/[MYSQLDATABASE]
   ```

### **Step 6: Example Configuration**

If your MySQL variables are:
```
MYSQLHOST=viaduct-production-db.railway.app
MYSQL_ROOT_PASSWORD=abc123xyz
MYSQLDATABASE=railway
```

Then set these in your backend service:
```
DATABASE_URL=mysql://root:abc123xyz@viaduct-production-db.railway.app:3306/railway
DB_HOST=viaduct-production-db.railway.app
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=abc123xyz
DB_NAME=railway
```

### **Step 7: Deploy Frontend (Optional)**

1. Click **"+ New Service"**
2. Select **"GitHub Repo"**
3. Choose your repository
4. Set **Root Directory** to `frontend`
5. Add environment variables:
   ```
   NODE_ENV=production
   REACT_APP_API_URL=https://[your-backend-service].railway.app
   ```

### **Step 8: Verify Deployment**

1. **Backend Health Check**: `https://[backend-service].railway.app/healthz`
2. **Backend API Info**: `https://[backend-service].railway.app/`
3. **Frontend**: `https://[frontend-service].railway.app/`

## 🔍 Troubleshooting

### Common Issues:

1. **Database Connection Failed**:
   - Verify environment variables are correct
   - Check MySQL service is running
   - Ensure DATABASE_URL format is correct

2. **Health Check Failed**:
   - Our fallback system should prevent this
   - Check service logs for errors

3. **Build Failed**:
   - Check if all dependencies are in package.json
   - Verify Node.js version compatibility

## 📊 Expected Results

- **Backend URL**: `https://your-backend.railway.app`
- **Health Check**: Returns "OK"
- **Database**: Connected and functional
- **API Endpoints**: Available for frontend consumption