/**
 * Reset Rate Limits Script
 * 
 * This script makes an API call to the security dashboard endpoint to reset rate limits.
 * It requires admin credentials to authenticate.
 */

const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });
const axios = require('axios');

// Get command line arguments
const args = process.argv.slice(2);
const ip = args[0]; // Optional: specific IP to reset
const resetAll = args.includes('--all');

// Admin credentials (should be stored securely in production)
const adminEmail = 'test@tester.com';
const adminPassword = '111111';

// Base URL from environment or default
const baseUrl = process.env.BASE_URL || 'http://localhost:8080';

async function resetRateLimits() {
  try {
    // First, get salt for the user
    console.log('Getting salt...');
    const saltResponse = await axios.post(`${baseUrl}/getSalt/`, {
      email: adminEmail
    });
    
    if (!saltResponse.data.salt) {
      console.error('Failed to get salt:', saltResponse.data);
      return;
    }
    
    const salt = saltResponse.data.salt;
    console.log('Salt received:', salt);
    
    // For testing purposes, we'll use the exact hash from the database
    const hashedPassword = 'REDACTED' + salt;
    
    // Authenticate to get token
    console.log('Authenticating...');
    const loginResponse = await axios.post(`${baseUrl}/login`, {
      email: adminEmail,
      password: hashedPassword
    });
    
    if (!loginResponse.data.token) {
      console.error('Authentication failed: No token received');
      return;
    }
    
    const token = loginResponse.data.token;
    console.log('Authentication successful');
    
    // Now reset rate limits
    const resetData = {};
    
    if (ip && !resetAll) {
      resetData.ip = ip;
      console.log(`Resetting rate limits for IP: ${ip}`);
    } else if (resetAll) {
      resetData.resetAll = true;
      console.log('Resetting all rate limits');
    } else {
      console.log('Usage: node reset_rate_limits.js [ip] [--all]');
      console.log('  - Provide an IP to reset a specific address');
      console.log('  - Use --all flag to reset all rate limits');
      return;
    }
    
    const resetResponse = await axios.post(
      `${baseUrl}/api/security/dashboard/rate-limit/reset`,
      resetData,
      {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      }
    );
    
    console.log('Reset response:', resetResponse.data);
    console.log('Rate limits reset successfully');
    
  } catch (error) {
    console.error('Error resetting rate limits:', error.message);
    if (error.response) {
      console.error('Response data:', error.response.data);
      console.error('Response status:', error.response.status);
    }
  }
}

resetRateLimits();