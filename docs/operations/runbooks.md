# Operational Runbooks

This document provides comprehensive operational procedures for deploying, monitoring, troubleshooting, and maintaining the Invoice Management System.

## Table of Contents

1. [Deployment Procedures](#deployment-procedures)
2. [Server Management](#server-management)
3. [Database Operations](#database-operations)
4. [Monitoring & Health Checks](#monitoring--health-checks)
5. [Troubleshooting Guide](#troubleshooting-guide)
6. [Maintenance Procedures](#maintenance-procedures)
7. [Security Operations](#security-operations)
8. [Backup & Recovery](#backup--recovery)
9. [Performance Optimization](#performance-optimization)
10. [Emergency Procedures](#emergency-procedures)

## Deployment Procedures

### Backend Deployment

#### Prerequisites
- Node.js v14 or higher
- MongoDB database access
- Firebase Admin SDK credentials
- Environment variables configured

#### Standard Deployment Steps

1. **Environment Setup**
   ```bash
   # Clone repository
   git clone <repository-url>
   cd invoice/backend
   
   # Install dependencies
   npm install
   
   # Copy environment template
   cp .env.example .env
   ```

2. **Configure Environment Variables**
   ```bash
   # Edit .env file with production values
   nano .env
   ```
   
   Required variables:
   - `MONGODB_URI`: MongoDB connection string
   - `PORT`: Server port (default: 8080)
   - `EMAIL_FOR_OTP`: Email service account
   - `EMAIL_PASSWORD`: Email service password
   - `JWT_SECRET`: JWT signing secret
   - `ENCRYPTION_KEY`: 32-character encryption key
   - `NODE_ENV`: Environment (production/development)
   - Firebase Admin SDK variables (see configuration.md)

3. **Firebase Configuration**
   ```bash
   # Generate Firebase config from environment variables
   node scripts/generate-firebase-config.js
   ```

4. **Database Migration**
   ```bash
   # Run all migrations
   node migration_scripts/run_all_migrations.js
   
   # Validate migration
   node migration_scripts/validate_migration.js
   ```

5. **Start Server**
   ```bash
   # Production start
   npm start
   
   # Development start with auto-reload
   npm run dev
   ```

#### Serverless Deployment

The application supports serverless deployment:

```javascript
// Server automatically detects serverless environment
if (typeof module !== 'undefined' && module.exports) {
  module.exports = app; // Serverless export
} else {
  // Local server startup
  const PORT = process.env.PORT || 8080;
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}
```

### Frontend Deployment (Flutter)

#### Development Build
```bash
# Run in development mode
flutter run -d "emulator-5554" --flavor development
```

#### Production Build
```bash
# Android production build
flutter build apk --release --flavor production

# iOS production build
flutter build ios --release --flavor production
```

#### Using Fastlane (Android)
```bash
cd android
fastlane android deploy
```

## Server Management

### Server Startup

The server entry point is `server.js` with the following startup sequence:

1. **Environment Loading**
   ```javascript
   require('dotenv').config();
   ```

2. **Middleware Setup**
   - CORS configuration
   - Body parsing (JSON, URL-encoded)
   - File upload handling
   - Authentication middleware
   - Error handling

3. **Database Connection**
   ```javascript
   const { databaseConfig } = require('./config/database');
   ```

4. **Firebase Initialization**
   ```javascript
   const admin = require('./firebase-admin-config');
   ```

5. **Route Registration**
   - Authentication routes
   - Organization management
   - Client management
   - Pricing endpoints
   - Invoice generation
   - Audit trail
   - Backward compatibility

6. **Health Check Endpoint**
   ```javascript
   app.get('/health', (req, res) => {
     res.json({ 
       status: 'OK', 
       timestamp: new Date().toISOString() 
     });
   });
   ```

### Process Management

#### Using PM2 (Recommended)
```bash
# Install PM2
npm install -g pm2

# Start application
pm2 start server.js --name "invoice-backend"

# Monitor processes
pm2 monit

# View logs
pm2 logs invoice-backend

# Restart application
pm2 restart invoice-backend

# Stop application
pm2 stop invoice-backend
```

#### Using systemd
```bash
# Create service file
sudo nano /etc/systemd/system/invoice-backend.service

# Service configuration
[Unit]
Description=Invoice Backend Server
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/path/to/invoice/backend
Environment=NODE_ENV=production
ExecStart=/usr/bin/node server.js
Restart=on-failure

[Install]
WantedBy=multi-user.target

# Enable and start service
sudo systemctl enable invoice-backend
sudo systemctl start invoice-backend
```

## Database Operations

### Connection Management

The application uses a singleton database configuration:

```javascript
const { databaseConfig } = require('./config/database');

// Get database instance
const db = databaseConfig.getDatabase();

// Execute operation with auto-connection management
const result = await databaseConfig.executeOperation(async (db) => {
  return await db.collection('users').findOne({ email });
});
```

### Database Health Check

```bash
# Test database connection
node -e "
const { databaseConfig } = require('./config/database');
databaseConfig.connect().then(() => {
  console.log('Database connection successful');
  process.exit(0);
}).catch(err => {
  console.error('Database connection failed:', err);
  process.exit(1);
});
"
```

### Index Management

Recommended indexes for optimal performance:

```javascript
// Audit logs indexes
db.auditLogs.createIndex({ "organizationId": 1, "timestamp": -1 });
db.auditLogs.createIndex({ "entityType": 1, "entityId": 1, "timestamp": -1 });
db.auditLogs.createIndex({ "userEmail": 1, "timestamp": -1 });

// User indexes
db.users.createIndex({ "email": 1 }, { unique: true });
db.users.createIndex({ "organizationId": 1 });

// Organization indexes
db.organizations.createIndex({ "organizationCode": 1 }, { unique: true });

// Client indexes
db.clients.createIndex({ "organizationId": 1 });
db.clients.createIndex({ "clientEmail": 1 });
```

### Backup Procedures

```bash
# Create database backup
mongodump --uri="$MONGODB_URI" --out="backup-$(date +%Y%m%d-%H%M%S)"

# Restore from backup
mongorestore --uri="$MONGODB_URI" --drop backup-directory/

# Automated backup script
#!/bin/bash
BACKUP_DIR="/backups/mongodb"
DATE=$(date +%Y%m%d-%H%M%S)
mkdir -p "$BACKUP_DIR"
mongodump --uri="$MONGODB_URI" --out="$BACKUP_DIR/backup-$DATE"

# Keep only last 7 days of backups
find "$BACKUP_DIR" -type d -name "backup-*" -mtime +7 -exec rm -rf {} \;
```

## Monitoring & Health Checks

### Application Health

#### Health Endpoint
```bash
# Check application health
curl http://localhost:8080/health

# Expected response
{
  "status": "OK",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

#### Firebase Messaging Check
```bash
# Check Firebase initialization in logs
tail -f server.log | grep "Firebase Messaging"

# Expected output
"✅ Firebase Messaging initialized successfully"
```

### Database Health

```bash
# MongoDB connection test
mongo "$MONGODB_URI" --eval "db.adminCommand('ping')"

# Check database collections
mongo "$MONGODB_URI" --eval "db.runCommand('listCollections')"
```

### Performance Monitoring

#### Key Metrics to Monitor
- Response time for health endpoint
- Database connection pool status
- Memory usage
- CPU utilization
- Error rates
- Active user sessions

#### Logging Configuration

The application includes comprehensive logging middleware:

```javascript
// Enable detailed logging
process.env.DEBUG_MODE = 'true';

// Audit trail logging
process.env.AUDIT_DEBUG = 'true';
```

## Troubleshooting Guide

### Common Issues

#### 1. Server Won't Start

**Symptoms:**
- Server exits immediately
- Port binding errors
- Environment variable errors

**Diagnosis:**
```bash
# Check port availability
netstat -tulpn | grep :8080

# Verify environment variables
node -e "console.log(process.env.MONGODB_URI ? 'DB URI set' : 'DB URI missing')"

# Test Firebase config
node -e "try { require('./firebase-admin-config'); console.log('Firebase OK'); } catch(e) { console.error('Firebase Error:', e.message); }"
```

**Solutions:**
- Change PORT in .env file
- Verify all required environment variables
- Regenerate Firebase configuration
- Check file permissions

#### 2. Database Connection Issues

**Symptoms:**
- "Database not connected" errors
- Connection timeout errors
- Authentication failures

**Diagnosis:**
```bash
# Test MongoDB connection
mongo "$MONGODB_URI" --eval "db.adminCommand('ping')"

# Check network connectivity
telnet <mongodb-host> <mongodb-port>

# Verify credentials
echo $MONGODB_URI | grep -o 'mongodb://[^@]*@'
```

**Solutions:**
- Verify MongoDB URI format
- Check network connectivity
- Validate credentials
- Ensure database exists
- Check firewall rules

#### 3. Authentication Failures

**Symptoms:**
- "Authentication failed" errors
- JWT token errors
- Firebase authentication issues

**Diagnosis:**
```bash
# Check JWT secret
node -e "console.log(process.env.JWT_SECRET ? 'JWT secret set' : 'JWT secret missing')"

# Test Firebase credentials
node -e "const admin = require('./firebase-admin-config'); console.log('Firebase project:', admin.app().options.projectId);"

# Check user exists
mongo "$MONGODB_URI" --eval "db.users.findOne({email: 'test@example.com'})"
```

**Solutions:**
- Verify JWT_SECRET is set
- Check Firebase credentials
- Validate user exists in database
- Check password encryption

#### 4. Email Service Issues

**Symptoms:**
- OTP emails not sending
- Email authentication errors

**Diagnosis:**
```bash
# Test email configuration
node -e "
const nodemailer = require('nodemailer');
const transporter = nodemailer.createTransporter({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_FOR_OTP,
    pass: process.env.EMAIL_PASSWORD
  }
});
transporter.verify((error, success) => {
  if (error) console.error('Email config error:', error);
  else console.log('Email config OK');
});
"
```

**Solutions:**
- Verify email credentials
- Check app password for Gmail
- Validate email service settings
- Test with different email provider

### Error Handling

The application includes comprehensive error handling:

#### Global Error Handler
```javascript
// Located in middleware/errorHandler.js
function errorHandler(err, req, res, next) {
  // Logs error details
  // Returns appropriate HTTP status
  // Sanitizes error messages for security
}
```

#### Common Error Responses

**400 Bad Request**
```json
{
  "statusCode": 400,
  "message": "Missing required fields: action, entityType, entityId"
}
```

**403 Forbidden**
```json
{
  "statusCode": 403,
  "message": "Access denied: User not found in organization"
}
```

**500 Internal Server Error**
```json
{
  "statusCode": 500,
  "message": "Internal server error",
  "error": "Database connection failed"
}
```

## Maintenance Procedures

### Regular Maintenance Tasks

#### Daily
- Check application health endpoint
- Monitor error logs
- Verify backup completion
- Check disk space usage

#### Weekly
- Review audit logs
- Check database performance
- Update security patches
- Clean up old log files

#### Monthly
- Database optimization
- Security audit
- Performance review
- Backup verification

### Database Maintenance

#### Index Optimization
```bash
# Analyze index usage
mongo "$MONGODB_URI" --eval "db.users.getIndexes()"

# Rebuild indexes
mongo "$MONGODB_URI" --eval "db.users.reIndex()"
```

#### Data Cleanup
```bash
# Clean old audit logs (older than 1 year)
mongo "$MONGODB_URI" --eval "
db.auditLogs.deleteMany({
  timestamp: { \$lt: new Date(Date.now() - 365 * 24 * 60 * 60 * 1000) }
})
"

# Clean expired OTP records
mongo "$MONGODB_URI" --eval "
db.otps.deleteMany({
  expiresAt: { \$lt: new Date() }
})
"
```

### Log Management

```bash
# Rotate application logs
logrotate /etc/logrotate.d/invoice-backend

# Clean old PM2 logs
pm2 flush

# Archive old logs
tar -czf logs-$(date +%Y%m%d).tar.gz *.log
mv logs-*.tar.gz /archive/
rm *.log
```

## Security Operations

### Security Monitoring

#### Failed Authentication Attempts
```bash
# Monitor failed login attempts
tail -f server.log | grep "Authentication failed"

# Check for suspicious activity
mongo "$MONGODB_URI" --eval "
db.auditLogs.find({
  action: 'LOGIN_FAILED',
  timestamp: { \$gte: new Date(Date.now() - 24 * 60 * 60 * 1000) }
}).count()
"
```

#### Security Updates
```bash
# Check for npm vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix

# Update dependencies
npm update
```

### Access Control

#### User Management
```bash
# List organization admins
mongo "$MONGODB_URI" --eval "
db.users.find({ role: 'admin' }, { email: 1, organizationId: 1 })
"

# Disable user account
mongo "$MONGODB_URI" --eval "
db.users.updateOne(
  { email: 'user@example.com' },
  { \$set: { isActive: false } }
)
"
```

## Backup & Recovery

### Backup Strategy

#### Automated Backup Script
```bash
#!/bin/bash
# backup.sh

set -e

BACKUP_DIR="/backups/invoice"
DATE=$(date +%Y%m%d-%H%M%S)
RETENTION_DAYS=30

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Database backup
echo "Starting database backup..."
mongodump --uri="$MONGODB_URI" --out="$BACKUP_DIR/db-$DATE"

# Application files backup
echo "Starting application backup..."
tar -czf "$BACKUP_DIR/app-$DATE.tar.gz" \
  --exclude="node_modules" \
  --exclude=".git" \
  --exclude="*.log" \
  /path/to/invoice/backend

# Clean old backups
echo "Cleaning old backups..."
find "$BACKUP_DIR" -type d -name "db-*" -mtime +$RETENTION_DAYS -exec rm -rf {} \;
find "$BACKUP_DIR" -name "app-*.tar.gz" -mtime +$RETENTION_DAYS -delete

echo "Backup completed: $DATE"
```

#### Schedule Backups
```bash
# Add to crontab
crontab -e

# Daily backup at 2 AM
0 2 * * * /path/to/backup.sh >> /var/log/backup.log 2>&1
```

### Recovery Procedures

#### Database Recovery
```bash
# List available backups
ls -la /backups/invoice/db-*

# Restore from backup
mongorestore --uri="$MONGODB_URI" --drop /backups/invoice/db-20240115-020000/

# Verify restoration
mongo "$MONGODB_URI" --eval "db.users.count()"
```

#### Application Recovery
```bash
# Stop application
pm2 stop invoice-backend

# Restore application files
tar -xzf /backups/invoice/app-20240115-020000.tar.gz -C /

# Restore dependencies
cd /path/to/invoice/backend
npm install

# Start application
pm2 start invoice-backend
```

## Performance Optimization

### Database Optimization

#### Query Performance
```bash
# Enable profiling
mongo "$MONGODB_URI" --eval "db.setProfilingLevel(2)"

# Analyze slow queries
mongo "$MONGODB_URI" --eval "db.system.profile.find().sort({ts: -1}).limit(5)"

# Disable profiling
mongo "$MONGODB_URI" --eval "db.setProfilingLevel(0)"
```

#### Index Analysis
```bash
# Check index usage
mongo "$MONGODB_URI" --eval "
db.users.aggregate([
  { \$indexStats: {} }
])
"
```

### Application Performance

#### Memory Monitoring
```bash
# Monitor memory usage
pm2 monit

# Check for memory leaks
node --inspect server.js
```

#### Response Time Optimization
- Enable compression middleware
- Implement caching strategies
- Optimize database queries
- Use connection pooling

## Emergency Procedures

### Service Outage Response

#### Immediate Actions
1. **Assess Impact**
   ```bash
   # Check service status
   curl -f http://localhost:8080/health || echo "Service DOWN"
   
   # Check database connectivity
   mongo "$MONGODB_URI" --eval "db.adminCommand('ping')" || echo "Database DOWN"
   ```

2. **Identify Root Cause**
   ```bash
   # Check application logs
   pm2 logs invoice-backend --lines 100
   
   # Check system resources
   top
   df -h
   free -m
   ```

3. **Immediate Recovery**
   ```bash
   # Restart application
   pm2 restart invoice-backend
   
   # If restart fails, check configuration
   node -c server.js
   ```

#### Escalation Procedures

**Level 1: Application Issues**
- Restart application service
- Check configuration files
- Review recent deployments

**Level 2: Database Issues**
- Check database connectivity
- Verify database server status
- Contact database administrator

**Level 3: Infrastructure Issues**
- Check server resources
- Contact system administrator
- Consider failover procedures

### Data Corruption Recovery

1. **Stop Application**
   ```bash
   pm2 stop invoice-backend
   ```

2. **Assess Damage**
   ```bash
   # Check database integrity
   mongo "$MONGODB_URI" --eval "db.runCommand({validate: 'users'})"
   ```

3. **Restore from Backup**
   ```bash
   # Restore latest backup
   mongorestore --uri="$MONGODB_URI" --drop /backups/invoice/latest/
   ```

4. **Verify Recovery**
   ```bash
   # Test critical functions
   curl -X POST http://localhost:8080/auth/login \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com","password":"test"}'
   ```

### Security Incident Response

#### Suspected Breach
1. **Immediate Actions**
   - Change all passwords
   - Revoke API keys
   - Enable additional logging
   - Notify stakeholders

2. **Investigation**
   ```bash
   # Check audit logs for suspicious activity
   mongo "$MONGODB_URI" --eval "
   db.auditLogs.find({
     timestamp: { \$gte: new Date(Date.now() - 24 * 60 * 60 * 1000) },
     action: { \$in: ['LOGIN_FAILED', 'UNAUTHORIZED_ACCESS'] }
   }).sort({timestamp: -1})
   "
   ```

3. **Recovery**
   - Patch security vulnerabilities
   - Update all credentials
   - Implement additional security measures
   - Document incident

---

## Contact Information

**Development Team:** [team@example.com]
**System Administrator:** [admin@example.com]
**Emergency Contact:** [emergency@example.com]

**Last Updated:** January 2024
**Document Version:** 1.0