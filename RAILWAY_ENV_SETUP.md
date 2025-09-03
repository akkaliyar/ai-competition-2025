# Railway Environment Variables Setup

## 🔧 Manual Environment Variable Configuration

Since the `${{}}` interpolation isn't working, you need to set these environment variables manually in Railway's dashboard:

### Backend Service Environment Variables:

```
NODE_ENV=production
SERVICE_TYPE=backend
PORT=3001

# Database Configuration - SET THESE MANUALLY:
DATABASE_URL=mysql://root:paeKlUzCJuehwAdPynSqtyWORUXaQmKl@[PRIVATE_DOMAIN]:3306/ai_crm
DB_HOST=[RAILWAY_PRIVATE_DOMAIN_VALUE]
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=paeKlUzCJuehwAdPynSqtyWORUXaQmKl
DB_NAME=ai_crm
```

## 📋 How to Set Variables in Railway:

1. Go to your Railway project dashboard
2. Click on your backend service
3. Go to "Variables" tab
4. Add each variable manually:

### Required Variables:

- **NODE_ENV**: `production`
- **SERVICE_TYPE**: `backend`
- **PORT**: `3001`
- **DB_HOST**: Copy the value from `RAILWAY_PRIVATE_DOMAIN`
- **DB_PORT**: `3306`
- **DB_USERNAME**: `root`
- **DB_PASSWORD**: `paeKlUzCJuehwAdPynSqtyWORUXaQmKl`
- **DB_NAME**: `ai_crm`

### Database URL:
**DATABASE_URL**: `mysql://root:paeKlUzCJuehwAdPynSqtyWORUXaQmKl@[PRIVATE_DOMAIN]:3306/ai_crm`

Replace `[PRIVATE_DOMAIN]` with the actual value from your Railway MySQL service.

## 🎯 Where to Find Railway Private Domain:

1. Go to your MySQL database service in Railway
2. Look for `RAILWAY_PRIVATE_DOMAIN` variable
3. Copy its value (usually looks like: `mysql.railway.internal` or similar)
4. Use that value in the DATABASE_URL and DB_HOST

## ✅ Expected Result:

After setting these variables manually, your backend should connect successfully to the database.