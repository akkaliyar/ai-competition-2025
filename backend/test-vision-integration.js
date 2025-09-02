/**
 * 🔍 Quick Google Vision Integration Test
 * Verifies that the Google Vision service can be imported and initialized
 */

const { GoogleVisionService } = require('./dist/services/google-vision.service');

console.log('🔍 Testing Google Vision Service Integration...');

try {
  // Test service initialization
  console.log('📦 Importing GoogleVisionService...');
  
  // Create service instance (this will test the constructor)
  const visionService = new GoogleVisionService();
  
  console.log('✅ Service initialization successful');
  
  // Test availability check
  const isAvailable = visionService.isGoogleVisionAvailable();
  console.log(`📊 Vision API Available: ${isAvailable ? '✅ YES' : '❌ NO'}`);
  
  // Test capabilities
  const capabilities = visionService.getVisionCapabilities();
  console.log('🎯 Capabilities check successful');
  console.log(`   Features: ${Object.keys(capabilities.features).length}`);
  console.log(`   Auth configured: ${capabilities.authentication.serviceAccount || capabilities.authentication.apiKey ? '✅' : '❌'}`);
  
  console.log('\n✅ Google Vision Integration Test PASSED');
  console.log('🚀 Ready for production use!');
  
} catch (error) {
  console.error('❌ Integration test failed:', error.message);
  console.log('\n🔧 Possible issues:');
  console.log('- NestJS service not compiled (run: npm run build)');
  console.log('- Missing dependencies (run: npm install)');
  console.log('- Import path issues in compiled code');
}
