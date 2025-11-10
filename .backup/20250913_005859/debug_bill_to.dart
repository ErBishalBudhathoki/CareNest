import 'package:flutter/foundation.dart';
// Debug script to test Bill To section functionality
// This script demonstrates the expected behavior of the Bill To section

void main() {
  debugPrint('=== Bill To Section Debug ===\n');

  // Test case 1: Client with business name
  Map<String, dynamic> clientWithBusiness = {
    'clientFirstName': 'John',
    'clientLastName': 'Doe',
    'clientEmail': 'john.doe@example.com',
    'clientAddress': '123 Main St',
    'clientCity': 'Sydney',
    'clientState': 'NSW',
    'clientZip': '2000',
    'clientPhone': '+61 2 1234 5678',
    'businessName': 'Doe Enterprises',
  };

  // Test case 2: Client without business name
  Map<String, dynamic> clientWithoutBusiness = {
    'clientFirstName': 'Jane',
    'clientLastName': 'Smith',
    'clientEmail': 'jane.smith@example.com',
    'clientAddress': '456 Oak Ave',
    'clientCity': 'Melbourne',
    'clientState': 'VIC',
    'clientZip': '3000',
    'clientPhone': '+61 3 5678 9012',
    'businessName': '', // Empty business name
  };

  // Test case 3: Client with missing data
  Map<String, dynamic> clientWithMissingData = {
    'clientFirstName': '',
    'clientLastName': '',
    'clientEmail': 'unknown@example.com',
    'clientAddress': '',
    'clientCity': '',
    'clientState': '',
    'clientZip': '',
    'clientPhone': '',
    'businessName': '',
  };

  debugPrint('Test Case 1: Client with business name');
  printBillToSection(clientWithBusiness);

  debugPrint('\nTest Case 2: Client without business name');
  printBillToSection(clientWithoutBusiness);

  debugPrint('\nTest Case 3: Client with missing data');
  printBillToSection(clientWithMissingData);

  debugPrint('\n=== Expected PDF Output ===');
  debugPrint('The Bill To section should display:');
  debugPrint('1. Client name (or "Client Name Not Available" if empty)');
  debugPrint('2. Client email');
  debugPrint('3. Complete address (or "Address Not Available" if empty)');
  debugPrint('4. Client phone');
  debugPrint('5. Business name in parentheses (only if not empty)');
}

String buildClientName(Map<String, dynamic> clientData) {
  final firstName = getSafeString(clientData['clientFirstName']).trim();
  final lastName = getSafeString(clientData['clientLastName']).trim();

  if (firstName.isEmpty && lastName.isEmpty) {
    return 'Client Name Not Available';
  }

  return '${firstName} ${lastName}'.trim();
}

String buildClientAddress(Map<String, dynamic> clientData) {
  final address = getSafeString(clientData['clientAddress']).trim();
  final city = getSafeString(clientData['clientCity']).trim();
  final state = getSafeString(clientData['clientState']).trim();
  final zip = getSafeString(clientData['clientZip']).trim();

  List<String> addressParts = [];

  if (address.isNotEmpty) addressParts.add(address);
  if (city.isNotEmpty) addressParts.add(city);
  if (state.isNotEmpty) addressParts.add(state);
  if (zip.isNotEmpty) addressParts.add(zip);

  return addressParts.isEmpty
      ? 'Address Not Available'
      : addressParts.join(', ');
}

String getSafeString(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;
  return value.toString();
}

void printBillToSection(Map<String, dynamic> clientData) {
  debugPrint('Bill To:');
  debugPrint(buildClientName(clientData));
  debugPrint(getSafeString(clientData['clientEmail']));
  debugPrint(buildClientAddress(clientData));
  debugPrint(getSafeString(clientData['clientPhone']));

  final businessName = getSafeString(clientData['businessName']).trim();
  if (businessName.isNotEmpty) {
    debugPrint('(${businessName})');
  }
}
