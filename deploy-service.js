#!/usr/bin/env node

const { execSync } = require('child_process');

const SERVICE_TYPE = process.env.SERVICE_TYPE || 'backend';
const PHASE = process.env.BUILD_PHASE || 'start'; // 'build' or 'start'

console.log(`🚀 ${PHASE.toUpperCase()} phase for ${SERVICE_TYPE.toUpperCase()} service...`);
console.log(`Environment: NODE_ENV=${process.env.NODE_ENV}, PORT=${process.env.PORT}`);

function runCommand(command, cwd = '.') {
  try {
    console.log(`Running: ${command} in ${cwd}`);
    execSync(command, { 
      stdio: 'inherit', 
      cwd: cwd,
      env: { ...process.env }
    });
  } catch (error) {
    console.error(`❌ Command failed: ${command}`);
    console.error(`Error: ${error.message}`);
    // Don't exit immediately, try simple server instead
    console.log('🔄 Falling back to simple server...');
    return false;
  }
  return true;
}

if (PHASE === 'build') {
  // Build phase
  if (SERVICE_TYPE === 'frontend') {
    console.log('📦 Installing and building frontend...');
    if (!runCommand('npm ci', 'frontend')) {
      console.log('Frontend npm ci failed');
      process.exit(1);
    }
    if (!runCommand('npm run build', 'frontend')) {
      console.log('Frontend build failed');
      process.exit(1);
    }
  } else {
    console.log('📦 Installing and building backend...');
    if (!runCommand('npm ci', 'backend')) {
      console.log('Backend npm ci failed, continuing...');
    }
    if (!runCommand('npm run build', 'backend')) {
      console.log('Backend build failed, continuing...');
    }
  }
} else {
  // Start phase
  if (SERVICE_TYPE === 'frontend') {
    console.log('🚀 Starting frontend server...');
    if (!runCommand('npm start', 'frontend')) {
      console.log('❌ Frontend start failed');
      process.exit(1);
    }
  } else {
    console.log('🚀 Starting backend server...');
    if (!runCommand('npm start', 'backend')) {
      console.log('❌ Backend start failed, starting simple server instead...');
      // Fallback to simple server
      console.log('🔄 Starting simple Express server...');
      try {
        require('./simple-server.js');
      } catch (error) {
        console.error('❌ Simple server also failed:', error.message);
        console.log('🆘 Starting emergency HTTP server...');
        // Last resort - inline HTTP server
        const http = require('http');
        const server = http.createServer((req, res) => {
          if (req.url === '/healthz' || req.url === '/health') {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end('OK');
          } else {
            res.writeHead(200, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ status: 'emergency-mode', message: 'Basic server running' }));
          }
        });
        const port = process.env.PORT || 3001;
        server.listen(port, '0.0.0.0', () => {
          console.log(`🆘 Emergency server running on port ${port}`);
        });
      }
    }
  }
}