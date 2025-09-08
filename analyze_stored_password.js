require('dotenv').config({ path: './.env' });
const { MongoClient } = require('mongodb');

async function analyzeStoredPassword() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const collection = db.collection('login');
    
    // Get the test user
    const user = await collection.findOne({ email: 'test@tester.com' });
    
    if (!user) {
      console.log('User not found');
      return;
    }
    
    console.log('\n=== DETAILED PASSWORD ANALYSIS ===');
    console.log('Email:', user.email);
    console.log('Password (raw):', user.password);
    console.log('Password length:', user.password.length);
    console.log('Salt (raw):', user.salt);
    console.log('Salt length:', user.salt.length);
    
    // Analyze the password structure
    console.log('\n=== PASSWORD STRUCTURE ANALYSIS ===');
    
    // Check if password is exactly hash + salt
    const expectedHashLength = 64; // 32 bytes = 64 hex chars
    const expectedSaltLength = 64; // 32 bytes = 64 hex chars
    
    if (user.password.length === expectedHashLength + expectedSaltLength) {
      console.log('✅ Password appears to be hash + salt concatenated');
      const hashPart = user.password.substring(0, expectedHashLength);
      const saltPart = user.password.substring(expectedHashLength);
      
      console.log('Hash part:', hashPart);
      console.log('Salt part:', saltPart);
      console.log('Stored salt:', user.salt);
      console.log('Salt parts match:', saltPart === user.salt);
      
      // This is what we should be verifying against
      console.log('\n=== VERIFICATION TARGET ===');
      console.log('Hash to verify against:', hashPart);
      console.log('Salt to use:', user.salt);
      
    } else {
      console.log('❓ Password structure is different than expected');
      console.log('Expected length (hash + salt):', expectedHashLength + expectedSaltLength);
      console.log('Actual length:', user.password.length);
      
      // Try to understand the structure
      if (user.password.length === 128) {
        console.log('\n=== TRYING 64+64 SPLIT ===');
        const part1 = user.password.substring(0, 64);
        const part2 = user.password.substring(64);
        console.log('First 64 chars:', part1);
        console.log('Last 64 chars:', part2);
        console.log('Second part matches salt:', part2 === user.salt);
      }
      
      if (user.password.length > 64) {
        console.log('\n=== TRYING DIFFERENT SPLITS ===');
        // Try different split points
        for (let i = 32; i <= 96; i += 16) {
          const hashPart = user.password.substring(0, i);
          const saltPart = user.password.substring(i);
          console.log(`Split at ${i}: hash(${hashPart.length}) + salt(${saltPart.length})`);
          if (saltPart === user.salt) {
            console.log(`  ✅ Salt match at split ${i}!`);
            console.log(`  Hash part: ${hashPart}`);
          }
        }
      }
    }
    
    // Check character patterns
    console.log('\n=== CHARACTER ANALYSIS ===');
    const passwordChars = user.password.split('');
    const uniqueChars = [...new Set(passwordChars)];
    console.log('Unique characters in password:', uniqueChars.sort());
    console.log('Is all hex?', /^[0-9a-fA-F]+$/.test(user.password));
    
    const saltChars = user.salt.split('');
    const uniqueSaltChars = [...new Set(saltChars)];
    console.log('Unique characters in salt:', uniqueSaltChars.sort());
    console.log('Is salt all hex?', /^[0-9a-fA-F]+$/.test(user.salt));
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

analyzeStoredPassword();