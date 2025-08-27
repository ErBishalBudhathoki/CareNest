const http = require('http');

const options = {
  hostname: 'localhost',
  port: 8080,
  path: '/getEmployeeTrackingData/6846b040808f01d85897bbd8',
  method: 'GET'
};

const req = http.request(options, (res) => {
  let data = '';
  
  res.on('data', (chunk) => {
    data += chunk;
  });
  
  res.on('end', () => {
    try {
      const json = JSON.parse(data);
      console.log('=== DEBUG: Raw Assignment Data ===');
      
      if (json.data && json.data.assignments && json.data.assignments.length > 0) {
        console.log('First assignment structure:');
        console.log(JSON.stringify(json.data.assignments[0], null, 2));
        
        console.log('\nSecond assignment structure:');
        if (json.data.assignments[1]) {
          console.log(JSON.stringify(json.data.assignments[1], null, 2));
        }
      } else {
        console.log('No assignments found or unexpected structure');
        console.log('Response structure:', JSON.stringify(json, null, 2));
      }
      
    } catch (e) {
      console.log('Error parsing JSON:', e.message);
      console.log('Raw response:', data.substring(0, 1000));
    }
  });
});

req.on('error', (e) => {
  console.error('Request error:', e.message);
});

req.end();