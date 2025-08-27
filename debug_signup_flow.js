const { MongoClient, ObjectId } = require('mongodb');
require('dotenv').config();
const http = require('http');
const https = require('https');

// Simple fetch implementation using http module
function fetch(url, options = {}) {
  return new Promise((resolve, reject) => {
    const urlObj = new URL(url);
    const isHttps = urlObj.protocol === 'https:';
    const client = isHttps ? https : http;
    
    const requestOptions = {
      hostname: urlObj.hostname,
      port: urlObj.port || (isHttps ? 443 : 80),
      path: urlObj.pathname + urlObj.search,
      method: options.method || 'GET',
      headers: options.headers || {}
    };
    
    const req = client.request(requestOptions, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        resolve({
          status: res.statusCode,
          json: () => Promise.resolve(JSON.parse(data))
        });
      });
    });
    
    req.on('error', reject);
    
    if (options.body) {
      req.write(options.body);
    }
    
    req.end();
  });
}

async function debugSignupFlow() {
  console.log('=== DEBUGGING COMPLETE SIGNUP FLOW ===\n');
  
  try {
    // Connect to database to check initial state
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    console.log('Step 1: Checking existing organization...');
    const existingOrg = await db.collection('organizations').findOne({ 
      ownerEmail: 'deverbishal331@gmail.com' 
    });
    
    if (existingOrg) {
      console.log('Found existing organization:', {
        id: existingOrg._id.toString(),
        name: existingOrg.name,
        code: existingOrg.code,
        ownerEmail: existingOrg.ownerEmail,
        isActive: existingOrg.isActive
      });
      
      console.log('\nStep 2: Attempting signup with existing organization...');
      const signupResponse = await fetch(`http://localhost:8080/signup/deverbishal331@gmail.com`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          firstName: 'Dever',
          lastName: 'Bishal',
          password: 'hashedPassword123',
          salt: 'salt123',
          abn: '12345678901',
          role: 'admin',
          organizationId: existingOrg._id.toString(),
          organizationCode: existingOrg.code
        })
      });
      
      const signupResult = await signupResponse.json();
      console.log('Signup response status:', signupResponse.status);
      console.log('Signup response body:', signupResult);
      
      if (signupResponse.status === 200) {
        console.log('\nStep 3: Verifying user was created...');
        const user = await db.collection('login').findOne({ 
          email: 'deverbishal331@gmail.com' 
        });
        
        if (user) {
          console.log('User found in database:', {
            id: user._id.toString(),
            firstName: user.firstName,
            lastName: user.lastName,
            email: user.email,
            role: user.role,
            organizationId: user.organizationId,
            organizationName: user.organizationName,
            isActive: user.isActive
          });
          
          // Clean up test user
          await db.collection('login').deleteOne({ _id: user._id });
          console.log('\nTest user cleaned up.');
        } else {
          console.log('ERROR: User not found in database after successful signup!');
        }
      } else {
        console.log('\nSignup failed. Analyzing error...');
        
        // Check if it's because user already exists
        const existingUser = await db.collection('login').findOne({ 
          email: 'deverbishal331@gmail.com' 
        });
        
        if (existingUser) {
          console.log('User already exists in database:', {
            id: existingUser._id.toString(),
            email: existingUser.email,
            organizationId: existingUser.organizationId,
            isActive: existingUser.isActive
          });
        } else {
          console.log('User does not exist in database.');
        }
      }
    } else {
      console.log('No existing organization found for deverbishal331@gmail.com');
      
      console.log('\nStep 2: Creating new organization...');
      const orgResponse = await fetch('http://localhost:8080/organization/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          organizationName: 'Debug Test Organization',
          ownerEmail: 'deverbishal331@gmail.com'
        })
      });
      
      const orgResult = await orgResponse.json();
      console.log('Organization creation status:', orgResponse.status);
      console.log('Organization creation result:', orgResult);
      
      if (orgResponse.status === 200) {
        console.log('\nStep 3: Attempting signup with new organization...');
        const signupResponse = await fetch(`http://localhost:8080/signup/deverbishal331@gmail.com`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            firstName: 'Dever',
            lastName: 'Bishal',
            password: 'hashedPassword123',
            salt: 'salt123',
            abn: '12345678901',
            role: 'admin',
            organizationId: orgResult.organizationId,
            organizationCode: orgResult.organizationCode
          })
        });
        
        const signupResult = await signupResponse.json();
        console.log('Signup response status:', signupResponse.status);
        console.log('Signup response body:', signupResult);
        
        // Clean up test data
        if (orgResult.organizationId) {
          await db.collection('organizations').deleteOne({ 
            _id: new ObjectId(orgResult.organizationId) 
          });
          console.log('\nTest organization cleaned up.');
        }
        
        const testUser = await db.collection('login').findOne({ 
          email: 'deverbishal331@gmail.com' 
        });
        if (testUser) {
          await db.collection('login').deleteOne({ _id: testUser._id });
          console.log('Test user cleaned up.');
        }
      }
    }
    
    await client.close();
    
  } catch (error) {
    console.error('Error in debug flow:', error);
  }
}

// Check if server is running
fetch('http://localhost:8080/health')
  .then(() => {
    console.log('Server is running, starting debug flow...\n');
    debugSignupFlow();
  })
  .catch(() => {
    console.log('Server is not running. Please start the server first.');
    console.log('Run: node server.js');
  });