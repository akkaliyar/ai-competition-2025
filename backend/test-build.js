const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🧪 Testing build process...');

try {
  // Check if dist directory exists and clean it
  if (fs.existsSync('dist')) {
    console.log('🧹 Cleaning dist directory...');
    fs.rmSync('dist', { recursive: true, force: true });
  }

  // Install dependencies
  console.log('📦 Installing dependencies...');
  execSync('npm ci', { stdio: 'inherit' });

  // Build the application
  console.log('🏗️ Building application...');
  execSync('npm run build', { stdio: 'inherit' });

  // Check build output
  console.log('📋 Checking build output...');
  if (fs.existsSync('dist/main.js')) {
    console.log('✅ main.js exists');
  } else {
    console.log('❌ main.js missing');
  }

  if (fs.existsSync('dist/app.module.js')) {
    console.log('✅ app.module.js exists');
  } else {
    console.log('❌ app.module.js missing');
  }

  // List all files in dist
  console.log('\n📁 Build output:');
  const files = fs.readdirSync('dist');
  files.forEach(file => {
    const stats = fs.statSync(path.join('dist', file));
    if (stats.isDirectory()) {
      console.log(`  📁 ${file}/`);
      const subFiles = fs.readdirSync(path.join('dist', file));
      subFiles.forEach(subFile => {
        console.log(`    📄 ${subFile}`);
      });
    } else {
      console.log(`  📄 ${file}`);
    }
  });

  console.log('\n🎉 Build test completed successfully!');

} catch (error) {
  console.error('❌ Build test failed:', error.message);
  process.exit(1);
}
