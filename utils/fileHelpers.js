const fs = require('fs');
const path = require('path');
const { promisify } = require('util');

// Promisify fs functions for async/await usage
const readFile = promisify(fs.readFile);
const writeFile = promisify(fs.writeFile);
const unlink = promisify(fs.unlink);
const mkdir = promisify(fs.mkdir);
const stat = promisify(fs.stat);
const readdir = promisify(fs.readdir);

/**
 * Ensure a directory exists, create if it doesn't
 * @param {string} dirPath - Directory path
 * @returns {Promise<void>}
 */
async function ensureDirectoryExists(dirPath) {
  try {
    await stat(dirPath);
  } catch (error) {
    if (error.code === 'ENOENT') {
      await mkdir(dirPath, { recursive: true });
    } else {
      throw error;
    }
  }
}

/**
 * Check if a file exists
 * @param {string} filePath - File path
 * @returns {Promise<boolean>} True if file exists
 */
async function fileExists(filePath) {
  try {
    await stat(filePath);
    return true;
  } catch (error) {
    return false;
  }
}

/**
 * Get file size in bytes
 * @param {string} filePath - File path
 * @returns {Promise<number>} File size in bytes
 */
async function getFileSize(filePath) {
  try {
    const stats = await stat(filePath);
    return stats.size;
  } catch (error) {
    throw new Error(`Cannot get file size: ${error.message}`);
  }
}

/**
 * Get file extension from filename
 * @param {string} filename - Filename
 * @returns {string} File extension (including dot)
 */
function getFileExtension(filename) {
  return path.extname(filename).toLowerCase();
}

/**
 * Generate unique filename with timestamp
 * @param {string} originalName - Original filename
 * @param {string} prefix - Prefix for the filename
 * @returns {string} Unique filename
 */
function generateUniqueFilename(originalName, prefix = 'file') {
  const extension = getFileExtension(originalName);
  const timestamp = Date.now();
  const random = Math.round(Math.random() * 1E9);
  return `${prefix}-${timestamp}-${random}${extension}`;
}

/**
 * Validate file type based on allowed extensions
 * @param {string} filename - Filename to validate
 * @param {string[]} allowedExtensions - Array of allowed extensions (e.g., ['.jpg', '.png'])
 * @returns {boolean} True if file type is allowed
 */
function isAllowedFileType(filename, allowedExtensions) {
  const extension = getFileExtension(filename);
  return allowedExtensions.includes(extension);
}

/**
 * Validate file type based on MIME type
 * @param {string} mimeType - MIME type to validate
 * @param {string[]} allowedMimeTypes - Array of allowed MIME types
 * @returns {boolean} True if MIME type is allowed
 */
function isAllowedMimeType(mimeType, allowedMimeTypes) {
  return allowedMimeTypes.includes(mimeType);
}

/**
 * Delete a file safely
 * @param {string} filePath - File path to delete
 * @returns {Promise<boolean>} True if file was deleted, false if it didn't exist
 */
async function deleteFile(filePath) {
  try {
    await unlink(filePath);
    return true;
  } catch (error) {
    if (error.code === 'ENOENT') {
      return false; // File didn't exist
    }
    throw error;
  }
}

/**
 * Read JSON file and parse it
 * @param {string} filePath - Path to JSON file
 * @returns {Promise<Object>} Parsed JSON object
 */
async function readJsonFile(filePath) {
  try {
    const data = await readFile(filePath, 'utf8');
    return JSON.parse(data);
  } catch (error) {
    throw new Error(`Error reading JSON file: ${error.message}`);
  }
}

/**
 * Write object to JSON file
 * @param {string} filePath - Path to JSON file
 * @param {Object} data - Data to write
 * @param {boolean} pretty - Whether to format JSON prettily
 * @returns {Promise<void>}
 */
async function writeJsonFile(filePath, data, pretty = true) {
  try {
    const jsonString = pretty ? JSON.stringify(data, null, 2) : JSON.stringify(data);
    await writeFile(filePath, jsonString, 'utf8');
  } catch (error) {
    throw new Error(`Error writing JSON file: ${error.message}`);
  }
}

/**
 * Get all files in a directory with specific extension
 * @param {string} dirPath - Directory path
 * @param {string} extension - File extension (e.g., '.js')
 * @returns {Promise<string[]>} Array of file paths
 */
async function getFilesWithExtension(dirPath, extension) {
  try {
    const files = await readdir(dirPath);
    return files
      .filter(file => path.extname(file).toLowerCase() === extension.toLowerCase())
      .map(file => path.join(dirPath, file));
  } catch (error) {
    throw new Error(`Error reading directory: ${error.message}`);
  }
}

/**
 * Copy file from source to destination
 * @param {string} sourcePath - Source file path
 * @param {string} destPath - Destination file path
 * @returns {Promise<void>}
 */
async function copyFile(sourcePath, destPath) {
  try {
    const data = await readFile(sourcePath);
    await ensureDirectoryExists(path.dirname(destPath));
    await writeFile(destPath, data);
  } catch (error) {
    throw new Error(`Error copying file: ${error.message}`);
  }
}

/**
 * Get file info (size, creation date, etc.)
 * @param {string} filePath - File path
 * @returns {Promise<Object>} File information
 */
async function getFileInfo(filePath) {
  try {
    const stats = await stat(filePath);
    return {
      size: stats.size,
      created: stats.birthtime,
      modified: stats.mtime,
      accessed: stats.atime,
      isFile: stats.isFile(),
      isDirectory: stats.isDirectory()
    };
  } catch (error) {
    throw new Error(`Error getting file info: ${error.message}`);
  }
}

/**
 * Sanitize filename by removing invalid characters
 * @param {string} filename - Original filename
 * @returns {string} Sanitized filename
 */
function sanitizeFilename(filename) {
  // Remove or replace invalid characters
  return filename
    .replace(/[<>:"/\\|?*]/g, '_') // Replace invalid chars with underscore
    .replace(/\s+/g, '_') // Replace spaces with underscore
    .replace(/_{2,}/g, '_') // Replace multiple underscores with single
    .replace(/^_+|_+$/g, ''); // Remove leading/trailing underscores
}

module.exports = {
  ensureDirectoryExists,
  fileExists,
  getFileSize,
  getFileExtension,
  generateUniqueFilename,
  isAllowedFileType,
  isAllowedMimeType,
  deleteFile,
  readJsonFile,
  writeJsonFile,
  getFilesWithExtension,
  copyFile,
  getFileInfo,
  sanitizeFilename,
  // Re-export promisified fs functions
  readFile,
  writeFile,
  unlink,
  mkdir,
  stat,
  readdir
};