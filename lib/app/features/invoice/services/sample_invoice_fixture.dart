/// Purely synthetic invoice data for marketing/screenshot use.
///
/// **Nothing in here is real.** Every name, address, ABN, bank account and email
/// is invented. The NDIS support item numbers and their unit prices ARE real —
/// taken from `assets/ndis_support_items.json` — because a sample invoice with
/// invented pricing would misrepresent what the product actually bills at.
///
/// Use this instead of real org data in screenshots, demos or sales decks.
///
/// To produce the PDF:
/// ```
/// flutter test test/sample_invoice_marketing_pdf_test.dart
/// ```
/// which writes `marketing/INVOICE-SAMPLE.pdf`.
library;

class SampleInvoiceFixture {
  SampleInvoiceFixture._();

  // ---------------------------------------------------------------------------
  // Issuer — the support provider whose invoice this is
  // ---------------------------------------------------------------------------
  static const String _providerBusinessName = 'Sunrise Community Care Pty Ltd';
  static const String _providerTradingName = 'Sunrise Community Care';

  /// Fictitious. Checksum-valid so it formats credibly, deliberately NOT a
  /// registered entity. Replace before any real-world use.
  static const String _providerAbn = '20 000 631 234';

  static const String _providerAddress = '42 Harbour View Parade';
  static const String _providerCity = 'Newcastle';
  static const String _providerState = 'NSW';
  static const String _providerPostcode = '2300';
  static const String _providerPhone = '(02) 4900 0000';
  static const String _providerEmail = 'accounts@sunrisecare.example';

  // ---------------------------------------------------------------------------
  // Recipient — a plan manager paying on the participant's behalf
  // ---------------------------------------------------------------------------
  static const String _billToBusinessName = 'Riverbend Plan Management Pty Ltd';
  static const String _billToName = 'Casey Rowan';
  static const String _billToAbn = '31 555 001 992';
  static const String _billToAddress = 'Level 3, 88 Cooper Street';
  static const String _billToCity = 'Newcastle';
  static const String _billToState = 'NSW';
  static const String _billToPostcode = '2300';
  static const String _billToEmail = 'invoices@riverbendpm.example';
  static const String _billToPhone = '(02) 4900 0100';

  // ---------------------------------------------------------------------------
  // Participant and support worker
  // ---------------------------------------------------------------------------
  static const String _clientName = 'Jordan Whitfield';
  static const String _clientNdisNumber = '4300 1234 5';
  static const String _workerName = 'Alex Nguyen';
  static const String _workerEmail = 'alex.nguyen@sunrisecare.example';

  static const String _invoiceNumber = 'INV-2026-0913-SAMPLE';
  static const String _jobTitle = 'Personal Care Assistance';

  static const String _startDate = '2026-09-07';
  static const String _endDate = '2026-09-13';

  /// Real NDIS support item numbers and real published National-zone unit
  /// prices, from `assets/ndis_support_items.json`.
  static const List<Map<String, dynamic>> _items = [
    {
      'date': '2026-09-07',
      'startTime': '08:00',
      'endTime': '11:00',
      'hours': 3.0,
      'ndisItemNumber': '01_011_0107_1_1',
      'ndisItemName':
          'Assistance With Self-Care Activities - Standard - Weekday Daytime',
      'description':
          'Assistance With Self-Care Activities - Standard - Weekday Daytime',
    },
    {
      'date': '2026-09-08',
      'startTime': '13:00',
      'endTime': '17:30',
      'hours': 4.5,
      'ndisItemNumber': '01_011_0107_1_1',
      'ndisItemName':
          'Assistance With Self-Care Activities - Standard - Weekday Daytime',
      'description':
          'Assistance With Self-Care Activities - Standard - Weekday Daytime',
    },
    {
      'date': '2026-09-09',
      'startTime': '21:00',
      'endTime': '02:00',
      'hours': 5.0,
      'ndisItemNumber': '01_002_0107_1_1',
      'ndisItemName':
          'Assistance With Self-Care Activities - Standard - Weekday Night',
      'description':
          'Assistance With Self-Care Activities - Standard - Weekday Night',
    },
    {
      'date': '2026-09-10',
      'startTime': '17:00',
      'endTime': '19:00',
      'hours': 2.0,
      'ndisItemNumber': '01_015_0107_1_1',
      'ndisItemName':
          'Assistance With Self-Care Activities - Standard - Weekday Evening',
      'description':
          'Assistance With Self-Care Activities - Standard - Weekday Evening',
    },
    {
      'date': '2026-09-12',
      'startTime': '09:00',
      'endTime': '13:00',
      'hours': 4.0,
      'ndisItemNumber': '01_013_0107_1_1',
      'ndisItemName':
          'Assistance With Self-Care Activities - Standard - Saturday',
      'description':
          'Assistance With Self-Care Activities - Standard - Saturday',
    },
  ];

  /// Published National-zone unit prices for the item numbers above.
  static const Map<String, double> kUnitPrices = {
    '01_011_0107_1_1': 73.58,
    '01_002_0107_1_1': 82.57,
    '01_015_0107_1_1': 81.07,
    '01_013_0107_1_1': 103.54,
  };

  /// Bank details for deposit on the sample document.
  static const Map<String, dynamic> _bankDetails = {
    'bankName': 'Sunrise Community Credit Union',
    'accountName': 'Sunrise Community Care Pty Ltd',
    'bsb': '000-000',
    'accountNumber': '000 000 000',
  };

