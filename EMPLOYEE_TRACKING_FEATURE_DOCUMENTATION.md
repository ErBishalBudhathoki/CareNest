# Employee Tracking Feature Documentation

## Overview

The Employee Tracking feature provides real-time monitoring and management of employee work status, shifts, and assignments within an organization. This feature enables administrators to track employee activities, monitor work hours, and manage client assignments effectively.

## Architecture

The feature follows Clean Architecture principles with clear separation of concerns:

```
lib/app/features/employee_tracking/
├── models/
│   ├── employee_tracking_model.dart
│   ├── employee_tracking_model.freezed.dart
│   └── employee_tracking_model.g.dart
├── repositories/
│   └── employee_tracking_repository.dart
├── viewmodels/
│   └── employee_tracking_viewmodel.dart
├── views/
│   └── employee_tracking_view.dart
└── widgets/
    ├── employee_status_card.dart
    └── employee_stats_overview.dart
```

## Core Components

### 1. Data Models

#### EmployeeTrackingData
Main data container that holds all employee tracking information:
- `employees`: List of employee status objects
- `shifts`: List of shift details
- `assignments`: List of client assignments
- `totalEmployees`: Total number of employees
- `activeEmployees`: Number of currently active employees
- `onBreakEmployees`: Number of employees on break
- `offlineEmployees`: Number of offline employees

#### EmployeeStatus
Represents individual employee status:
- `id`: Unique employee identifier
- `name`: Employee name
- `email`: Employee email
- `status`: Current work status (WorkStatus enum)
- `profileImage`: Employee profile image URL
- `currentLocation`: Current location information
- `lastSeen`: Last activity timestamp

#### WorkStatus Enum
- `active`: Employee is currently working
- `onBreak`: Employee is on break
- `offline`: Employee is not working

#### ShiftDetail
Contains shift information:
- `id`: Shift identifier
- `employeeId`: Associated employee ID
- `startTime`: Shift start time
- `endTime`: Shift end time
- `status`: Shift status (ShiftStatus enum)
- `totalHours`: Total hours worked
- `clientId`: Associated client ID

#### ClientAssignment
Manages client-employee assignments:
- `id`: Assignment identifier
- `employeeId`: Assigned employee ID
- `clientId`: Client identifier
- `clientName`: Client name
- `status`: Assignment status (AssignmentStatus enum)
- `assignedDate`: Assignment date
- `description`: Assignment description

### 2. Repository Layer

#### EmployeeTrackingRepository
Handles data fetching and API communication:
- `getEmployeeTrackingData()`: Fetches comprehensive employee tracking data
- Integrates with backend API endpoint `/getEmployeeTrackingData/:organizationId`
- Manages data transformation from API response to domain models
- Handles error scenarios and data validation

**Key Features:**
- Retrieves organization ID from SharedPreferences
- Transforms API response data into typed models
- Calculates employee status based on active timers
- Creates unique display names for employees
- Handles data parsing and validation

### 3. State Management

#### EmployeeTrackingViewModel
Manages application state using Riverpod:
- `loadEmployeeTrackingData()`: Loads initial data
- `refreshEmployeeTrackingData()`: Refreshes data
- `setEmployeeFilter()`: Sets status filter
- `updateEmployeeStatus()`: Updates individual employee status
- `getEmployeeById()`: Retrieves specific employee
- `getEmployeeShifts()`: Gets employee shift history
- `getEmployeeAssignments()`: Gets employee assignments

**State Structure:**
```dart
class EmployeeTrackingState {
  final EmployeeTrackingData data;
  final WorkStatus? selectedFilter;
  final bool isRefreshing;
}
```

**Providers:**
- `employeeTrackingRepositoryProvider`: Repository instance
- `employeeTrackingViewModelProvider`: Main state provider
- `filteredEmployeesProvider`: Filtered employees by status
- `employeeStatsProvider`: Employee statistics

### 4. User Interface

#### EmployeeTrackingView
Main screen component featuring:
- **Stats Overview**: Displays total, active, on break, and offline employee counts
- **Filter Chips**: Allows filtering employees by status
- **Employee List**: Shows employee cards with status information
- **Quick Actions**: Provides quick access to common operations
- **Real-time Updates**: Periodic data refresh (every 30 seconds)
- **Pull-to-Refresh**: Manual refresh capability

**Key Features:**
- Responsive design with proper loading states
- Error handling with user-friendly messages
- Smooth animations and transitions
- Bottom sheet for detailed employee information
- Navigation integration with admin dashboard

#### EmployeeStatusCard
Individual employee display component:
- Employee avatar with status indicator
- Name and email display
- Status badge with color coding
- Tap interaction for detailed view
- Animation effects for better UX

#### EmployeeStatsOverview
Statistics display component:
- Grid layout for stat cards
- Color-coded status indicators
- Refresh button integration
- Loading state animations
- Responsive design for different screen sizes

