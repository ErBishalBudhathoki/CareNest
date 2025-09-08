const { MongoClient, ServerApiVersion } = require('mongodb');
const logger = require('./logger');

class DatabaseConfig {
  constructor() {
    this.uri = process.env.MONGODB_URI;
    this.client = null;
    this.db = null;
  }

  /**
   * Get a new MongoDB client instance
   * @returns {MongoClient} MongoDB client
   */
  getClient() {
    return new MongoClient(this.uri, {
      serverApi: ServerApiVersion.v1
    });
  }

  /**
   * Connect to MongoDB and return client
   * @returns {Promise<MongoClient>} Connected MongoDB client
   */
  async connect() {
    try {
      this.client = await MongoClient.connect(this.uri, {
        serverApi: ServerApiVersion.v1
      });
      this.db = this.client.db('Invoice');
      return this.client;
    } catch (error) {
      console.error('Failed to connect to MongoDB:', error);
      throw error;
    }
  }

  /**
   * Get database instance
   * @returns {Db} MongoDB database instance
   */
  getDatabase() {
    if (!this.db) {
      throw new Error('Database not connected. Call connect() first.');
    }
    return this.db;
  }

  /**
   * Close database connection
   */
  async close() {
    if (this.client) {
      await this.client.close();
      this.client = null;
      this.db = null;
    }
  }

  /**
   * Execute a database operation with automatic connection management
   * @param {Function} operation - Database operation function
   * @returns {Promise<any>} Operation result
   */
  async executeOperation(operation) {
    let client;
    const startTime = Date.now();
    const operationId = Math.random().toString(36).substr(2, 9);
    
    try {
      // Log database connection attempt
      logger.business('Database Connection Attempt', {
        event: 'db_connection_attempt',
        operationId: operationId,
        timestamp: new Date().toISOString()
      });
      
      client = await MongoClient.connect(this.uri, {
        serverApi: ServerApiVersion.v1
      });
      
      const connectionTime = Date.now() - startTime;
      
      // Log successful connection
      logger.business('Database Connection Success', {
        event: 'db_connection_success',
        operationId: operationId,
        connectionTime: connectionTime,
        timestamp: new Date().toISOString()
      });
      
      const db = client.db('Invoice');
      const operationStartTime = Date.now();
      
      const result = await operation(db, client);
      
      const operationTime = Date.now() - operationStartTime;
      const totalTime = Date.now() - startTime;
      
      // Log successful operation
      logger.business('Database Operation Success', {
        event: 'db_operation_success',
        operationId: operationId,
        metrics: {
          connectionTime: connectionTime,
          operationTime: operationTime,
          totalTime: totalTime
        },
        performance: {
          isFast: totalTime < 100,
          isModerate: totalTime >= 100 && totalTime < 500,
          isSlow: totalTime >= 500
        },
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const errorTime = Date.now() - startTime;
      
      // Log database error
      logger.business('Database Operation Error', {
        event: 'db_operation_error',
        operationId: operationId,
        error: {
          message: error.message,
          code: error.code,
          name: error.name
        },
        metrics: {
          timeToError: errorTime
        },
        errorCategory: {
          isConnectionError: error.message.includes('connection') || error.message.includes('connect'),
          isTimeoutError: error.message.includes('timeout'),
          isAuthError: error.message.includes('auth') || error.message.includes('unauthorized'),
          isNetworkError: error.message.includes('network') || error.message.includes('ENOTFOUND')
        },
        timestamp: new Date().toISOString()
      });
      
      console.error('Database operation failed:', error);
      throw error;
    } finally {
      if (client) {
        try {
          await client.close();
          
          // Log connection closure
          logger.business('Database Connection Closed', {
            event: 'db_connection_closed',
            operationId: operationId,
            timestamp: new Date().toISOString()
          });
        } catch (closeError) {
          logger.business('Database Connection Close Error', {
            event: 'db_connection_close_error',
            operationId: operationId,
            error: closeError.message,
            timestamp: new Date().toISOString()
          });
        }
      }
    }
  }
}

// Export singleton instance
const databaseConfig = new DatabaseConfig();

// Add connectToDatabase function for server.js compatibility
const connectToDatabase = async () => {
  try {
    logger.business('Database Initialization', {
      event: 'db_initialization',
      timestamp: new Date().toISOString()
    });
    
    // Test connection
    await databaseConfig.executeOperation(async (db) => {
      await db.admin().ping();
      return true;
    });
    
    logger.business('Database Initialization Success', {
      event: 'db_initialization_success',
      timestamp: new Date().toISOString()
    });
    
    console.log('Database connection verified successfully');
  } catch (error) {
    logger.business('Database Initialization Error', {
      event: 'db_initialization_error',
      error: error.message,
      timestamp: new Date().toISOString()
    });
    
    console.error('Database initialization failed:', error);
    throw error;
  }
};

module.exports = {
  DatabaseConfig,
  databaseConfig,
  connectToDatabase,
  // Legacy exports for backward compatibility
  uri: process.env.MONGODB_URI,
  MongoClient,
  ServerApiVersion
};