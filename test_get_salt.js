require('dotenv').config();
const axios = require('axios');

async function testGetSalt() {
  try {
    const response = await axios.post('http://localhost:8080/getSalt/', {
      email: 'test@tester.com'
    });
    
    console.log('getSalt response:', response.data);
    console.log('Salt length:', response.data.salt ? response.data.salt.length : 'No salt');
  } catch (error) {
    console.error('Error testing getSalt:', error.response ? error.response.data : error.message);
  }
}

testGetSalt();