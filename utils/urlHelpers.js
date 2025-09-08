/**
 * URL helper utilities for generating server URLs and file paths
 */

/**
 * Get the base server URL from request
 * @param {Object} req - Express request object
 * @returns {string} Base URL (e.g., 'https://example.com' or 'http://localhost:8080')
 */
function getBaseUrl(req) {
  const protocol = req.secure || req.headers['x-forwarded-proto'] === 'https' ? 'https' : 'http';
  const host = req.get('host') || `localhost:${process.env.PORT || 8080}`;
  return `${protocol}://${host}`;
}

/**
 * Convert relative file path to full server URL
 * @param {Object} req - Express request object
 * @param {string} filePath - Relative or absolute file path
 * @returns {string|null} Full URL or null if no filePath provided
 */
function getFullFileUrl(req, filePath) {
  if (!filePath) return null;
  if (filePath.startsWith('http://') || filePath.startsWith('https://')) {
    return filePath; // Already a full URL
  }
  const baseUrl = getBaseUrl(req);
  const cleanPath = filePath.startsWith('/') ? filePath : `/${filePath}`;
  return `${baseUrl}${cleanPath}`;
}

/**
 * Generate upload file URL
 * @param {Object} req - Express request object
 * @param {string} filename - Uploaded filename
 * @returns {string} Full URL to uploaded file
 */
function getUploadFileUrl(req, filename) {
  return getFullFileUrl(req, `/uploads/${filename}`);
}

/**
 * Validate URL format
 * @param {string} url - URL to validate
 * @returns {boolean} True if valid URL
 */
function isValidUrl(url) {
  try {
    new URL(url);
    return true;
  } catch {
    return false;
  }
}

module.exports = {
  getBaseUrl,
  getFullFileUrl,
  getUploadFileUrl,
  isValidUrl
};