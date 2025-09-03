# 🗄️ MySQL Database Connection Guide for Railway

## 🎯 Method 1: Railway Dashboard (Recommended)

### **Step 1: Create MySQL Database**

1. Go to Railway dashboard: https://railway.app
2. Open your project
3. Click **"+ New Service"**
4. Select **"Database"** → **"MySQL"**
5. Railway provisions MySQL automatically

### **Step 2: Get Database Credentials**

1. Click on your **MySQL service**
2. Go to **"Variables"** tab
3. Copy these values:

```
MYSQLHOST=xxxxxx.railway.app
MYSQL_ROOT_PASSWORD=your_generated_password
MYSQLDATABASE=railway
MYSQLPORT=3306
MYSQLUSER=root
```

### **Step 3: Configure Backend Service**

1. Go to your **Backend service**
2. Click **"Variables"** tab
3. Add these environment variables:

```bash
# Required
NODE_ENV=production
SERVICE_TYPE=backend
PORT=3001

# Database Connection
DATABASE_URL=mysql://root:your_generated_password@xxxxxx.railway.app:3306/railway
DB_HOST=xxxxxx.railway.app
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=your_generated_password
DB_NAME=railway
```

### **Step 4: Example with Real Values**

If your MySQL service shows:
```
MYSQLHOST=mysql.railway.internal
MYSQL_ROOT_PASSWORD=abc123xyz789
MYSQLDATABASE=railway
```

Then set in backend:
```
DATABASE_URL=mysql://root:abc123xyz789@mysql.railway.internal:3306/railway
DB_HOST=mysql.railway.internal
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=abc123xyz789
DB_NAME=railway
```

## 🐳 Method 2: Docker Deployment

### **Option A: Docker with Railway**

1. Use the provided `Dockerfile` and `railway-docker.toml`
2. Deploy to Railway:

```bash
# Copy Docker config
cp railway-docker.toml railway.toml

# Deploy to Railway
railway up
```

### **Option B: Local Docker Development**

```bash
# Start all services (MySQL + Backend + Frontend)
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

## 🔧 Method 3: Manual Database Setup

### **Step 1: Create Database**

Connect to MySQL and run:

```sql
CREATE DATABASE ai_crm;
USE ai_crm;

-- Your backend will auto-create tables
-- Or run your migration scripts here
```

### **Step 2: Update Connection String**

Set environment variable:
```bash
DATABASE_URL=mysql://username:password@host:port/ai_crm
```

## ✅ Verification Steps

### **Test Database Connection**

1. **Health Check**: `https://your-backend.railway.app/healthz`
   - Should return: `OK`

2. **API Status**: `https://your-backend.railway.app/`
   - Should return JSON with status

3. **Database Test**: `https://your-backend.railway.app/health`
   - Should show database status

### **Expected Logs**

Success logs should show:
```
🔧 Configuring database connection...
DATABASE_URL exists: true
📡 Using DATABASE_URL for connection
✅ AI CRM Backend successfully started on port 3001
✅ Database connection established
```

## 🚨 Common Issues & Solutions

### **Issue 1: Connection Refused**
```
ERROR [TypeOrmModule] Unable to connect to the database
AggregateError [ECONNREFUSED]
```

**Solution:**
- Check `DATABASE_URL` format
- Verify MySQL service is running
- Ensure host/port are correct

### **Issue 2: Authentication Failed**
```
ERROR [TypeOrmModule] Access denied for user 'root'@'host'
```

**Solution:**
- Check password in `DATABASE_URL`
- Verify `MYSQL_ROOT_PASSWORD` value

### **Issue 3: Database Not Found**
```
ERROR [TypeOrmModule] Unknown database 'ai_crm'
```

**Solution:**
- Use `railway` as database name (Railway default)
- Or create `ai_crm` database manually

## 📋 Environment Variables Checklist

Backend service must have:
- ✅ `NODE_ENV=production`
- ✅ `SERVICE_TYPE=backend`
- ✅ `PORT=3001`
- ✅ `DATABASE_URL=mysql://...`
- ✅ `DB_HOST=...`
- ✅ `DB_PASSWORD=...`

## 🎯 Final Verification

Your deployment is successful when:

1. ✅ **Health check passes**: `/healthz` returns 200 OK
2. ✅ **Backend logs show**: Database connection established
3. ✅ **API responds**: All endpoints return proper responses
4. ✅ **Database queries work**: Can read/write data

🎉 **Congratulations! Your AI CRM is now deployed with MySQL on Railway!**