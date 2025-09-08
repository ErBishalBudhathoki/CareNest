/**
 * Reset Rate Limits Direct Script
 * 
 * This script directly manipulates the in-memory rate limiting data
 * by modifying the server.js file to include a reset function.
 */

const fs = require('fs');
const path = require('path');

// Path to the server.js file
const serverFilePath = path.join(__dirname, 'server.js');

// Function to add the reset rate limits endpoint to server.js
function addResetRateLimitsEndpoint() {
  try {
    // Read the server.js file
    let serverContent = fs.readFileSync(serverFilePath, 'utf8');
    
    // Check if the endpoint already exists
    if (serverContent.includes('/reset-rate-limits')) {
      console.log('Reset rate limits endpoint already exists');
      return;
    }
    
    // Find a good place to add the endpoint (after other route definitions)
    const insertPosition = serverContent.indexOf('// Serve static files from uploads directory');
    
    if (insertPosition === -1) {
      console.error('Could not find a suitable position to add the endpoint');
      return;
    }
    
    // Create the endpoint code
    const endpointCode = `
// Reset rate limits endpoint
app.post('/reset-rate-limits', (req, res) => {
  const { ip, resetAll } = req.body;
  
  try {
    // Access the rate limiting data from the auth middleware
    const authMiddleware = require('./middleware/auth');
    
    if (resetAll) {
      // Reset all rate limits
      if (authMiddleware.failedAttempts) {
        authMiddleware.failedAttempts.clear();
      }
      if (authMiddleware.blockedIPs) {
        authMiddleware.blockedIPs.clear();
      }
      console.log('Reset all rate limits');
      res.json({ success: true, message: 'All rate limits reset successfully' });
    } else if (ip) {
      // Reset rate limits for specific IP
      if (authMiddleware.resetFailedAttempts) {
        authMiddleware.resetFailedAttempts(ip);
        console.log('Reset rate limits for IP:', ip);
        res.json({ success: true, message: 'Rate limits reset successfully for IP: ' + ip });
      } else {
        res.status(500).json({ success: false, message: 'Reset function not available' });
      }
    } else {
      res.status(400).json({ success: false, message: 'Missing required parameters' });
    }
  } catch (error) {
    console.error('Error resetting rate limits:', error);
    res.status(500).json({ success: false, message: 'Error resetting rate limits' });
  }
});

`;
    
    // Insert the endpoint code
    const newContent = serverContent.slice(0, insertPosition) + endpointCode + serverContent.slice(insertPosition);
    
    // Write the modified content back to the file
    fs.writeFileSync(serverFilePath, newContent, 'utf8');
    
    console.log('Reset rate limits endpoint added to server.js');
    console.log('Restart the server to apply changes');
    
  } catch (error) {
    console.error('Error modifying server.js:', error);
  }
}

// Execute the function
addResetRateLimitsEndpoint();

console.log('\nTo reset rate limits, restart the server and use:');
console.log('curl -X POST http://localhost:3000/reset-rate-limits -H "Content-Type: application/json" -d \'{\'resetAll\': true}\'');
console.log('or');
console.log('curl -X POST http://localhost:3000/reset-rate-limits -H "Content-Type: application/json" -d \'{\'ip\': "192.168.1.1"}\'');