# Photo Upload and Retrieval Testing Guide

This guide provides comprehensive instructions for testing the photo upload and retrieval functionality in the Invoice application.

## Overview

The photo functionality testing includes:
- **Backend Tests**: Node.js tests for API endpoints and database operations
- **Frontend Tests**: Flutter/Dart tests for UI components and API integration
- **Integration Tests**: End-to-end testing of the complete photo workflow

## Test Files Created

### Backend Tests
- **File**: `backend/test_photo_functionality.js`
- **Purpose**: Tests the Node.js server endpoints for photo upload and retrieval
- **Coverage**: API endpoints, database operations, error handling, data validation

### Frontend Tests
- **File**: `test/photo_functionality_test.dart`
- **Purpose**: Tests the Flutter application's photo functionality
- **Coverage**: API methods, UI components, local storage, error handling

## Prerequisites

### Backend Testing Requirements
```bash
# Install Node.js testing dependencies
cd backend
npm install --save-dev mocha chai supertest mongodb-memory-server
```

### Frontend Testing Requirements
```bash
# Install Flutter testing dependencies
flutter pub add --dev mockito build_runner
flutter pub get

# Generate mock files (required for frontend tests)
flutter packages pub run build_runner build
```

## Running the Tests

### Backend Tests

#### 1. Start MongoDB (if not using in-memory database)
```bash
# Option 1: Using Docker
docker run -d -p 27017:27017 --name test-mongo mongo:latest

# Option 2: Using local MongoDB installation
mongod --dbpath /path/to/your/test/db
```

#### 2. Run Backend Tests
```bash
cd backend

# Run all photo functionality tests
node test_photo_functionality.js

# Or using npm script (add to package.json)
npm test
```

#### 3. Expected Backend Test Output
```
Photo Functionality Tests
✓ should upload photo successfully
✓ should handle upload with missing file
✓ should handle upload with invalid email
✓ should retrieve photo successfully
✓ should handle photo retrieval for non-existent user
✓ should maintain data integrity between upload and retrieval
✓ should handle concurrent photo operations
✓ should validate photo file formats
✓ should handle large photo files
✓ should clean up test data properly

10 passing (2.5s)
```

### Frontend Tests

#### 1. Generate Mock Files
```bash
# Generate mocks for HTTP client and other dependencies
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### 2. Run Frontend Tests
```bash
# Run all photo functionality tests
flutter test test/photo_functionality_test.dart

# Run with verbose output
flutter test test/photo_functionality_test.dart --verbose

# Run specific test group
flutter test test/photo_functionality_test.dart --name "Photo Upload Tests"
```

#### 3. Expected Frontend Test Output
```
00:01 +0: Photo Functionality Tests Photo Upload Tests should upload photo successfully
00:02 +1: Photo Functionality Tests Photo Upload Tests should handle upload failure - no file
00:02 +2: Photo Functionality Tests Photo Retrieval Tests should retrieve photo successfully
00:03 +3: Photo Functionality Tests Photo Retrieval Tests should handle photo not found
00:03 +4: Photo Functionality Tests Data Integrity Tests should maintain data integrity between upload and retrieval
00:04 +5: Photo Functionality Tests Local Storage Tests should save photo data to local storage
00:04 +6: Photo Functionality Tests Error Handling Tests should handle network timeout
00:05 +7: Photo Functionality Tests Performance Tests should handle large image data efficiently
00:05 +8: All tests passed!
```

## Integration Testing

### Full End-to-End Test

#### 1. Start the Backend Server
```bash
cd backend
node server.js
```

#### 2. Run Integration Tests
```bash
# Backend integration test
cd backend
node -e "require('./test_photo_functionality.js').PhotoIntegrationTestHelper.runIntegrationTests()"

# Frontend integration test (requires running app)
flutter test test/photo_functionality_test.dart --name "Integration"
```

## Test Configuration

### Backend Test Configuration

The backend tests use the following configuration:

```javascript
// Test configuration in test_photo_functionality.js
const TEST_CONFIG = {
  mongoUrl: 'mongodb://localhost:27017/invoice_test',
  serverPort: 8081, // Different from main server
  testEmail: 'test.photo@example.com',
  maxFileSize: 5 * 1024 * 1024, // 5MB
  allowedFormats: ['jpg', 'jpeg', 'png', 'gif']
};
```

### Frontend Test Configuration

The frontend tests use the following configuration:

```dart
// Test configuration in photo_functionality_test.dart
class PhotoFunctionalityTest {
  static const String testEmail = 'test.photo@example.com';
  static const String baseUrl = 'http://localhost:8080';
  // ... other configuration
}
```

## Test Data Management

### Automatic Cleanup

Both test suites include automatic cleanup:

- **Backend**: Removes test users and photos from database after each test
- **Frontend**: Clears local storage and temporary files

### Manual Cleanup (if needed)

```bash
# Clean up test database
mongo invoice_test --eval "db.dropDatabase()"

