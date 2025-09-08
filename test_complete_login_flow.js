require('dotenv').config();
const axios = require('axios');
const crypto = require('crypto');
const { MongoClient } = require('mongodb');

// Simulate frontend password hashing (web version using SHA-256)
function hashPasswordWithSalt(password, saltHex) {
  // Convert hex salt to bytes
  const saltBytes = Buffer.from(saltHex, 'hex');
  const passwordBytes = Buffer.from(password, 'utf8');
  
  // Combine password and salt
  const combined = Buffer.concat([passwordBytes, saltBytes]);
  
  // Hash with SHA-256
  const hash = crypto.createHash('sha256').update(combined).digest();
  
  // Convert to hex and combine with salt
  const hashHex = hash.toString('hex');
  const hashedPasswordWithSalt = hashHex + saltHex;
  
  return hashedPasswordWithSalt;
}

async function testCompleteLoginFlow() {
  try {
    console.log('=== Testing Complete Login Flow ===\n');
    
    const email = 'test@tester.com';
    const password = '111111'; // Let's try this password
    
    // Step 1: Get salt from backend
    console.log('Step 1: Getting salt from backend...');
    const saltResponse = await axios.post('http://localhost:8080/getSalt/', {
      email: email
    });
    
    const salt = saltResponse.data.salt;
    console.log('Salt received:', salt);
    console.log('Salt length:', salt.length);
    
    // Step 2: Hash password with salt (simulate frontend)
    console.log('\nStep 2: Hashing password with salt...');
    const hashedPassword = hashPasswordWithSalt(password, salt);
    console.log('Hashed password:', hashedPassword);
    console.log('Hashed password length:', hashedPassword.length);
    
    // Step 3: Compare with stored password
    console.log('\nStep 3: Checking stored password...');
    const client = await MongoClient.connect(process.env.MONGODB_URI);
    const db = client.db('Invoice');
    const user = await db.collection('login').findOne({email: email});
    
    console.log('Stored password:', user.password);
    console.log('Generated password:', hashedPassword);
    console.log('Passwords match:', user.password === hashedPassword);
    
    await client.close();
    
    // Step 4: Test login endpoint
    console.log('\nStep 4: Testing login endpoint...');
    try {
      const loginResponse = await axios.post('http://localhost:8080/secure-login', {
        email: 'test@tester.com',
        password: hashedPassword
      });
       
      console.log('Login successful!');
      console.log('Response:', loginResponse.data);
    } catch (loginError) {
      console.log('Login failed:');
      console.log('Status:', loginError.response?.status);
      console.log('Error:', loginError.response?.data || loginError.message);
    }
    
  } catch (error) {
    console.error('Error in test:', error.response ? error.response.data : error.message);
  }
}

testCompleteLoginFlow();