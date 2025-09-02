import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  // Enable CORS for frontend communication - Development settings
  app.enableCors({
    origin: true, // Allow all origins in development
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS', 'HEAD'],
    allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept', 'Origin', 'Access-Control-Allow-Headers'],
    credentials: true,
    preflightContinue: false,
    optionsSuccessStatus: 204,
  });

  // Global validation pipe
  app.useGlobalPipes(new ValidationPipe());

  // Start server on port 3001
  await app.listen(3001);
  // Server started successfully
}

bootstrap();
