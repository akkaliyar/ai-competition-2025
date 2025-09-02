const mysql = require('mysql2/promise');

async function resetDatabase() {
  console.log('🔄 Resetting database to fix row size issues...');
  
  try {
    // Database connection configuration
    const dbConfig = {
      host: 'localhost',
      user: 'root',
      password: '',  // Update this if you have a password
      database: 'ai_crm'
    };

    console.log('📡 Connecting to MySQL...');
    const connection = await mysql.createConnection(dbConfig);
    console.log('✅ Connected to MySQL successfully');
    
    console.log('🗑️  Dropping existing tables to fix row size issues...');
    
    // Drop tables in correct order (foreign keys first)
    await connection.execute('SET FOREIGN_KEY_CHECKS = 0');
    
    const tables = ['table_extractions', 'ocr_results', 'file_metadata', 'parsed_files'];
    
    for (const table of tables) {
      try {
        await connection.execute(`DROP TABLE IF EXISTS \`${table}\``);
        console.log(`✅ Dropped table: ${table}`);
      } catch (error) {
        console.log(`⚠️  Could not drop table ${table}: ${error.message}`);
      }
    }
    
    await connection.execute('SET FOREIGN_KEY_CHECKS = 1');
    
    await connection.end();
    
    console.log('');
    console.log('🎉 Database reset completed successfully!');
    console.log('');
    console.log('📋 Next steps:');
    console.log('1. Start your backend server: npm run start:dev');
    console.log('2. TypeORM will automatically create optimized tables');
    console.log('3. The row size issue should be resolved');
    console.log('4. Test uploading your financial document');
    
  } catch (error) {
    console.error('❌ Database reset failed:', error.message);
    console.log('');
    console.log('🔧 Manual steps:');
    console.log('1. Connect to MySQL: mysql -u root -p');
    console.log('2. Run these commands:');
    console.log('   USE ai_crm;');
    console.log('   SET FOREIGN_KEY_CHECKS = 0;');
    console.log('   DROP TABLE IF EXISTS table_extractions;');
    console.log('   DROP TABLE IF EXISTS ocr_results;');
    console.log('   DROP TABLE IF EXISTS file_metadata;');
    console.log('   DROP TABLE IF EXISTS parsed_files;');
    console.log('   SET FOREIGN_KEY_CHECKS = 1;');
    console.log('3. Exit MySQL and start your backend server');
    
    process.exit(1);
  }
}

resetDatabase().catch(console.error);
