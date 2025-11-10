import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// Utility script to fix organizationId for existing client and assignment records
/// This script should be run once to fix the data integrity issue

class OrganizationIdFixer {
  // Update this URL based on your environment
  static const String baseUrl = 'http://localhost:8080/';
  
  /// Fix organizationId for a specific user
  static Future<void> fixUserOrganizationId(String userEmail, String organizationId) async {
    try {
      debugPrint('Fixing organizationId for user: $userEmail');
      
      final requestData = {
        'userEmail': userEmail,
        'organizationId': organizationId,
      };

      final response = await http.post(
        Uri.parse('${baseUrl}fixClientOrganizationId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      final result = jsonDecode(response.body);
      
      if (result['success'] == true) {
        debugPrint('✅ Success: ${result['message']}');
        debugPrint('   - Clients updated: ${result['clientsUpdated']}');
        debugPrint('   - Assignments updated: ${result['assignmentsUpdated']}');
      } else {
        debugPrint('❌ Error: ${result['error']}');
      }
    } catch (e) {
      debugPrint('❌ Exception: $e');
    }
  }
  
  /// Fix organizationId for multiple users
  static Future<void> fixMultipleUsers(List<Map<String, String>> userOrgPairs) async {
    debugPrint('Starting organizationId fix for ${userOrgPairs.length} users...');
    debugPrint('=' * 60);
    
    for (int i = 0; i < userOrgPairs.length; i++) {
      final userEmail = userOrgPairs[i]['userEmail']!;
      final organizationId = userOrgPairs[i]['organizationId']!;
      
      debugPrint('\n[${i + 1}/${userOrgPairs.length}] Processing: $userEmail');
      await fixUserOrganizationId(userEmail, organizationId);
      
      // Add a small delay to avoid overwhelming the server
      await Future.delayed(Duration(milliseconds: 500));
    }
    
    debugPrint('\n' + '=' * 60);
    debugPrint('✅ Completed fixing organizationId for all users!');
  }
}

/// Main function to run the fix
void main() async {
  debugPrint('🔧 Organization ID Fixer Utility');
  debugPrint('This script will fix null organizationId values in client and assignment records.');
  debugPrint('');
  
  // Example usage - Update these with your actual user emails and organization IDs
  final usersToFix = [
    {
      'userEmail': 'test@tester.com',
      'organizationId': '6846b040808f01d85897bbd8'  // testers123 organization
    },
    {
      'userEmail': 'test@test.com', 
      'organizationId': '674ffed80aff010e93f89938'  // test organization
    },
    // Add more users as needed
  ];
  
  debugPrint('⚠️  IMPORTANT: Please verify the following before proceeding:');
  debugPrint('   1. The server is running at: ${OrganizationIdFixer.baseUrl}');
  debugPrint('   2. The organizationId values are correct');
  debugPrint('   3. You have backed up your database');
  debugPrint('');
  
  stdout.write('Do you want to proceed? (y/N): ');
  final input = stdin.readLineSync()?.toLowerCase();
  
  if (input == 'y' || input == 'yes') {
    await OrganizationIdFixer.fixMultipleUsers(usersToFix);
  } else {
    debugPrint('Operation cancelled.');
  }
}