# 🔧 Alternative: Update NestJS Backend to Serve Frontend

If you prefer to modify your existing NestJS backend to serve frontend files:

## 📝 Update backend/src/main.ts

Add static file serving to your NestJS application:

```typescript
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { join } from 'path';
import { NestExpressApplication } from '@nestjs/platform-express';

async function bootstrap() {
  try {
    console.log('🚀 Starting AI CRM Backend...');
    
    const app = await NestFactory.create<NestExpressApplication>(AppModule, {
      logger: ['error', 'warn', 'log'],
    });
    
    // Enable CORS
    app.enableCors({
      origin: true,
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS', 'HEAD'],
      allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept', 'Origin', 'Access-Control-Allow-Headers'],
      credentials: true,
      preflightContinue: false,
      optionsSuccessStatus: 204,
    });

    // Global validation pipe
    app.useGlobalPipes(new ValidationPipe());

    // Serve static files from frontend build
    const frontendPath = join(__dirname, '..', '..', 'frontend', 'build');
    console.log('📁 Serving frontend from:', frontendPath);
    
    app.useStaticAssets(frontendPath, {
      prefix: '/',
    });

    // Serve index.html for all non-API routes (React Router support)
    app.use('*', (req, res, next) => {
      if (req.originalUrl.startsWith('/api') || req.originalUrl.startsWith('/healthz')) {
        next();
      } else {
        res.sendFile(join(frontendPath, 'index.html'));
      }
    });

    // Start server
    const port = process.env.PORT ? Number(process.env.PORT) : 3001;
    await app.listen(port, '0.0.0.0');
    console.log(`✅ AI CRM Backend + Frontend running on port ${port}`);
    console.log(`🔗 Frontend: http://0.0.0.0:${port}/`);
    console.log(`📡 API: http://0.0.0.0:${port}/api/`);
  } catch (error) {
    console.error('❌ Failed to start AI CRM:', error);
    process.exit(1);
  }
}

bootstrap().catch(error => {
  console.error('❌ Bootstrap failed:', error);
  process.exit(1);
});
```

## 📦 Update backend/package.json

Add frontend build step:

```json
{
  "scripts": {
    "build": "nest build && npm run build:frontend",
    "build:frontend": "cd ../frontend && npm ci && npm run build && cp -r build ../backend/dist/",
    "start": "npm run build && npm run start:prod",
    "start:prod": "node dist/main.js"
  }
}
```

This approach integrates frontend serving directly into your NestJS application.