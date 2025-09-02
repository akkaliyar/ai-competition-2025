// Test script to verify the enhanced database structure
const mysql = require('mysql2/promise');

async function testDatabase() {
  console.log('🔍 Testing Enhanced AI CRM Database Structure...\n');

  try {
    // Load environment variables
    require('dotenv').config();

    const connection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      port: process.env.DB_PORT || 3306,
      user: process.env.DB_USERNAME || 'root',
      password: process.env.DB_PASSWORD || '',
      database: process.env.DB_NAME || 'ai_crm',
    });

    console.log('✅ Database connection successful\n');

    // Check table structures
    const tables = ['parsed_files', 'ocr_results', 'file_metadata', 'table_extractions'];
    
    for (const table of tables) {
      console.log(`📋 Table: ${table}`);
      try {
        const [columns] = await connection.execute(`DESCRIBE ${table}`);
        console.log(`   Columns: ${columns.length}`);
        
        // Show key columns
        const keyColumns = columns.filter(col => 
          ['id', 'parsedFileId', 'fileType', 'processingStatus', 'originalName', 'extractedText', 'ocrEngine', 'tableName'].includes(col.Field)
        );
        
        keyColumns.forEach(col => {
          console.log(`   - ${col.Field} (${col.Type})`);
        });
        
        // Check record count
        const [countResult] = await connection.execute(`SELECT COUNT(*) as count FROM ${table}`);
        console.log(`   Records: ${countResult[0].count}\n`);
        
      } catch (error) {
        console.log(`   ❌ Error: ${error.message}\n`);
      }
    }

    // Test views
    console.log('📊 Testing Views:');
    try {
      const [viewResult] = await connection.execute('SELECT COUNT(*) as count FROM v_file_summary');
      console.log(`   v_file_summary: ${viewResult[0].count} records`);
    } catch (error) {
      console.log(`   v_file_summary: ❌ ${error.message}`);
    }

    try {
      const [statsResult] = await connection.execute('SELECT COUNT(*) as count FROM v_processing_stats');
      console.log(`   v_processing_stats: ${statsResult[0].count} records\n`);
    } catch (error) {
      console.log(`   v_processing_stats: ❌ ${error.message}\n`);
    }

    // Show some sample data if available
    try {
      const [files] = await connection.execute(`
        SELECT id, originalName, fileType, processingStatus, 
               characterCount, wordCount, createdAt
        FROM parsed_files 
        ORDER BY createdAt DESC 
        LIMIT 5
      `);
      
      if (files.length > 0) {
        console.log('📁 Recent Files:');
        files.forEach(file => {
          console.log(`   ${file.id}: ${file.originalName} (${file.fileType}) - ${file.processingStatus}`);
        });
        console.log('');
      }
    } catch (error) {
      console.log(`Files query error: ${error.message}\n`);
    }

    await connection.end();
    
    console.log('✅ Database structure test completed successfully!');
    console.log('\n📝 Next Steps:');
    console.log('1. Start the backend server: npm run start:dev');
    console.log('2. Upload test files to verify the enhanced storage');
    console.log('3. Check the database for detailed metadata records');
    
  } catch (error) {
    console.error(`❌ Database test failed: ${error.message}`);
    console.log('\n💡 Troubleshooting:');
    console.log('1. Ensure MySQL is running');
    console.log('2. Check your .env file configuration');
    console.log('3. Run the enhanced-database-setup.sql script');
    console.log('4. Verify database permissions');
  }
}

// Run the test
testDatabase();

