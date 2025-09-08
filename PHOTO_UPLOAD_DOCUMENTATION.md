# Photo Upload, Retrieval, and Display Documentation

## Overview

This document provides comprehensive documentation for the photo upload, retrieval, and display functionality in the CareNest Flutter application. The system allows users to upload profile pictures, store them in MongoDB, and display them throughout the application.

## Architecture Overview

### Components

1. **Frontend (Flutter)**
   - Photo upload UI
   - Image picker and cropper
   - Photo display widgets
   - State management with providers
   - Local caching with SharedPreferences

2. **Backend (Node.js/Express)**
   - Photo upload endpoint
   - Photo retrieval endpoint
   - MongoDB integration
   - File handling with Multer

3. **Database (MongoDB)**
   - Photo data stored in `login` collection
   - Base64 encoded image data
   - User association via email

## File Structure

### Frontend Files

```
lib/
├── app/
│   ├── features/
│   │   ├── auth/
│   │   │   └── views/
│   │   │       └── photo_upload_view.dart
│   │   └── home/
│   │       └── views/
│   │           └── home_view.dart
│   ├── providers/
│   │   └── app_providers.dart
│   └── utils/
│       ├── api_method.dart
│       └── shared_preferences_utils.dart
```

### Backend Files

```
backend/
├── server.js
├── uploads/          # Temporary file storage
└── .env             # Environment variables
```

## Detailed Implementation

### 1. Photo Upload Flow

#### Frontend Implementation

**File: `lib/app/features/auth/views/photo_upload_view.dart`**

```dart
// Key components:
// - Image picker integration
// - Image cropping functionality
// - Upload progress indication
// - Error handling

class PhotoUploadView extends StatefulWidget {
  // Image selection from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    // Image cropping and processing
  }
  
  // Upload image to backend
  Future<void> _uploadImage() async {
    final result = await ApiMethod().uploadPhoto(email, imageFile);
    // Handle upload result
  }
}
```

**File: `lib/app/utils/api_method.dart`**

```dart
// Photo upload API method
Future<Map<String, dynamic>> uploadPhoto(String email, File imageFile) async {
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/uploadPhoto'));
  request.fields['email'] = email;
  request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path));
  
  var response = await request.send();
  var responseData = await response.stream.bytesToString();
  return json.decode(responseData);
}
```

#### Backend Implementation

**File: `backend/server.js`**

```javascript
// Configure multer for file uploads
const upload = multer({
  storage: multer.diskStorage({
    destination: "./uploads",
    filename: (req, file, cb) => {
      cb(null, file.originalname);
    },
  }),
  allowedFiles: ["image/jpeg", "image/png", "image/heif"],
});

// Photo upload endpoint
app.post('/uploadPhoto', upload.single('photo'), async (req, res) => {
  const { email } = req.body;
  
  console.log('uploadPhoto called for:', email);
  
  if (!req.file) {
    return res.status(400).json({
      statusCode: 400,
      message: "No photo file provided"
    });
  }
  
  try {
    // Read and encode image file
    const fs = require('fs');
    const photoData = fs.readFileSync(req.file.path);
    const base64PhotoData = photoData.toString('base64');
    
    // Connect to MongoDB
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    // Update user document with photo data
    const result = await db.collection("login").updateOne(
      { email: email, isActive: true },
      { 
        $set: { 
          photoData: base64PhotoData,
          filename: req.file.originalname,
          updatedAt: new Date()
        } 
      }
    );
    
    await client.close();
    
    // Clean up temporary file
    fs.unlinkSync(req.file.path);
    
    if (result.matchedCount > 0) {
      res.status(200).json({
        statusCode: 200,
        message: "Photo uploaded successfully"
      });
    } else {
      res.status(404).json({
        statusCode: 404,
        message: "User not found"
      });
    }
    
  } catch (error) {
    console.error('Error uploading photo:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error uploading photo"
    });
  }
});
```

### 2. Photo Retrieval Flow

#### Backend Implementation

