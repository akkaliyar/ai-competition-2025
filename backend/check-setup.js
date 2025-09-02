// Simple setup checker for the AI CRM backend
const mysql = require('mysql2/promise');

async function checkSetup() {
  console.log('🔍 Checking AI CRM Backend Setup...\n');

  // Check environment variables
  console.log('📋 Environment Check:');
  const requiredEnvs = ['DB_HOST', 'DB_PORT', 'DB_USERNAME', 'DB_NAME'];
  let envMissing = false;
  
  requiredEnvs.forEach(env => {
    const value = process.env[env];
    if (value) {
      console.log(`✅ ${env}: ${value}`);
    } else {
      console.log(`❌ ${env}: Not set`);
      envMissing = true;
    }
  });
  
  if (envMissing) {
    console.log('\n⚠️  Missing environment variables. Create a .env file with:');
    console.log(`DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=your_password
DB_NAME=ai_crm
NODE_ENV=development
PORT=3001\n`);
  }

  // Check database connection
  console.log('\n🗄️  Database Connection Check:');
  try {
    const connection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      port: process.env.DB_PORT || 3306,
      user: process.env.DB_USERNAME || 'root',
      password: process.env.DB_PASSWORD || '',
    });

    console.log('✅ MySQL connection successful');

    // Check if database exists
    const [databases] = await connection.execute('SHOW DATABASES');
    const dbExists = databases.some(db => db.Database === (process.env.DB_NAME || 'ai_crm'));
    
    if (dbExists) {
      console.log(`✅ Database '${process.env.DB_NAME || 'ai_crm'}' exists`);
    } else {
      console.log(`❌ Database '${process.env.DB_NAME || 'ai_crm'}' not found`);
      console.log('\n📝 To create database, run this SQL command:');
      console.log(`CREATE DATABASE ${process.env.DB_NAME || 'ai_crm'};\n`);
    }

    await connection.end();
  } catch (error) {
    console.log(`❌ Database connection failed: ${error.message}`);
    console.log('\n💡 Solutions:');
    console.log('1. Make sure MySQL is running');
    console.log('2. Check your database credentials in .env file');
    console.log('3. Verify the database host and port');
  }

  // Check Node.js version
  console.log('\n🟢 Node.js Version Check:');
  const nodeVersion = process.version;
  console.log(`Node.js version: ${nodeVersion}`);
  
  const majorVersion = parseInt(nodeVersion.slice(1).split('.')[0]);
  if (majorVersion >= 16) {
    console.log('✅ Node.js version is compatible (16+)');
  } else {
    console.log('❌ Node.js version should be 16 or higher');
  }

  console.log('\n🚀 Setup Check Complete!');
  console.log('\nTo start the server:');
  console.log('npm run start:dev');
}

// Load environment variables if .env exists
try {
  require('dotenv').config();
} catch (err) {
  // dotenv not installed, continue anyway
}

checkSetup().catch(console.error);

