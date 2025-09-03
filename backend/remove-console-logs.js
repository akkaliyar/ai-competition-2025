const fs = require('fs');
const path = require('path');

// Function to remove console.log statements from a file
function removeConsoleLogs(filePath) {
  try {
    let content = fs.readFileSync(filePath, 'utf8');
    const originalContent = content;
    
    // Remove console.log statements with various patterns
    content = content.replace(/console\.log\([^)]*\);?\s*/g, '');
    content = content.replace(/console\.log\(`[^`]*`\);?\s*/g, '');
    content = content.replace(/console\.log\([^;]*\);?\s*/g, '');
    
    // Remove empty lines that might be left
    content = content.replace(/\n\s*\n\s*\n/g, '\n\n');
    
    if (content !== originalContent) {
      fs.writeFileSync(filePath, content, 'utf8');
      console.log(`✅ Cleaned: ${filePath}`);
      return true;
    } else {
      console.log(`⏭️  No changes: ${filePath}`);
      return false;
    }
  } catch (error) {
    console.error(`❌ Error processing ${filePath}:`, error.message);
    return false;
  }
}

// Function to process all TypeScript files in a directory
function processDirectory(dirPath) {
  const files = fs.readdirSync(dirPath);
  let cleanedCount = 0;
  
  files.forEach(file => {
    const filePath = path.join(dirPath, file);
    const stat = fs.statSync(filePath);
    
    if (stat.isDirectory()) {
      // Recursively process subdirectories
      cleanedCount += processDirectory(filePath);
    } else if (file.endsWith('.ts') || file.endsWith('.tsx')) {
      // Process TypeScript files
      if (removeConsoleLogs(filePath)) {
        cleanedCount++;
      }
    }
  });
  
  return cleanedCount;
}

// Main execution
console.log('🧹 Removing console.log statements from backend services...');
console.log('========================================================');

const backendSrcPath = path.join(__dirname, 'src');
const cleanedCount = processDirectory(backendSrcPath);

console.log('\n🎉 Console.log cleanup completed!');
console.log(`📊 Cleaned ${cleanedCount} files`);
console.log('\n📋 Next steps:');
console.log('1. Test the build: npm run build');
console.log('2. Commit changes: git add . && git commit -m "Remove console.log statements"');
console.log('3. Push to GitHub: git push');
