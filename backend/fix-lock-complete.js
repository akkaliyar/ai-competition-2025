const { execSync } = require('child_process');
const fs = require('fs');

console.log('🔧 Complete Package Lock File Fix...');
console.log('=====================================');

try {
  // Step 1: Remove all lock files and node_modules
  console.log('\n🧹 Step 1: Cleaning up...');
  
  const filesToRemove = [
    'package-lock.json',
    'npm-shrinkwrap.json',
    'yarn.lock',
    'pnpm-lock.yaml'
  ];
  
  filesToRemove.forEach(file => {
    if (fs.existsSync(file)) {
      fs.unlinkSync(file);
      console.log(`✅ Removed ${file}`);
    }
  });
  
  if (fs.existsSync('node_modules')) {
    fs.rmSync('node_modules', { recursive: true, force: true });
    console.log('✅ Removed node_modules');
  }
  
  // Step 2: Clear npm cache
  console.log('\n🗑️ Step 2: Clearing npm cache...');
  try {
    execSync('npm cache clean --force', { stdio: 'inherit' });
    console.log('✅ npm cache cleared');
  } catch (error) {
    console.log('⚠️ Could not clear npm cache, continuing...');
  }
  
  // Step 3: Install dependencies fresh
  console.log('\n📦 Step 3: Installing dependencies fresh...');
  execSync('npm install', { stdio: 'inherit' });
  
  // Step 4: Verify the lock file
  console.log('\n✅ Step 4: Verifying package-lock.json...');
  if (fs.existsSync('package-lock.json')) {
    const stats = fs.statSync('package-lock.json');
    console.log(`✅ package-lock.json created successfully`);
    console.log(`📊 Size: ${(stats.size / 1024).toFixed(2)} KB`);
    
    // Check if it's a valid JSON
    try {
      const content = fs.readFileSync('package-lock.json', 'utf8');
      JSON.parse(content);
      console.log('✅ package-lock.json is valid JSON');
    } catch (error) {
      console.log('❌ package-lock.json is not valid JSON');
      process.exit(1);
    }
  } else {
    console.log('❌ Failed to create package-lock.json');
    process.exit(1);
  }
  
  // Step 5: Test build
  console.log('\n🧪 Step 5: Testing build...');
  execSync('npm run build', { stdio: 'inherit' });
  console.log('✅ Build successful!');
  
  console.log('\n🎉 Package lock file completely fixed!');
  console.log('📋 Next steps:');
  console.log('1. Commit the new package-lock.json');
  console.log('2. Push to GitHub');
  console.log('3. Deploy on Railway');
  
} catch (error) {
  console.error('\n❌ Error during fix:', error.message);
  process.exit(1);
}
