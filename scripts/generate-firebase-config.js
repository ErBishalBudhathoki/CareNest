#!/usr/bin/env node

/**
 * This script generates the firebase-admin-config.js file from environment variables.
 * It should be run during the deployment process to ensure the file is created with
 * the correct credentials without storing sensitive information in the repository.
 */

const fs = require('fs');
const path = require('path');
const logger = require('../config/logger');

// Path to the template file
const templatePath = path.join(__dirname, '..', 'firebase-admin-config.js.template');

// Path to the output file
const outputPath = path.join(__dirname, '..', 'firebase-admin-config.js');

logger.info('Generating Firebase Admin SDK configuration file...');

// Check if the template file exists
if (!fs.existsSync(templatePath)) {
  console.error(`Template file not found: ${templatePath}`);
  console.error('Please ensure the firebase-admin-config.js.template file exists.');
  process.exit(1);
}

// Read the template file
const templateContent = fs.readFileSync(templatePath, 'utf8');

// Write the template content to the output file
fs.writeFileSync(outputPath, templateContent, 'utf8');

logger.info(`Firebase Admin SDK configuration file generated at: ${outputPath}`);
logger.info('Make sure all required environment variables are set in your deployment environment.');