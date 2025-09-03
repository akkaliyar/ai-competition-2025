# Railway Deployment Guide

## Prerequisites
- Railway account (https://railway.app)
- GitHub repository with your code
- MySQL database (can be provisioned through Railway)

## Step 1: Connect Your Repository
1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your repository
5. Select the branch you want to deploy

## Step 2: Configure Environment Variables
In your Railway project dashboard, go to the "Variables" tab and add:

### Required Variables:
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

### Database Variables:
If you're using Railway's MySQL service:
1. Add a MySQL service to your project
2. Railway will automatically provide the connection details
3. Copy these values to your environment variables

## Step 3: Build Configuration
Railway will automatically detect the `railway.toml` file and use:
- **Builder**: Nixpacks (automatic Node.js detection)
- **Start Command**: `npm run start:prod`
- **Health Check**: `/health` endpoint
- **Port**: 3001

## Step 4: Database Setup
1. Ensure your MySQL database has the required tables
2. Run the database setup script if needed
3. Verify the `parsed_files` table has all required columns:
   - `extractedText` (MEDIUMTEXT)
   - `structuredTableData` (MEDIUMTEXT)

## Step 5: Deploy
1. Railway will automatically build and deploy your application
2. Monitor the build logs for any errors
3. Check the health endpoint: `https://your-app.railway.app/health`

### If Build Fails:
1. Go to your project's "Deployments" tab
2. Click on the failed deployment
3. Click "Clear Cache" to remove build cache
4. Redeploy the project

## Step 6: Custom Domain (Optional)
1. Go to your project's "Settings" tab
2. Click "Custom Domains"
3. Add your domain and configure DNS

## Troubleshooting

### Build Failures
- Check that all dependencies are in `package.json`
- Ensure `npm run build` works locally
- Verify Node.js version compatibility
- If `npm ci` fails, try clearing Railway's build cache
- Check the build logs for specific error messages

### Common Build Issues
1. **npm ci fails**: 
   - Clear Railway build cache
   - Ensure package-lock.json is committed
   - Check for dependency conflicts

2. **Build script errors**:
   - Verify build.sh has execute permissions
   - Check TypeScript compilation errors
   - Ensure all required files are present

3. **Missing dependencies**:
   - Verify all dependencies are in package.json
   - Check for peer dependency issues
   - Ensure devDependencies are not required at runtime

### Runtime Errors
- Check application logs in Railway dashboard
- Verify environment variables are set correctly
- Ensure database connectivity

### Health Check Failures
- Verify the `/health` endpoint is working
- Check if the application is starting correctly
- Review startup logs

## Monitoring
- Use Railway's built-in logging
- Monitor the health endpoint
- Set up alerts for failed deployments

## Scaling
- Railway automatically scales based on traffic
- You can manually adjust resources in the dashboard
- Consider using Railway's autoscaling features