## Backend Integration

### API Endpoint
**GET** `/getEmployeeTrackingData/:organizationId`

Provides comprehensive employee tracking data including:
- Active employee timers
- Worked time records with shift details
- Employee assignments and client information
- Calculated statistics and summaries

**Response Structure:**
```json
{
  "employees": [...],
  "shifts": [...],
  "assignments": [...],
  "totalEmployees": 0,
  "activeEmployees": 0,
  "onBreakEmployees": 0,
  "offlineEmployees": 0
}
```

**Backend Features:**
- MongoDB integration for data retrieval
- Real-time timer status calculation
- Sample data generation for testing
- Error handling and logging
- Performance optimization

## Key Features

### 1. Real-time Employee Monitoring
- Live status tracking (active, on break, offline)
- Automatic status updates based on timer activity
- Last seen timestamps
- Location tracking (if enabled)

### 2. Shift Management
- Detailed shift records
- Time tracking and calculations
- Shift status monitoring
- Historical shift data

### 3. Client Assignment Tracking
- Employee-client assignment management
- Assignment status tracking
- Client information display
- Assignment history

### 4. Statistics and Analytics
- Real-time employee count by status
- Work hour summaries
- Performance metrics
- Visual data representation

### 5. Filtering and Search
- Status-based filtering
- Employee search functionality
- Quick access to specific employees
- Customizable view options

## Data Flow

1. **Initialization**: ViewModel loads data from repository
2. **API Call**: Repository fetches data from backend endpoint
3. **Data Processing**: Raw API data transformed to domain models
4. **State Update**: UI state updated with new data
5. **UI Rendering**: Components render based on current state
6. **User Interaction**: User actions trigger state changes
7. **Refresh Cycle**: Periodic updates maintain data freshness

## Error Handling

- **Network Errors**: Graceful handling with retry mechanisms
- **Data Validation**: Input validation and sanitization
- **State Errors**: Proper error state management
- **User Feedback**: Clear error messages and recovery options
- **Logging**: Comprehensive error logging for debugging

## Performance Optimizations

- **Efficient State Management**: Riverpod for optimal rebuilds
- **Data Caching**: Local data caching for better performance
- **Lazy Loading**: On-demand data loading
- **Memory Management**: Proper disposal of resources
- **Network Optimization**: Efficient API calls and data transfer

## Security Considerations

- **Authentication**: Secure API endpoint access
- **Authorization**: Role-based access control
- **Data Privacy**: Sensitive information protection
- **Input Validation**: Server-side validation
- **Secure Storage**: Safe handling of user data

## Testing Strategy

- **Unit Tests**: Individual component testing
- **Integration Tests**: Feature flow testing
- **Widget Tests**: UI component testing
- **API Tests**: Backend endpoint testing
- **Performance Tests**: Load and stress testing

## Future Enhancements

- **Push Notifications**: Real-time status change notifications
- **Advanced Analytics**: Detailed reporting and insights
- **Geofencing**: Location-based status updates
- **Offline Support**: Offline data synchronization
- **Export Features**: Data export capabilities
- **Advanced Filtering**: More sophisticated filtering options

## Dependencies

- **flutter_riverpod**: State management
- **freezed**: Immutable data classes
- **json_annotation**: JSON serialization
- **flutter_animate**: UI animations
- **shared_preferences**: Local data storage

## Usage Examples

### Loading Employee Data
```dart
// In a widget
final trackingState = ref.watch(employeeTrackingViewModelProvider);

trackingState.when(
  data: (state) => EmployeeList(employees: state.data.employees),
  loading: () => LoadingIndicator(),
  error: (error, stack) => ErrorWidget(error),
);
```

### Filtering Employees
```dart
// Filter by status
final activeEmployees = ref.watch(
  filteredEmployeesProvider(WorkStatus.active)
);
```

### Refreshing Data
```dart
// Manual refresh
ref.read(employeeTrackingViewModelProvider.notifier)
   .refreshEmployeeTrackingData();
```

## Troubleshooting

### Common Issues

1. **Data Not Loading**
   - Check network connectivity
   - Verify API endpoint availability
   - Check organization ID in SharedPreferences

2. **Status Not Updating**
   - Verify timer functionality
   - Check backend timer calculations
   - Ensure proper data refresh intervals

3. **Performance Issues**
   - Monitor memory usage
   - Check for memory leaks
   - Optimize data processing

### Debug Information

The feature includes comprehensive debug logging:
- Repository operations
- API calls and responses
- State changes
- Error conditions

## Conclusion

The Employee Tracking feature provides a comprehensive solution for monitoring and managing employee work activities. With its clean architecture, robust state management, and user-friendly interface, it offers a scalable and maintainable approach to employee tracking in modern applications.

For additional support or feature requests, please refer to the project documentation or contact the development team.