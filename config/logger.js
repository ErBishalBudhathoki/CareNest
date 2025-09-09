const winston = require('winston');
const path = require('path');

// Define log levels
const logLevels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  debug: 4
};

// Define log colors for console output
const logColors = {
  error: 'red',
  warn: 'yellow',
  info: 'green',
  http: 'magenta',
  debug: 'blue'
};

winston.addColors(logColors);

// Custom format for structured logging
const structuredFormat = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss.SSS' }),
  winston.format.errors({ stack: true }),
  winston.format.json(),
  winston.format.printf((info) => {
    const logEntry = {
      timestamp: info.timestamp,
      level: info.level,
      message: info.message,
      service: 'invoice-backend',
      environment: process.env.NODE_ENV || 'development',
      ...info.metadata
    };

    // Add stack trace for errors
    if (info.stack) {
      logEntry.stack = info.stack;
    }

    return JSON.stringify(logEntry);
  })
);

// Console format for development
const consoleFormat = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
  winston.format.colorize({ all: true }),
  winston.format.printf((info) => {
    return `${info.timestamp} [${info.level}]: ${info.message}`;
  })
);

// Create logs directory if it doesn't exist
const logsDir = '/var/log/backend';
const fs = require('fs');
if (!fs.existsSync(logsDir)) {
  try {
    fs.mkdirSync(logsDir, { recursive: true });
  } catch (error) {
    // Fallback to local logs directory if /var/log/backend is not writable
    const localLogsDir = path.join(__dirname, '../logs');
    if (!fs.existsSync(localLogsDir)) {
      fs.mkdirSync(localLogsDir, { recursive: true });
    }
  }
}

// Determine log directory (prefer /var/log/backend for Docker, fallback to local)
const getLogDir = () => {
  try {
    fs.accessSync('/var/log/backend', fs.constants.W_OK);
    return '/var/log/backend';
  } catch {
    return path.join(__dirname, '../logs');
  }
};

const logDir = getLogDir();

// Create winston logger
const logger = winston.createLogger({
  levels: logLevels,
  level: process.env.LOG_LEVEL || 'info',
  format: structuredFormat,
  defaultMeta: { service: 'invoice-backend' },
  transports: [
    // Error logs
    new winston.transports.File({
      filename: path.join(logDir, 'error.log'),
      level: 'error',
      maxsize: 10485760, // 10MB
      maxFiles: 5,
      tailable: true
    }),
    
    // Combined logs
    new winston.transports.File({
      filename: path.join(logDir, 'combined.log'),
      maxsize: 10485760, // 10MB
      maxFiles: 5,
      tailable: true
    }),
    
    // Application logs
    new winston.transports.File({
      filename: path.join(logDir, 'application.log'),
      level: 'info',
      maxsize: 10485760, // 10MB
      maxFiles: 5,
      tailable: true
    }),
    
    // Access logs (for HTTP requests)
    new winston.transports.File({
      filename: path.join(logDir, 'access.log'),
      level: 'http',
      maxsize: 10485760, // 10MB
      maxFiles: 5,
      tailable: true
    })
  ],
  
  // Handle uncaught exceptions
  exceptionHandlers: [
    new winston.transports.File({
      filename: path.join(logDir, 'exceptions.log'),
      maxsize: 10485760, // 10MB
      maxFiles: 3
    })
  ],
  
  // Handle unhandled promise rejections
  rejectionHandlers: [
    new winston.transports.File({
      filename: path.join(logDir, 'rejections.log'),
      maxsize: 10485760, // 10MB
      maxFiles: 3
    })
  ]
});

// Add console transport for development
if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: consoleFormat,
    level: 'debug'
  }));
}

// Helper functions for structured logging
const createLogMethods = (logger) => {
  return {
    error: (message, metadata = {}) => logger.error(message, { metadata }),
    warn: (message, metadata = {}) => logger.warn(message, { metadata }),
    info: (message, metadata = {}) => logger.info(message, { metadata }),
    http: (message, metadata = {}) => logger.http(message, { metadata }),
    debug: (message, metadata = {}) => logger.debug(message, { metadata }),
    
    // Specialized logging methods
    request: (req, metadata = {}) => {
      logger.http('HTTP Request', {
        metadata: {
          method: req.method,
          url: req.url,
          userAgent: req.get('User-Agent'),
          ip: req.ip,
          ...metadata
        }
      });
    },
    
    response: (req, res, responseTime, metadata = {}) => {
      logger.http('HTTP Response', {
        metadata: {
          method: req.method,
          url: req.url,
          statusCode: res.statusCode,
          responseTime: `${responseTime}ms`,
          ip: req.ip,
          ...metadata
        }
      });
    },
    
    database: (operation, collection, metadata = {}) => {
      logger.info('Database Operation', {
        metadata: {
          operation,
          collection,
          ...metadata
        }
      });
    },
    
    auth: (action, userEmail, metadata = {}) => {
      logger.info('Authentication Event', {
        metadata: {
          action,
          userEmail,
          ...metadata
        }
      });
    },
    
    business: (event, metadata = {}) => {
      logger.info('Business Event', {
        metadata: {
          event,
          ...metadata
        }
      });
    }
  };
};

// Create logger with helper methods
const loggerWithHelpers = {
  ...createLogMethods(logger),
  winston: logger,
  logDir
};

// Export logger with helper methods
module.exports = loggerWithHelpers;