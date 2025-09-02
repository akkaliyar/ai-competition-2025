/**
 * Test script to diagnose file processing issues
 * Run with: node test-processing.js
 */

console.log('🔧 File Processing Diagnostic Tool');
console.log('==================================\n');

// Test 1: Check dependencies
console.log('1️⃣ Testing Dependencies...');
try {
  const tesseract = require('tesseract.js');
  console.log('✅ Tesseract.js loaded successfully');
  console.log('   - Version:', tesseract.version || 'Unknown');
  
  const pdfParse = require('pdf-parse');
  console.log('✅ pdf-parse loaded successfully');
  
  const XLSX = require('xlsx');
  console.log('✅ xlsx loaded successfully');
  console.log('   - Version:', XLSX.version || 'Unknown');
  
} catch (error) {
  console.log('❌ Dependency loading failed:', error.message);
  process.exit(1);
}

// Test 2: Check file system permissions
console.log('\n2️⃣ Testing File System...');
const fs = require('fs');
const path = require('path');

try {
  const uploadsDir = path.join(__dirname, 'uploads');
  
  // Create uploads directory if it doesn't exist
  if (!fs.existsSync(uploadsDir)) {
    fs.mkdirSync(uploadsDir, { recursive: true });
    console.log('✅ Created uploads directory');
  } else {
    console.log('✅ Uploads directory exists');
  }
  
  // Test write permissions
  const testFile = path.join(uploadsDir, 'test-write.txt');
  fs.writeFileSync(testFile, 'test');
  fs.unlinkSync(testFile);
  console.log('✅ Write permissions OK');
  
} catch (error) {
  console.log('❌ File system test failed:', error.message);
}

// Test 3: Test OCR with a simple buffer
console.log('\n3️⃣ Testing OCR Processing...');
async function testOCR() {
  try {
    const Tesseract = require('tesseract.js');
    
    // Create a simple test image buffer (1x1 white pixel PNG)
    const testImageBuffer = Buffer.from([
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
      0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
      0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
      0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
      0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
      0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
    ]);
    
    console.log('   Starting Tesseract test...');
    const result = await Tesseract.recognize(testImageBuffer, 'eng');
    console.log('✅ Tesseract OCR test completed');
    console.log('   - Confidence:', result.data.confidence || 0);
    console.log('   - Text length:', result.data.text.length);
    
  } catch (error) {
    console.log('❌ OCR test failed:', error.message);
    if (error.message.includes('timeout')) {
      console.log('   💡 This might be normal for a test image');
    }
  }
}

// Test 4: Environment variables
console.log('\n4️⃣ Testing Environment...');
const requiredEnvVars = ['DB_HOST', 'DB_USERNAME', 'DB_PASSWORD', 'DB_NAME'];
requiredEnvVars.forEach(varName => {
  const value = process.env[varName];
  if (value) {
    console.log(`✅ ${varName}: ${varName.includes('PASSWORD') ? '[HIDDEN]' : value}`);
  } else {
    console.log(`⚠️  ${varName}: Not set (will use default)`);
  }
});

// Test 5: Database connection (if TypeORM is available)
console.log('\n5️⃣ Testing Database Connection...');
async function testDatabase() {
  try {
    const { DataSource } = require('typeorm');
    const { ParsedFile } = require('./src/entities/parsed-file.entity');
    
    const dataSource = new DataSource({
      type: 'mysql',
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT) || 3306,
      username: process.env.DB_USERNAME || 'root',
      password: process.env.DB_PASSWORD || '',
      database: process.env.DB_NAME || 'ai_crm',
      entities: [ParsedFile],
      synchronize: false,
    });
    
    await dataSource.initialize();
    console.log('✅ Database connection successful');
    
    const count = await dataSource.getRepository(ParsedFile).count();
    console.log(`   - Records in parsed_files: ${count}`);
    
    await dataSource.destroy();
    
  } catch (error) {
    console.log('❌ Database connection failed:', error.message);
    console.log('   💡 Make sure MySQL is running and database exists');
  }
}

// Run async tests
async function runTests() {
  await testOCR();
  await testDatabase();
  
  console.log('\n🎯 Diagnostic Complete!');
  console.log('\nNext Steps:');
  console.log('1. Start backend: npm run start:dev');
  console.log('2. Start frontend: cd ../frontend && npm start');
  console.log('3. Test file upload at http://localhost:3000');
  console.log('4. Check backend logs for processing details');
}

runTests().catch(console.error);

