# How to Navigate to Employee Tracking Screen

The Flutter app is now running and auto-logged in with test@tester.com.

To see the debug logs from employee_tracking_repository.dart:

1. In the running Flutter app, navigate to the Employee Tracking screen
2. This should trigger the API call to fetch employee data
3. Watch the console logs for debug output like:
   - "Processing assignment for email: [email], userName: [name]"
   - "Final assignment data: [data]"
   - "User status: [status]"
   - "Display name: [displayName]"
   - "Final transformed employees data: [data]"

Expected debug output should show:
- test@tester.com with userName: test test
- test1@tester.com with userName: bishal bud

If the names appear swapped in the UI but correct in debug logs, the issue is in the frontend data processing or display logic.