# Clean up test files
rm -rf /tmp/test_photos/

# Clear Flutter test cache
flutter clean
flutter pub get
```

## Troubleshooting

### Common Issues

#### 1. Backend Tests Failing

**Issue**: `ECONNREFUSED` error
```
Solution: Ensure MongoDB is running on the correct port
mongod --port 27017
```

**Issue**: `Port already in use`
```bash
# Find and kill process using the port
lsof -ti:8081 | xargs kill
```

#### 2. Frontend Tests Failing

**Issue**: Mock generation errors
```bash
# Regenerate mocks
flutter packages pub run build_runner clean
flutter packages pub run build_runner build
```

**Issue**: Missing dependencies
```bash
# Reinstall dependencies
flutter clean
flutter pub get
```

#### 3. Integration Tests Failing

**Issue**: Backend not responding
```bash
# Check if backend is running
curl http://localhost:8080/health

# Restart backend if needed
cd backend
node server.js
```

### Debug Mode

#### Backend Debug Mode
```bash
# Run tests with debug output
DEBUG=true node test_photo_functionality.js
```

#### Frontend Debug Mode
```bash
# Run tests with verbose output
flutter test test/photo_functionality_test.dart --verbose --reporter=expanded
```

## Test Coverage

### Backend Test Coverage

- ✅ Photo upload endpoint (`/uploadPhoto`)
- ✅ Photo retrieval endpoint (`/getUserPhoto/:email`)
- ✅ Database operations (MongoDB)
- ✅ File validation and processing
- ✅ Error handling and edge cases
- ✅ Data integrity and consistency
- ✅ Performance and concurrency

### Frontend Test Coverage

- ✅ API method calls (`uploadPhoto`, `getUserPhoto`)
- ✅ Local storage operations
- ✅ Base64 encoding/decoding
- ✅ Error handling and network issues
- ✅ Data validation and integrity
- ✅ Performance with large files
- ✅ UI component integration

## Performance Benchmarks

### Expected Performance Metrics

| Operation | Expected Time | Max File Size |
|-----------|---------------|---------------|
| Photo Upload | < 2 seconds | 5MB |
| Photo Retrieval | < 1 second | N/A |
| Base64 Encoding | < 500ms | 5MB |
| Database Query | < 100ms | N/A |

### Performance Testing

```bash
# Run performance-specific tests
flutter test test/photo_functionality_test.dart --name "Performance Tests"
node test_photo_functionality.js --grep "Performance"
```

## Continuous Integration

### GitHub Actions Example

```yaml
# .github/workflows/photo-tests.yml
name: Photo Functionality Tests

on: [push, pull_request]

jobs:
  backend-tests:
    runs-on: ubuntu-latest
    services:
      mongodb:
        image: mongo:4.4
        ports:
          - 27017:27017
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '16'
      - run: cd backend && npm install
      - run: cd backend && node test_photo_functionality.js

  frontend-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.0.0'
      - run: flutter pub get
      - run: flutter packages pub run build_runner build
      - run: flutter test test/photo_functionality_test.dart
```

## Security Testing

### Security Test Cases Included

- ✅ File type validation
- ✅ File size limits
- ✅ SQL injection prevention
- ✅ XSS prevention in file names
- ✅ Authentication checks
- ✅ Data sanitization

### Manual Security Testing

```bash
# Test file upload with malicious files
curl -X POST -F "photo=@malicious.exe" -F "email=test@example.com" http://localhost:8080/uploadPhoto

# Test with oversized files
dd if=/dev/zero of=large.jpg bs=1M count=10
curl -X POST -F "photo=@large.jpg" -F "email=test@example.com" http://localhost:8080/uploadPhoto
```

## Maintenance

### Regular Test Maintenance

1. **Weekly**: Run full test suite
2. **Monthly**: Update test data and scenarios
3. **Quarterly**: Review and update performance benchmarks
4. **Annually**: Security audit and penetration testing

### Test Data Refresh

```bash
# Refresh test images
cd backend
node -e "require('./test_photo_functionality.js').TestDataManager.refreshTestImages()"
```

## Support

For issues with the photo testing functionality:

1. Check this README for common solutions
2. Review the test output for specific error messages
3. Ensure all prerequisites are installed and configured
4. Verify that both backend and database are running
5. Check network connectivity between components

---

**Last Updated**: $(date)
**Test Suite Version**: 1.0.0
**Compatibility**: Node.js 16+, Flutter 3.0+, MongoDB 4.4+