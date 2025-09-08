require('dotenv').config({ path: './.env' });
const argon2 = require('argon2');
const crypto = require('crypto');

async function testArgon2Generation() {
  const password = '111111';
  const saltHex = 'REDACTED';
  const expectedHashHex = 'REDACTEDc';
  
  console.log('Testing Argon2 hash generation...');
  console.log('Password:', password);
  console.log('Salt (hex):', saltHex);
  console.log('Expected hash (hex):', expectedHashHex);
  
  const saltBuffer = Buffer.from(saltHex, 'hex');
  const expectedHashBuffer = Buffer.from(expectedHashHex, 'hex');
  
  console.log('\nSalt buffer length:', saltBuffer.length);
  console.log('Expected hash buffer length:', expectedHashBuffer.length);
  
  // The first config was very close - let's try variations around it
  const configs = [
    {
      name: 'Argon2i - Flutter Config (v16) - 32 bytes',
      type: argon2.argon2i,
      memoryCost: 2 ** 16,
      timeCost: 2,
      parallelism: 1,
      hashLength: 32,
      version: 0x10
    },
    {
      name: 'Argon2i - Flutter Config (v16) - 33 bytes',
      type: argon2.argon2i,
      memoryCost: 2 ** 16,
      timeCost: 2,
      parallelism: 1,
      hashLength: 33,
      version: 0x10
    },
    {
      name: 'Argon2i - Flutter Config (v16) - 64 bytes',
      type: argon2.argon2i,
      memoryCost: 2 ** 16,
      timeCost: 2,
      parallelism: 1,
      hashLength: 64,
      version: 0x10
    },
    {
      name: 'Argon2i - Flutter Config (v16) - No version specified',
      type: argon2.argon2i,
      memoryCost: 2 ** 16,
      timeCost: 2,
      parallelism: 1,
      hashLength: 32
    }
  ];
  
  for (const config of configs) {
    try {
      console.log(`\n--- Testing ${config.name} ---`);
      
      const options = {
        type: config.type,
        memoryCost: config.memoryCost,
        timeCost: config.timeCost,
        parallelism: config.parallelism,
        salt: saltBuffer,
        hashLength: config.hashLength,
        raw: true
      };
      
      if (config.version) {
        options.version = config.version;
      }
      
      console.log('Options:', JSON.stringify({
        ...options,
        salt: `Buffer(${saltBuffer.length} bytes)`
      }, null, 2));
      
      const computedHash = await argon2.hash(password, options);
      
      const computedHashHex = computedHash.toString('hex');
      console.log('Computed hash (hex):', computedHashHex);
      console.log('Expected hash (hex):', expectedHashHex);
      console.log('Hash length:', computedHashHex.length, 'vs expected:', expectedHashHex.length);
      console.log('Match:', computedHashHex === expectedHashHex);
      
      // Check if it's a partial match (for debugging)
      if (computedHashHex.startsWith(expectedHashHex.substring(0, 60))) {
        console.log('🔍 PARTIAL MATCH - very close!');
        console.log('Difference at end:', {
          computed: computedHashHex.substring(60),
          expected: expectedHashHex.substring(60)
        });
      }
      
      if (computedHashHex === expectedHashHex) {
        console.log('🎉 FOUND MATCHING CONFIGURATION!');
        return config;
      }
      
    } catch (error) {
      console.log('Error with config:', error.message);
    }
  }
  
  console.log('\n❌ No exact matching configuration found');
  
  // Let's also try a different approach - maybe the Flutter library has a bug or uses a different implementation
  console.log('\n--- Trying raw crypto approach ---');
  try {
    // Let's see if we can manually implement what Flutter might be doing
    const crypto = require('crypto');
    
    // Try PBKDF2 with different parameters
    const pbkdf2Hash = crypto.pbkdf2Sync(password, saltBuffer, 2, 32, 'sha256');
    console.log('PBKDF2 (sha256, 2 iterations):', pbkdf2Hash.toString('hex'));
    
    const pbkdf2Hash512 = crypto.pbkdf2Sync(password, saltBuffer, 2, 32, 'sha512');
    console.log('PBKDF2 (sha512, 2 iterations):', pbkdf2Hash512.toString('hex'));
    
  } catch (error) {
    console.log('Error with crypto approach:', error.message);
  }
  
  return null;
}

testArgon2Generation();