import { Controller, Get } from '@nestjs/common';

@Controller()
export class HealthController {
  @Get('health')
  health() {
    return {
      status: 'ok',
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      service: 'ai-crm-backend',
      environment: process.env.NODE_ENV || 'development'
    };
  }

  @Get()
  root() {
    return {
      message: 'AI CRM Backend API',
      status: 'running',
      timestamp: new Date().toISOString(),
      version: '1.0.0'
    };
  }
}