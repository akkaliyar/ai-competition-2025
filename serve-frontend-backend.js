// Server that serves both frontend and backend from same domain
const express = require('express');
const path = require('path');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const PORT = process.env.PORT || 8080;

console.log('🚀 Starting combined frontend + backend server...');

// Serve static files from frontend build directory
const frontendBuildPath = path.join(__dirname, 'frontend', 'build');
console.log('📁 Frontend build path:', frontendBuildPath);

// Check if frontend build exists
const fs = require('fs');
if (fs.existsSync(frontendBuildPath)) {
  console.log('✅ Frontend build found, serving static files');
  app.use(express.static(frontendBuildPath));
} else {
  console.log('❌ Frontend build not found at:', frontendBuildPath);
}

// Health check endpoints
app.get('/healthz', (req, res) => {
  console.log('🔍 Health check requested');
  res.status(200).send('OK');
});

app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    service: 'ai-crm-combined',
    frontend: fs.existsSync(frontendBuildPath) ? 'available' : 'not_built',
    backend: 'running'
  });
});

// API routes - proxy to backend or handle directly
app.use('/api', (req, res, next) => {
  console.log(`📡 API request: ${req.method} ${req.path}`);
  
  // Simple API responses for now
  if (req.path === '/files' && req.method === 'GET') {
    res.json({ success: true, data: [], message: 'Files endpoint - frontend integrated' });
  } else {
    res.status(404).json({ error: 'API endpoint not found', path: req.path });
  }
});

// Catch-all handler: serve index.html for React Router
app.get('*', (req, res) => {
  const indexPath = path.join(frontendBuildPath, 'index.html');
  
  if (fs.existsSync(indexPath)) {
    console.log(`📄 Serving React app for: ${req.path}`);
    res.sendFile(indexPath);
  } else {
    console.log(`❌ Frontend not built, serving API info for: ${req.path}`);
    res.json({
      message: 'AI CRM - Frontend + Backend',
      status: 'running',
      note: 'Frontend not built yet. Run build process first.',
      endpoints: ['/healthz', '/health', '/api/files'],
      frontend: 'Run: npm run build:frontend'
    });
  }
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Combined server running on port ${PORT}`);
  console.log(`🔗 Access at: http://0.0.0.0:${PORT}`);
  console.log(`📱 Frontend: Served from ${frontendBuildPath}`);
  console.log(`📡 API: Available at /api/*`);
});