const fs = require('fs');
const path = require('path');

function removeConsoleStatements(filePath) {
  try {
    let content = fs.readFileSync(filePath, 'utf8');
    const originalContent = content;
    
    // Remove console.log, console.error, console.warn, console.info statements
    content = content.replace(/console\.(log|error|warn|info|debug)\s*\([^)]*\);?\s*/g, '');
    
    // Remove console statements with template literals
    content = content.replace(/console\.(log|error|warn|info|debug)\s*`[^`]*`;?\s*/g, '');
    
    // Remove console statements with multiple arguments
    content = content.replace(/console\.(log|error|warn|info|debug)\s*\([^;]*\);?\s*/g, '');
    
    if (content !== originalContent) {
      fs.writeFileSync(filePath, content, 'utf8');
      console.log(`✅ Removed console statements from: ${filePath}`);
    } else {
      console.log(`ℹ️  No console statements found in: ${filePath}`);
    }
  } catch (error) {
    console.error(`❌ Error processing ${filePath}:`, error.message);
  }
}

function processDirectory(dirPath) {
  const files = fs.readdirSync(dirPath);
  
  files.forEach(file => {
    const filePath = path.join(dirPath, file);
    const stat = fs.statSync(filePath);
    
    if (stat.isDirectory()) {
      processDirectory(filePath);
    } else if (file.endsWith('.ts') || file.endsWith('.js')) {
      removeConsoleStatements(filePath);
    }
  });
}

// Start processing from src directory
const srcPath = path.join(__dirname, 'src');
if (fs.existsSync(srcPath)) {
  console.log('🔍 Removing console statements from backend files...');
  processDirectory(srcPath);
  console.log('🎉 Console removal completed!');
} else {
  console.log('❌ src directory not found');
}