  static const Map<String, dynamic> _taxIdentifiers = {
    'abn': _providerAbn,
    'gstRegistered': false,
  };

  /// Fills in the monetary fields the PDF generator derives from line items,
  /// so arithmetic can never drift from the item list above.
  static double get itemsSubtotal {
    var total = 0.0;
    for (final item in _items) {
      final rate = kUnitPrices[item['ndisItemNumber']] ?? 0.0;
      total += (item['hours'] as double) * rate;
    }
    return double.parse(total.toStringAsFixed(2));
  }

  static double get totalHours {
    var h = 0.0;
    for (final item in _items) {
      h += item['hours'] as double;
    }
    return double.parse(h.toStringAsFixed(2));
  }

  /// Builds the payload `InvoicePdfGenerator.generatePdfs` expects.
  static Map<String, dynamic> buildInvoicePayload() {
    final items = _items.map((item) {
      final code = item['ndisItemNumber'] as String;
      final rate = kUnitPrices[code] ?? 0.0;
      final hours = item['hours'] as double;
      final amount = double.parse((hours * rate).toStringAsFixed(2));
      final name = item['ndisItemName'] as String;
      return {
        'date': item['date'],
        'startTime': item['startTime'],
        'endTime': item['endTime'],
        'timeStart': item['startTime'],
        'timeEnd': item['endTime'],
        'hours': hours,
        'quantity': hours,
        'rate': rate,
        'unitPrice': rate,
        'price': rate,
        'amount': amount,
        'total': amount,
        'totalPrice': amount,
        'itemCode': code,
        'ndisItemNumber': code,
        'supportItemNumber': code,
        'ndisItemName': name,
        'supportItemName': name,
        'itemName': name,
        'description': name,
        'excludeFromTotalHours': false,
        'isMileage': false,
        'distance': 0.0,
      };
    }).toList();

    final subtotal = itemsSubtotal;

    // NDIS supports are generally GST-free, so the tax line reads 0 rather
    // than pretending a rate that does not apply.
    const taxRate = 0.0;

    return {
      'clients': [
        {
          // --- issuer -------------------------------------------------------
          'adminProfile': {
            'businessName': _providerBusinessName,
            'tradingName': _providerTradingName,
            'abn': _providerAbn,
            'taxIdentifiers': _taxIdentifiers,
            'address': _providerAddress,
            'city': _providerCity,
            'state': _providerState,
            'postcode': _providerPostcode,
            'phone': _providerPhone,
            'email': _providerEmail,
          },

          // --- recipient ----------------------------------------------------
          'billTo': {
            'businessName': _billToBusinessName,
            'name': _billToName,
            'abn': _billToAbn,
            'address': _billToAddress,
            'city': _billToCity,
            'state': _billToState,
            'postcode': _billToPostcode,
            'email': _billToEmail,
            'phone': _billToPhone,
          },

          // --- participant --------------------------------------------------
          'clientName': _clientName,
          'clientFirstName': 'Jordan',
          'clientLastName': 'Whitfield',
          'clientEmail': 'jordan.whitfield@example.invalid',
          'clientAddress': '14 Beelarung Street',
          'clientCity': 'Newcastle',
          'clientState': 'NSW',
          'clientZip': '2300',
          'clientPhone': '',
          'ndisNumber': _clientNdisNumber,
          'businessName': _providerBusinessName,
          'abn': _providerAbn,
          'clientABN': _billToAbn,

          // --- support worker ----------------------------------------------
          'employeeName': _workerName,
          'workerEmail': _workerEmail,
          'providerEmail': _providerEmail,
          'providerABN': _providerAbn,
          'jobTitle': _jobTitle,
          'employeeDetails': {
            'name': _workerName,
            'email': _workerEmail,
            'abn': _providerAbn,
            'businessName': _providerBusinessName,
          },
          'clientDetails': {
            'name': _billToName,
            'businessName': _billToBusinessName,
            'email': _billToEmail,
          },

          // --- period and identity -----------------------------------------
          'invoiceType': 'client',
          'invoiceNumber': _invoiceNumber,
          'startDate': _startDate,
          'endDate': _endDate,
          'issueDate': _endDate,

          // --- money --------------------------------------------------------
          'subtotal': subtotal,
          'itemsSubtotal': subtotal,
          'expensesTotal': 0.0,
          'tax': 0.0,
          'taxAmount': 0.0,
          'total': subtotal,
          'totalHours': totalHours.toStringAsFixed(2),
          'showTax': true,
          'applyTax': true,
          'includesTax': true,
          'taxRate': taxRate,

          // --- deposit details ----------------------------------------------
          'bankDetails': _bankDetails,
          'useAdminBankDetails': false,

          // Empty on purpose: both bank-detail lookups short-circuit on an
          // empty organizationId/email, which keeps generation offline.
          'organizationId': '',

          // A real invoice would carry a per-org payment link; none here,
          // so no real endpoint is exposed in the marketing artefact.
          'paymentLinkUrl': '',
          'payment_link_url': '',

          'items': items,
          'expenses': const [],
        },
      ],
      'metadata': {
        'invoiceType': 'client',
        'providerName': _workerName,
        'providerABN': _providerAbn,
      },
    };
  }
}
