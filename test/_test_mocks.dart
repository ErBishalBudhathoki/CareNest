// ignore_for_file: unused_import
/// This file exists only to trigger mockito codegen for EnhancedInvoiceService.
/// The generated mock is imported by integration tests.
library;

import 'package:mockito/annotations.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';

@GenerateNiceMocks([MockSpec<EnhancedInvoiceService>()])
void _mocks() {}
