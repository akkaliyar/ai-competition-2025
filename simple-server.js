// Ultra-simple Express server for debugging
const express = require('express');
const app = express();

const PORT = process.env.PORT || 3001;

console.log('🚀 Starting simple server...');

// Health endpoints
app.get('/healthz', (req, res) => {
  console.log('Health check requested');
  res.status(200).send('OK');
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.get('/ping', (req, res) => {
  res.status(200).send('pong');
});

app.get('/', (req, res) => {
  res.status(200).json({ 
    message: 'AI CRM Backend - Simple Mode',
    status: 'running',
    timestamp: new Date().toISOString(),
    port: PORT
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Simple server running on port ${PORT}`);
  console.log(`🔗 Health check: http://0.0.0.0:${PORT}/healthz`);
});