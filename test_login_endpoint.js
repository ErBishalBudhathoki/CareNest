require('dotenv').config({ path: './.env' });
const axios = require('axios');

async function testLoginEndpoint() {
  try {
    console.log('Testing /auth/secure-login endpoint...');
    
    const loginData = {
      email: 'test@tester.com',
      password: '111111'
    };
    
    console.log('Login request data:', loginData);
    
    const response = await axios.post('http://192.168.1.7:3000/secure-login', loginData, {
      headers: {
        'Content-Type': 'application/json'
      },
      timeout: 10000
    });
    
    console.log('\n✅ Login successful!');
    console.log('Status:', response.status);
    console.log('Response data:', JSON.stringify(response.data, null, 2));
    
  } catch (error) {
    console.log('\n❌ Login failed!');
    
    if (error.response) {
      console.log('Status:', error.response.status);
      console.log('Error data:', JSON.stringify(error.response.data, null, 2));
    } else if (error.request) {
      console.log('No response received:', error.message);
    } else {
      console.log('Request error:', error.message);
    }
  }
}

testLoginEndpoint();