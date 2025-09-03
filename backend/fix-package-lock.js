const { execSync } = require('child_process');
const fs = require('fs');

console.log('🔧 Fixing package-lock.json synchronization...');

try {
  // Remove existing package-lock.json and node_modules
  console.log('🧹 Removing existing lock file and node_modules...');
  if (fs.existsSync('package-lock.json')) {
    fs.unlinkSync('package-lock.json');
    console.log('✅ Removed package-lock.json');
  }
  
  if (fs.existsSync('node_modules')) {
    fs.rmSync('node_modules', { recursive: true, force: true });
    console.log('✅ Removed node_modules');
  }

  // Install dependencies to regenerate package-lock.json
  console.log('📦 Installing dependencies to regenerate package-lock.json...');
  execSync('npm install', { stdio: 'inherit' });

  // Verify the lock file was created
  if (fs.existsSync('package-lock.json')) {
    console.log('✅ package-lock.json regenerated successfully');
    
    // Show some stats
    const stats = fs.statSync('package-lock.json');
    console.log(`📊 Lock file size: ${(stats.size / 1024).toFixed(2)} KB`);
  } else {
    console.log('❌ Failed to generate package-lock.json');
    process.exit(1);
  }

  console.log('🎉 Package lock file fixed successfully!');

} catch (error) {
  console.error('❌ Error fixing package-lock.json:', error.message);
  process.exit(1);
}