**File: `backend/server.js`**

```javascript
// Photo retrieval endpoint
app.get('/getUserPhoto/:email', async (req, res) => {
  const { email } = req.params;
  
  console.log('getUserPhoto called for:', email);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    // Query login collection for user photo data
    const user = await db.collection("login").findOne({ 
      email: email,
      isActive: true 
    });
    
    console.log('User found:', !!user);
    if (user) {
      console.log('User has photoData:', !!user.photoData);
      console.log('PhotoData type:', typeof user.photoData);
      console.log('PhotoData length:', user.photoData ? user.photoData.length : 0);
    }
    
    if (!user) {
      await client.close();
      console.log('Returning 404: User not found');
      return res.status(404).json({
        statusCode: 404,
        message: "User not found"
      });
    }
    
    // Check if user has photo data
    if (!user.photoData) {
      await client.close();
      console.log('Returning 404: Photo not found for user');
      return res.status(404).json({
        statusCode: 404,
        message: "Photo not found",
        userExists: true,
        hasPhoto: false
      });
    }
    
    await client.close();
    console.log('Returning 200: Photo found');
    
    res.status(200).json({
      statusCode: 200,
      message: "Photo found",
      success: true,
      data: user.photoData
    });
    
  } catch (error) {
    console.error('Error getting user photo:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting user photo"
    });
  }
});
```

#### Frontend Implementation

**File: `lib/app/utils/api_method.dart`**

```dart
// Photo retrieval API method
Future<Uint8List?> getUserPhoto(String email) async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/getUserPhoto/$email'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      
      if (jsonResponse.containsKey('data') && jsonResponse['data'] != null) {
        // Decode base64 photo data
        final String base64String = jsonResponse['data'];
        final Uint8List photoData = base64Decode(base64String);
        return photoData;
      }
    } else if (response.statusCode == 404) {
      print('Photo not found for user: $email');
      return null;
    } else {
      print('Error getting user photo: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Exception getting user photo: $e');
    return null;
  }
  
  return null;
}
```

### 3. Photo Display and Caching

#### State Management

**File: `lib/app/providers/app_providers.dart`**

```dart
// Photo data provider with caching
class PhotoDataNotifier extends StateNotifier<Uint8List?> {
  PhotoDataNotifier() : super(null);
  
  // Load photo data with caching
  Future<void> loadPhotoData(String email) async {
    try {
      // Try to get from cache first
      final cachedPhoto = await SharedPreferencesUtils.getPhotoData();
      if (cachedPhoto != null) {
        state = cachedPhoto;
        return;
      }
      
      // Fetch from API if not cached
      final photoData = await ApiMethod().getUserPhoto(email);
      if (photoData != null) {
        state = photoData;
        // Cache the photo data
        await SharedPreferencesUtils.savePhotoData(photoData);
      }
    } catch (e) {
      print('Error loading photo data: $e');
      state = null;
    }
  }
  
  // Clear photo data
  void clearPhotoData() {
    state = null;
    SharedPreferencesUtils.clearPhotoData();
  }
}

// Provider definition
final photoDataProvider = StateNotifierProvider<PhotoDataNotifier, Uint8List?>(
  (ref) => PhotoDataNotifier(),
);
```

#### Local Caching

**File: `lib/app/utils/shared_preferences_utils.dart`**

```dart
class SharedPreferencesUtils {
  static const String _photoDataKey = 'photo_data';
  
  // Save photo data to local storage
  static Future<void> savePhotoData(Uint8List photoData) async {
    final prefs = await SharedPreferences.getInstance();
    final base64String = base64Encode(photoData);
    await prefs.setString(_photoDataKey, base64String);
    print('Photo data saved to SharedPreferences');
  }
  
  // Get photo data from local storage
  static Future<Uint8List?> getPhotoData() async {
    final prefs = await SharedPreferences.getInstance();
    final base64String = prefs.getString(_photoDataKey);
    
    if (base64String != null) {
      try {
        return base64Decode(base64String);
      } catch (e) {
        print('Error decoding cached photo data: $e');
        return null;
      }
    }
    
    return null;
  }
  
  // Clear photo data from local storage
  static Future<void> clearPhotoData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_photoDataKey);
    print('Photo data cleared from SharedPreferences');
  }
}
```

