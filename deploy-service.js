#!/usr/bin/env node

const { execSync } = require('child_process');

const SERVICE_TYPE = process.env.SERVICE_TYPE || 'backend';
const PHASE = process.env.BUILD_PHASE || 'start'; // 'build' or 'start'

console.log(`🚀 ${PHASE.toUpperCase()} phase for ${SERVICE_TYPE.toUpperCase()} service...`);

function runCommand(command, cwd = '.') {
  try {
    execSync(command, { 
      stdio: 'inherit', 
      cwd: cwd,
      env: { ...process.env }
    });
  } catch (error) {
    console.error(`❌ Command failed: ${command}`);
    process.exit(1);
  }
}

if (PHASE === 'build') {
  // Build phase
  if (SERVICE_TYPE === 'frontend') {
    console.log('📦 Installing and building frontend...');
    runCommand('npm ci', 'frontend');
    runCommand('npm run build', 'frontend');
  } else {
    console.log('📦 Installing and building backend...');
    runCommand('npm ci', 'backend');
    runCommand('npm run build', 'backend');
  }
} else {
  // Start phase
  if (SERVICE_TYPE === 'frontend') {
    console.log('🚀 Starting frontend server...');
    runCommand('npm start', 'frontend');
  } else {
    console.log('🚀 Starting backend server...');
    runCommand('npm start', 'backend');
  }
}