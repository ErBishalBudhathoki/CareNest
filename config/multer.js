const multer = require('multer');
const path = require('path');
const fs = require('fs');

class MulterConfig {
  constructor() {
    this.uploadDir = './uploads';
    this.ensureUploadDir();
  }

  /**
   * Ensure upload directory exists
   */
  ensureUploadDir() {
    if (!fs.existsSync(this.uploadDir)) {
      fs.mkdirSync(this.uploadDir, { recursive: true });
    }
  }

  /**
   * Get multer storage configuration
   * @returns {multer.StorageEngine} Multer storage engine
   */
  getStorage() {
    return multer.diskStorage({
      destination: this.uploadDir,
      filename: (req, file, cb) => {
        // Generate unique filename with timestamp
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        const fileExtension = path.extname(file.originalname);
        cb(null, 'receipt-' + uniqueSuffix + fileExtension);
      }
    });
  }

  /**
   * File filter function for validating uploads
   * @param {Object} req - Express request object
   * @param {Object} file - Multer file object
   * @param {Function} cb - Callback function
   */
  fileFilter(req, file, cb) {
    // Check file type - allow images and PDF files
    const allowedTypes = [
      'image/jpeg',
      'image/jpg', 
      'image/png',
      'image/heif',
      'image/heic',
      'application/pdf'
    ];
    
    console.log(`File upload attempt - Original name: ${file.originalname}, MIME type: ${file.mimetype}, Field name: ${file.fieldname}`);
    
    // Check MIME type first
    if (allowedTypes.includes(file.mimetype)) {
      console.log(`File accepted based on MIME type: ${file.mimetype}`);
      cb(null, true);
      return;
    }
    
    // Fallback: Check file extension for cases where MIME type detection fails
    const fileExtension = path.extname(file.originalname).toLowerCase();
    const allowedExtensions = ['.jpg', '.jpeg', '.png', '.heif', '.heic', '.pdf'];
    
    if (allowedExtensions.includes(fileExtension)) {
      console.log(`File accepted based on extension: ${fileExtension} (MIME type was: ${file.mimetype})`);
      cb(null, true);
    } else {
      console.log(`File rejected - MIME type: ${file.mimetype}, Extension: ${fileExtension}`);
      cb(new Error(`Invalid file type. Only JPEG, PNG, HEIF images and PDF files are allowed. Received: ${file.mimetype} with extension ${fileExtension}`));
    }
  }

  /**
   * Get configured multer instance
   * @returns {multer.Multer} Configured multer instance
   */
  getUpload() {
    return multer({
      storage: this.getStorage(),
      fileFilter: this.fileFilter,
      limits: {
        fileSize: 10 * 1024 * 1024 // 10MB limit
      }
    });
  }

  /**
   * Get upload middleware for single file
   * @param {string} fieldName - Form field name
   * @returns {Function} Multer middleware
   */
  single(fieldName = 'receipt') {
    return this.getUpload().single(fieldName);
  }

  /**
   * Get upload middleware for multiple files
   * @param {string} fieldName - Form field name
   * @param {number} maxCount - Maximum number of files
   * @returns {Function} Multer middleware
   */
  array(fieldName = 'receipts', maxCount = 10) {
    return this.getUpload().array(fieldName, maxCount);
  }

  /**
   * Get upload middleware for multiple fields
   * @param {Array} fields - Array of field configurations
   * @returns {Function} Multer middleware
   */
  fields(fields) {
    return this.getUpload().fields(fields);
  }
}

// Export singleton instance
const multerConfig = new MulterConfig();

module.exports = {
  MulterConfig,
  multerConfig,
  // Legacy export for backward compatibility
  upload: multerConfig.getUpload()
};