#### UI Display

**File: `lib/app/features/home/views/home_view.dart`**

```dart
// Photo display in app bar
Widget _buildAppBar(BuildContext context, WidgetRef ref) {
  final photoData = ref.watch(photoDataProvider);
  
  return AppBar(
    title: Text('Home'),
    actions: [
      GestureDetector(
        onTap: () => _showProfileMenu(context),
        child: Container(
          margin: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: photoData != null 
                ? MemoryImage(photoData) 
                : AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
    ],
  );
}
```

## Database Schema

### MongoDB Collection: `login`

```javascript
{
  "_id": ObjectId,
  "email": String,
  "firstName": String,
  "lastName": String,
  "password": String,
  "role": String,
  "abn": String,
  "organizationId": String,
  "organizationName": String,
  "isActive": Boolean,
  "createdAt": Date,
  "lastLogin": Date,
  
  // Photo-related fields
  "photoData": String,      // Base64 encoded image data
  "filename": String,       // Original filename
  "updatedAt": Date         // Last photo update timestamp
}
```

## API Endpoints

### 1. Upload Photo

**Endpoint:** `POST /uploadPhoto`

**Request:**
- Method: POST
- Content-Type: multipart/form-data
- Body:
  - `email`: User email (form field)
  - `photo`: Image file (form file)

**Response:**
```javascript
// Success (200)
{
  "statusCode": 200,
  "message": "Photo uploaded successfully"
}

// Error (400) - No file provided
{
  "statusCode": 400,
  "message": "No photo file provided"
}

// Error (404) - User not found
{
  "statusCode": 404,
  "message": "User not found"
}

// Error (500) - Server error
{
  "statusCode": 500,
  "message": "Error uploading photo"
}
```

### 2. Get User Photo

**Endpoint:** `GET /getUserPhoto/:email`

**Request:**
- Method: GET
- URL Parameter: `email` (user email)

**Response:**
```javascript
// Success (200)
{
  "statusCode": 200,
  "message": "Photo found",
  "success": true,
  "data": "base64_encoded_image_data"
}

// Error (404) - User not found
{
  "statusCode": 404,
  "message": "User not found"
}

// Error (404) - Photo not found
{
  "statusCode": 404,
  "message": "Photo not found",
  "userExists": true,
  "hasPhoto": false
}

// Error (500) - Server error
{
  "statusCode": 500,
  "message": "Error getting user photo"
}
```

## Security Considerations

### File Upload Security

1. **File Type Validation**
   - Only allows specific image formats: JPEG, PNG, HEIF
   - Configured in Multer middleware

2. **File Size Limits**
   - Multer can be configured with file size limits
   - Recommended: 5MB maximum

3. **Temporary File Cleanup**
   - Uploaded files are immediately processed and deleted
   - No persistent file storage on server

### Data Security

1. **Base64 Encoding**
   - Images stored as base64 strings in MongoDB
   - No direct file system access required

2. **User Authentication**
   - Photo operations require valid user email
   - Active user validation (`isActive: true`)

3. **Error Handling**
   - Comprehensive error handling prevents data leaks
   - Detailed logging for debugging

## Performance Considerations

### Caching Strategy

1. **Local Caching**
   - Photos cached in SharedPreferences
   - Reduces API calls and improves performance
   - Cache invalidation on logout

2. **Memory Management**
   - Efficient Uint8List handling
   - Proper disposal of image resources

### Optimization Recommendations

1. **Image Compression**
   - Implement client-side image compression
   - Reduce base64 data size

2. **Lazy Loading**
   - Load photos only when needed
   - Implement placeholder images

