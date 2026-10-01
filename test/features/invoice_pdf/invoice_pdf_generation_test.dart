import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockApiMethod extends Mock implements ApiMethod {}

// 1. Mock Path Provider
class MockPathProviderPlatform extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return Directory.systemTemp.path;
  }
}

// 2. Mock SharedPreferences (Implicitly used)
void setupSharedPreferences() {
  SharedPreferences.setMockInitialValues({});
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockApiMethod mockApi;

  setUpAll(() {
    PathProviderPlatform.instance = MockPathProviderPlatform();
    setupSharedPreferences();
    mockApi = MockApiMethod();
  });

  test('Generate physical PDF file for manual inspection', () async {
    final generator = InvoicePdfGenerator(api: mockApi);

    // 3. Construct Invoice Data
    // Matches the seeded scenario: 3 shifts x 8 hours
    // Sunday (Penalty), Monday (Standard), Tuesday (Standard)
    final invoiceData = {
      'clients': [
        {
          'clientFirstName': 'Client',
          'clientLastName': 'One',
          'clientAddress': '123 Test St',
          'clientCity': 'Sydney',
          'clientState': 'NSW',
          'clientZip': '2000',
          'invoiceNumber': 'INV-TEST-003', // Updated to ensure fresh file
          'startDate': '2023-10-01',
          'endDate': '2023-10-03',
          'total': 1776.96, // (736.96 + 520 + 520)
          'totalHours': 24.0,
          'taxAmount': 0.0,
          'tax': 0.0,
          'subtotal': 1776.96,
          'itemsSubtotal': 1776.96,
          'expensesTotal': 0.0,
          'adminProfile': {
            'businessName': 'Test Care Services',
            'abn': '12 345 678 901',
          },
          'billTo': {
            'name': 'Client One',
            'email': 'client1@test.com',
            'address': '123 Test St, Sydney NSW 2000',
          },
          'items': [
            {
              'date': '2023-10-01', // Sunday
              'startTime': '09:00',
              'endTime': '17:00',
              'hours': 8.0,
              'rate': 92.12, // Penalty Rate for Sunday
              'amount': 736.96,
              'ndisItem': {
                'itemNumber': '01_014_0107_1_1',
                'itemName':
                    'Assistance With Self-Care Activities - Standard - Sunday',
              },
            },
            {
              'date': '2023-10-02', // Monday
              'startTime': '09:00',
              'endTime': '17:00',
              'hours': 8.0,
              'rate': 65.00, // Standard Rate
              'amount': 520.00,
              'ndisItem': {
                'itemNumber': '01_011_0107_1_1',
                'itemName':
                    'Assistance With Self-Care Activities - Standard - Weekday Daytime',
              },
            },
            {
              'date': '2023-10-03', // Tuesday
              'startTime': '09:00',
              'endTime': '17:00',
              'hours': 8.0,
              'rate': 65.00, // Standard Rate
              'amount': 520.00,
              'ndisItem': {
                'itemNumber': '01_011_0107_1_1',
                'itemName':
                    'Assistance With Self-Care Activities - Standard - Weekday Daytime',
              },
            },
          ],
          'expenses': [],
          'bankName': 'Test Bank',
          'accountName': 'Test User',
          'bsb': '123-456',
          'accountNumber': '987654321',
          'useAdminBankDetails': false,
        },
      ],
    };

    // 4. Generate PDF
    final paths = await generator.generatePdfs(
      invoiceData,
      taxRate: 0.0,
      showTax: false,
    );

    // 5. Output Result
    expect(paths, isNotEmpty);
    final filePath = paths.first;
    final file = File(filePath);

    expect(await file.exists(), isTrue);
    expect(await file.length(), greaterThan(0));

    print('\n----------------------------------------------------------------');
    print('✅ PDF Generated Successfully!');
    print('📂 File Path: $filePath');
    print('----------------------------------------------------------------\n');
  });
}