3. **CDN Integration**
   - Consider moving to cloud storage (AWS S3, Firebase Storage)
   - Implement CDN for better performance

## Recent Bug Fix

### Issue Description

Users reported that profile images were not displaying after login, despite being stored in the MongoDB `login` collection. Debug logs showed "no image no photoData" messages.

### Root Cause

The `getUserPhoto` endpoint was querying the wrong MongoDB collection:
- **Photo Upload**: Correctly stored data in `login` collection
- **Photo Retrieval**: Incorrectly queried `userPhoto` collection

### Fix Applied

**File:** `backend/server.js` (Line 873)

```javascript
// Before (incorrect)
const user = await db.collection("userPhoto").findOne({ 
  email: email,
  isActive: true 
});

// After (fixed)
const user = await db.collection("login").findOne({ 
  email: email,
  isActive: true 
});
```

### Verification

1. Backend server restarted with fix
2. Photo retrieval now queries correct collection
3. Profile images should display properly after login

## Testing

### Manual Testing Steps

1. **Photo Upload Test**
   - Navigate to photo upload screen
   - Select image from gallery or camera
   - Crop image if needed
   - Upload and verify success message

2. **Photo Display Test**
   - Log out and log back in
   - Verify profile image appears in app bar
   - Check navigation drawer photo

3. **Cache Test**
   - Upload photo and verify display
   - Close and reopen app
   - Verify photo loads from cache

### Debug Logging

The system includes comprehensive logging:

```javascript
// Backend logging
console.log('uploadPhoto called for:', email);
console.log('getUserPhoto called for:', email);
console.log('User found:', !!user);
console.log('User has photoData:', !!user.photoData);
```

```dart
// Frontend logging
print('Photo data saved to SharedPreferences');
print('Photo not found for user: $email');
print('Error loading photo data: $e');
```

## Future Enhancements

### Planned Improvements

1. **Cloud Storage Integration**
   - Migrate from MongoDB to cloud storage
   - Implement Firebase Storage or AWS S3
   - Store only URLs in database

2. **Image Processing**
   - Server-side image optimization
   - Multiple image sizes (thumbnail, full)
   - WebP format support

3. **Advanced Caching**
   - Implement proper cache expiration
   - Cache invalidation strategies
   - Background photo updates

4. **UI/UX Improvements**
   - Photo upload progress indicator
   - Image preview before upload
   - Batch photo operations

### Technical Debt

1. **MongoDB Deprecation Warnings**
   - Update MongoDB driver configuration
   - Remove deprecated options

2. **Error Handling**
   - Implement retry mechanisms
   - Better user feedback for failures

3. **Code Organization**
   - Extract photo service classes
   - Implement proper dependency injection

## Troubleshooting

### Common Issues

1. **Photo Not Displaying**
   - Check backend logs for getUserPhoto calls
   - Verify user exists in login collection
   - Check photoData field exists and has content

2. **Upload Failures**
   - Verify file format is supported
   - Check network connectivity
   - Review backend upload logs

3. **Cache Issues**
   - Clear app data to reset cache
   - Check SharedPreferences storage
   - Verify cache invalidation on logout

### Debug Commands

```bash
# Check backend server status
lsof -ti:8080

# View backend logs
node server.js

# Flutter debug logs
flutter run --verbose
```

## Configuration

### Environment Variables

**File:** `backend/.env`
```
MONGODB_URI=mongodb://localhost:27017/Invoice
PORT=8080
```

**File:** `lib/.env`
```
DEBUG_URL=http://192.168.20.18:8080/
```

### Dependencies

**Backend:**
```json
{
  "multer": "^1.4.5-lts.1",
  "mongodb": "^4.0.0",
  "express": "^4.18.0"
}
```

**Frontend:**
```yaml
dependencies:
  image_picker: ^0.8.6
  image_cropper: ^3.0.1
  shared_preferences: ^2.0.15
  flutter_riverpod: ^2.6.1
```

---

*This documentation was last updated after fixing the getUserPhoto collection query issue.*