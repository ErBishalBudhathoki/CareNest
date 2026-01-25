import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/features/admin/utils/employee_invoice_payload.dart';
import 'package:carenest/app/features/admin/utils/employee_invoice_validation.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_date_range_picker.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer_io.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/config/environment.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EmployeeInvoiceGenerationView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String? organizationName;

  const EmployeeInvoiceGenerationView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    this.organizationName,
  });

  @override
  ConsumerState<EmployeeInvoiceGenerationView> createState() =>
      _EmployeeInvoiceGenerationViewState();
}

class _EmployeeInvoiceEmployeeState {
  final String email;
  final String id;
  final String name;
  final bool allClientsMode;
  final String selectedClientEmail;
  final List<Map<String, dynamic>> clients;
  final bool isLoadingClients;
  final bool isLoadingBankDetails;
  final Map<String, dynamic>? bankDetails;
  final String bankDetailsError;

  const _EmployeeInvoiceEmployeeState({
    required this.email,
    required this.id,
    required this.name,
    required this.allClientsMode,
    required this.selectedClientEmail,
    required this.clients,
    required this.isLoadingClients,
    required this.isLoadingBankDetails,
    required this.bankDetails,
    required this.bankDetailsError,
  });

  _EmployeeInvoiceEmployeeState copyWith({
    String? email,
    String? id,
    String? name,
    bool? allClientsMode,
    String? selectedClientEmail,
    List<Map<String, dynamic>>? clients,
    bool? isLoadingClients,
    bool? isLoadingBankDetails,
    Map<String, dynamic>? bankDetails,
    String? bankDetailsError,
  }) {
    return _EmployeeInvoiceEmployeeState(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
      allClientsMode: allClientsMode ?? this.allClientsMode,
      selectedClientEmail: selectedClientEmail ?? this.selectedClientEmail,
      clients: clients ?? this.clients,
      isLoadingClients: isLoadingClients ?? this.isLoadingClients,
      isLoadingBankDetails: isLoadingBankDetails ?? this.isLoadingBankDetails,
      bankDetails: bankDetails ?? this.bankDetails,
      bankDetailsError: bankDetailsError ?? this.bankDetailsError,
    );
  }

  bool get bankDetailsComplete {
    final data = bankDetails ?? const <String, dynamic>{};
    final bankName = data['bankName']?.toString() ?? '';
    final accountName = data['accountName']?.toString() ?? '';
    final bsb = data['bsb']?.toString() ?? '';
    final accountNumber = data['accountNumber']?.toString() ?? '';
    return bankDetailsError.isEmpty &&
        bankName.isNotEmpty &&
        accountName.isNotEmpty &&
        bsb.isNotEmpty &&
        accountNumber.isNotEmpty;
  }
}

class _GeneratedPdfResult {
  final String pdfPath;
  final List<String> receiptUrls;

  const _GeneratedPdfResult({
    required this.pdfPath,
    required this.receiptUrls,
  });
}

class _EmployeeInvoiceGenerationViewState
    extends ConsumerState<EmployeeInvoiceGenerationView> {
  final ApiMethod _api = ApiMethod();

  Map<String, _EmployeeInvoiceEmployeeState> _selectedEmployeesByEmail = {};

  bool _isLoadingEmployees = true;
  bool _isGenerating = false;

  String? _loadError;
  String? _generateError;

  List<Map<String, dynamic>> _employees = [];

  bool _includeExpenses = false;
  bool _includeTax = false;
  bool _applyMinEngagement = true; // Default to true (SCHADS standard)
  double _taxRate = 0.10;

  DateTimeRange? _dateRange;

  List<_GeneratedPdfResult> _generatedResults = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateRange = DateTimeRange(
      start: DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 30)),
      end: DateTime(now.year, now.month, now.day),
    );
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    setState(() {
      _isLoadingEmployees = true;
      _loadError = null;
      _employees = [];
    });

    try {
      final resp = await _api.getOrganizationEmployees(widget.organizationId);
      if (resp['success'] == true && resp['employees'] is List) {
        final list = (resp['employees'] as List)
            .whereType<Map<String, dynamic>>()
            .toList();
        setState(() {
          _employees = list;
          _isLoadingEmployees = false;
        });
        return;
      }
      setState(() {
        _isLoadingEmployees = false;
        _loadError = resp['message']?.toString() ?? 'Failed to load employees';
      });
    } catch (e) {
      setState(() {
        _isLoadingEmployees = false;
        _loadError = 'Error loading employees: $e';
      });
    }
  }

  void _updateSelectedEmployee(
    String email,
    _EmployeeInvoiceEmployeeState Function(_EmployeeInvoiceEmployeeState) update,
  ) {
    final current = _selectedEmployeesByEmail[email];
    if (current == null) return;
    setState(() {
      _selectedEmployeesByEmail = {
        ..._selectedEmployeesByEmail,
        email: update(current),
      };
    });
  }

  Future<void> _toggleEmployee(Map<String, dynamic> employee) async {
    final email = employee['email']?.toString() ?? '';
    final first = employee['firstName']?.toString() ?? '';
    final last = employee['lastName']?.toString() ?? '';
    final name = ('$first $last').trim().isNotEmpty
        ? ('$first $last').trim()
        : (employee['name']?.toString() ?? email);
    final id = employee['_id']?.toString() ?? '';

    if (email.isEmpty) return;

    if (_selectedEmployeesByEmail.containsKey(email)) {
      setState(() {
        final next = {..._selectedEmployeesByEmail};
        next.remove(email);
        _selectedEmployeesByEmail = next;
        _generateError = null;
        _generatedResults = [];
      });
      return;
    }

    setState(() {
      _selectedEmployeesByEmail = {
        ..._selectedEmployeesByEmail,
        email: _EmployeeInvoiceEmployeeState(
          email: email,
          id: id,
          name: name,
          allClientsMode: true,
          selectedClientEmail: '',
          clients: const [],
          isLoadingClients: true,
          isLoadingBankDetails: true,
          bankDetails: null,
          bankDetailsError: '',
        ),
      };
      _generateError = null;
      _generatedResults = [];
    });

    await Future.wait([
      _fetchClientsForEmployee(email),
      _fetchEmployeeBankDetails(email),
    ]);
  }

  Future<void> _fetchClientsForEmployee(String employeeEmail) async {
    if (!_selectedEmployeesByEmail.containsKey(employeeEmail)) return;
    _updateSelectedEmployee(employeeEmail,
        (e) => e.copyWith(isLoadingClients: true, clients: const []));

    try {
      final resp = await _api.getUserAssignments(employeeEmail);
      if (!_selectedEmployeesByEmail.containsKey(employeeEmail)) return;

      if (resp['success'] == true && resp['assignments'] is List) {
        final list = (resp['assignments'] as List)
            .whereType<Map<String, dynamic>>()
            .map((a) => {
                  'clientId': a['clientId']?.toString() ?? '',
                  'clientEmail': a['clientEmail']?.toString() ?? '',
                  'clientName': (a['clientName']?.toString() ??
                          a['clientEmail']?.toString() ??
                          '')
                      .trim(),
                })
            .where((c) => (c['clientEmail'] ?? '').toString().isNotEmpty)
            .toList();

        _updateSelectedEmployee(employeeEmail, (e) {
          final selectedEmail = e.selectedClientEmail;
          final validSelected = selectedEmail.isEmpty ||
              list.any((c) =>
                  (c['clientEmail']?.toString() ?? '') == selectedEmail);
          return e.copyWith(
            clients: list,
            isLoadingClients: false,
            selectedClientEmail: validSelected ? selectedEmail : '',
          );
        });
        return;
      }

      _updateSelectedEmployee(employeeEmail,
          (e) => e.copyWith(isLoadingClients: false, clients: const []));
    } catch (_) {
      if (!_selectedEmployeesByEmail.containsKey(employeeEmail)) return;
      _updateSelectedEmployee(employeeEmail,
          (e) => e.copyWith(isLoadingClients: false, clients: const []));
    }
  }

  Future<void> _fetchEmployeeBankDetails(String employeeEmail) async {
    if (!_selectedEmployeesByEmail.containsKey(employeeEmail)) return;
    _updateSelectedEmployee(employeeEmail, (e) => e.copyWith(
          isLoadingBankDetails: true,
          bankDetails: null,
          bankDetailsError: '',
        ));

    try {
      final resp = await _api.getBankDetailsForUserEmail(
          employeeEmail, widget.organizationId);
      if (!_selectedEmployeesByEmail.containsKey(employeeEmail)) return;

      if (resp['success'] == true && resp['data'] is Map<String, dynamic>) {
        final data = resp['data'] as Map<String, dynamic>;
        final bankName = data['bankName']?.toString() ?? '';
        final accountName = data['accountName']?.toString() ?? '';
        final bsb = data['bsb']?.toString() ?? '';
        final accountNumber = data['accountNumber']?.toString() ?? '';

        final error = (bankName.isEmpty ||
                accountName.isEmpty ||
                bsb.isEmpty ||
                accountNumber.isEmpty)
            ? 'Employee bank details are incomplete. Please update them before generating.'
            : '';

        _updateSelectedEmployee(employeeEmail, (e) => e.copyWith(
              bankDetails: data,
              bankDetailsError: error,
              isLoadingBankDetails: false,
            ));
        return;
      }

      _updateSelectedEmployee(employeeEmail, (e) => e.copyWith(
            isLoadingBankDetails: false,
            bankDetailsError: resp['message']?.toString() ??
                'Failed to load employee bank details',
          ));
    } catch (e) {
      if (!_selectedEmployeesByEmail.containsKey(employeeEmail)) return;
      _updateSelectedEmployee(employeeEmail, (s) => s.copyWith(
            isLoadingBankDetails: false,
            bankDetailsError: 'Error loading bank details: $e',
          ));
    }
  }

  EmployeeInvoiceValidationResult get _validationResult {
    final selections = _selectedEmployeesByEmail.values
        .map(
          (e) => EmployeeInvoiceEmployeeSelection(
            employeeEmail: e.email,
            employeeName: e.name.isNotEmpty ? e.name : e.email,
            allClientsMode: e.allClientsMode,
            selectedClientEmail: e.selectedClientEmail,
            hasClients: e.clients.isNotEmpty,
            bankDetailsComplete: e.bankDetailsComplete,
          ),
        )
        .toList();

    return validateMultiEmployeeInvoiceConfig(
      employees: selections,
      dateRange: _dateRange,
      includeTax: _includeTax,
      taxRate: _taxRate,
    );
  }

  bool get _canGenerate => _validationResult.isValid;

  Future<void> _pickDateRange() async {
    final initial = _dateRange ??
        DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 30)),
          end: DateTime.now(),
        );

    final picked = await showDialog<DateTimeRange>(
      context: context,
      builder: (context) => BauhausDateRangePicker(
        initialStartDate: initial.start,
        initialEndDate: initial.end,
        firstDate: DateTime(2020),
        lastDate: DateTime(DateTime.now().year + 1),
      ),
    );

    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  List<String> _extractReceiptUrlsFromInvoice(Map<String, dynamic> invoice) {
    final List<String> urls = [];
    final expenses = invoice['expenses'] as List<dynamic>? ?? [];
    for (final exp in expenses) {
      if (exp is! Map<String, dynamic>) continue;
      final direct = exp['receiptUrl']?.toString() ?? '';
      if (direct.isNotEmpty) {
        urls.add(AppConfig.buildFilesDownloadUrl(
            AppConfig.resolveResourceUrl(direct)));
      }
      final files = exp['receiptFiles'] as List<dynamic>? ?? [];
      for (final f in files) {
        final u = f?.toString() ?? '';
        if (u.isNotEmpty) {
          urls.add(AppConfig.buildFilesDownloadUrl(
              AppConfig.resolveResourceUrl(u)));
        }
      }
      final photos = exp['receiptPhotos'] as List<dynamic>? ?? [];
      for (final p in photos) {
        final u = p?.toString() ?? '';
        if (u.isNotEmpty) {
          urls.add(AppConfig.buildFilesDownloadUrl(
              AppConfig.resolveResourceUrl(u)));
        }
      }
    }
    final seen = <String>{};
    return urls.where((u) => seen.add(u)).toList();
  }

  Future<void> _generate() async {
    final validation = _validationResult;
    if (!validation.isValid) {
      _showSnackBar(validation.message, isError: true);
      return;
    }

    final inputs = _selectedEmployeesByEmail.values
        .map(
          (e) => EmployeeInvoiceEmployeePayloadInput(
            employeeEmail: e.email,
            employeeName: e.name.isNotEmpty ? e.name : e.email,
            employeeId: e.id,
            allClientsMode: e.allClientsMode,
            selectedClientEmail: e.selectedClientEmail,
            clients: e.clients,
          ),
        )
        .toList();

    final selectionPayload = buildEmployeeInvoiceSelectionsPayload(
      organizationId: widget.organizationId,
      employees: inputs,
    );

    setState(() {
      _isGenerating = true;
      _generateError = null;
      _generatedResults = [];
    });

    try {
      final service = ref.read(enhancedInvoiceServiceProvider);
      final start = _dateRange!.start;
      final end = _dateRange!.end;

      final paths = await service.generateInvoicesWithPricing(
        context,
        selectedEmployeesAndClients: selectionPayload,
        organizationId: widget.organizationId,
        validatePrices: false,
        includeDetailedPricingInfo: false,
        applyTax: _includeTax,
        taxRate: _includeTax ? _taxRate : 0.0,
        includeExpenses: _includeExpenses,
        useAdminBankDetails: false,
        startDate: start,
        endDate: end,
        invoiceType: 'employee',
        applyMinEngagement: _applyMinEngagement,
      );

      final invoices = service.invoices;
        final results = <_GeneratedPdfResult>[];
      for (int i = 0; i < paths.length; i++) {
        final dynamic rawInvoice = i < invoices.length ? invoices[i] : null;
        final invoice = rawInvoice is Map
            ? Map<String, dynamic>.from(rawInvoice)
            : <String, dynamic>{};
        final List<String> receipts = _includeExpenses
            ? _extractReceiptUrlsFromInvoice(invoice)
            : const <String>[];
        results.add(_GeneratedPdfResult(pdfPath: paths[i], receiptUrls: receipts));
      }

      setState(() {
        _generatedResults = results;
        _isGenerating = false;
      });

      if (paths.isEmpty) {
        _showSnackBar('Invoice generation returned no PDFs.', isError: true);
        return;
      }

      _showSnackBar('Generated ${paths.length} invoice PDF(s).');
    } catch (e) {
      setState(() {
        _isGenerating = false;
        _generateError = e.toString();
      });
      _showSnackBar('Failed to generate invoices: $e', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.surfaceLight,
                fontWeight: FontWeight.w600,
              ),
        ),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        margin: const EdgeInsets.all(BauhausDesign.space4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.backgroundLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral, width: 1.5),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: BauhausDesign.textDark,
              size: 16,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Employee Invoice',
              style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(
              widget.organizationName ?? '',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(height: 4, color: BauhausDesign.neutral),
        ),
      ),
      body: _isLoadingEmployees
          ? _buildCenteredLoader('Loading employees...')
          : (_loadError != null && _employees.isEmpty)
              ? _buildErrorState(_loadError!)
              : _buildContent(),
    );
  }

  Widget _buildCenteredLoader(String label) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              ),
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: BauhausDesign.surfaceLight,
                  strokeWidth: 3,
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              label,
              style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.error,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: BauhausDesign.surfaceLight,
                  size: 28,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                message,
                textAlign: TextAlign.center,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              ElevatedButton(
                onPressed: _fetchEmployees,
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.primary,
                  foregroundColor: BauhausDesign.textDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    side: const BorderSide(color: BauhausDesign.neutral, width: 2),
                  ),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final isWide = MediaQuery.of(context).size.width >= 900;
    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildSelectionPanel(),
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildConfigurationPanel(),
                  ),
                ),
              ],
            )
          : ListView(
              children: [
                _buildSelectionPanel(),
                const SizedBox(height: BauhausDesign.space4),
                _buildConfigurationPanel(),
              ],
            ),
    );
  }

  // Neo-Brutalist Color Palette
  static const Color _neoBlue = Color(0xFF1A237E);
  static const Color _neoRed = Color(0xFFD50000);
  static const Color _neoGreen = Color(0xFF00C853);
  static const Color _neoBlack = Color(0xFF000000);
  static const Color _neoWhite = Color(0xFFFFFFFF);
  static const double _neoBorderWidth = 2.5;

  Widget _buildSelectionPanel() {
    // Determine height based on content or fixed height if needed. 
    // The design looks like a full-height card.
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: _neoBlue,
        borderRadius: BorderRadius.circular(0), // Sharp corners
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
        boxShadow: const [
          BoxShadow(
            color: _neoBlack,
            offset: Offset(8, 8),
            blurRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1) Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: _neoBlack,
              boxShadow: [
                 BoxShadow(
                  color: _neoWhite,
                  offset: Offset(4, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Text(
              '1) SELECT EMPLOYEES & CLIENTS',
              style: GoogleFonts.oswald(
                color: _neoWhite,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // 2) Employees Section
          _buildSectionHeader('EMPLOYEES'),
          const SizedBox(height: 16),
          _buildEmployeesList(),
          
          const SizedBox(height: 32),

          // 3) Selected Employees Section
          _buildSectionHeader('SELECTED EMPLOYEES'),
          const SizedBox(height: 16),
          _buildSelectedEmployeesConfig(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 24,
          color: _neoRed,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.oswald(
            color: _neoWhite,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeesList() {
    return Container(
      // Fixed height or flexible? Design implies a list. 
      // Keeping height constraint but updating style.
      height: 260, 
      decoration: BoxDecoration(
        color: _neoWhite,
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
      ),
      child: ListView.separated(
        itemCount: _employees.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, thickness: 1.5, color: _neoBlack),
        itemBuilder: (context, index) {
          final e = _employees[index];
          final email = e['email']?.toString() ?? '';
          final first = e['firstName']?.toString() ?? '';
          final last = e['lastName']?.toString() ?? '';
          final name = ('$first $last').trim().isNotEmpty
              ? ('$first $last').trim()
              : email;
          final isSelected = email.isNotEmpty &&
              _selectedEmployeesByEmail.containsKey(email);

          return InkWell(
            onTap: () => _toggleEmployee(e),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (name.isNotEmpty ? name : 'UNKNOWN').toUpperCase(),
                          style: GoogleFonts.oswald(
                            color: _neoBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: GoogleFonts.robotoMono(
                            color: _neoBlack.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  _buildNeoCheckbox(isSelected),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNeoCheckbox(bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: _neoWhite,
        border: Border.all(color: _neoBlack, width: 2),
      ),
      padding: const EdgeInsets.all(2), // Gap between border and fill
      child: isSelected
          ? Container(
              color: _neoRed,
              child: const Icon(
                Icons.check,
                size: 14,
                color: _neoWhite,
              ),
            )
          : null,
    );
  }

  Widget _buildSelectedEmployeesConfig() {
    final selected = _selectedEmployeesByEmail.values.toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    if (selected.isEmpty) {
      return _hintBox('Select one or more employees to configure clients.');
    }

    return Column(
      children: selected.map(_buildEmployeeConfigCard).toList(),
    );
  }

  Widget _buildEmployeeConfigCard(_EmployeeInvoiceEmployeeState employee) {
    final hasClientSelectionError =
        !employee.allClientsMode && employee.selectedClientEmail.isEmpty;
    final hasBankError = employee.bankDetailsError.isNotEmpty;
    final isValid = !hasClientSelectionError && !hasBankError;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _neoWhite,
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
        boxShadow: const [
          BoxShadow(
            color: _neoBlack,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  collapsedIconColor: _neoBlack,
                  iconColor: _neoBlack,
                  title: Text(
                    (employee.name.isNotEmpty ? employee.name : employee.email).toUpperCase(),
                    style: GoogleFonts.oswald(
                      color: _neoBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    employee.email,
                    style: GoogleFonts.robotoMono(
                      color: _neoBlack.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (employee.isLoadingClients || employee.isLoadingBankDetails)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: _neoBlack,
                          ),
                        )
                      else if (!isValid)
                        const Icon(Icons.error_outline_rounded,
                            color: _neoRed, size: 24)
                      else
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: _neoGreen,
                            shape: BoxShape.circle,
                            border: Border.all(color: _neoBlack, width: 1.5),
                          ),
                          child: const Icon(Icons.check,
                              color: _neoWhite, size: 16),
                        ),
                      const SizedBox(width: 12),
                      const Icon(Icons.expand_more, color: _neoBlack),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(color: _neoBlack, thickness: 1),
                          const SizedBox(height: 16),
                          _buildEmployeeClientModeToggle(employee),
                          const SizedBox(height: 16),
                          _buildEmployeeClientsList(employee),
                          if (hasClientSelectionError) ...[
                            const SizedBox(height: 16),
                            _buildNeoErrorBox(
                                'Select a client for ${employee.name} (specific-client mode).'),
                          ],
                          if (hasBankError) ...[
                            const SizedBox(height: 16),
                            _buildNeoErrorBox(employee.bankDetailsError),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 6,
            child: Container(
              color: _neoRed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeClientModeToggle(_EmployeeInvoiceEmployeeState employee) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _neoWhite,
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
      ),
      child: Column(
        children: [
          _buildNeoRadioTile(
            title: 'ALL CLIENTS',
            subtitle: 'Include all clients for this employee',
            value: true,
            groupValue: employee.allClientsMode,
            onChanged: (v) => _updateSelectedEmployee(
              employee.email,
              (e) => e.copyWith(allClientsMode: true, selectedClientEmail: ''),
            ),
          ),
          const SizedBox(height: 8),
          _buildNeoRadioTile(
            title: 'SPECIFIC CLIENT',
            subtitle: 'Select one client to invoice',
            value: false,
            groupValue: employee.allClientsMode,
            onChanged: (v) => _updateSelectedEmployee(
              employee.email,
              (e) => e.copyWith(allClientsMode: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeoRadioTile({
    required String title,
    required String subtitle,
    required bool value,
    required bool groupValue,
    required ValueChanged<bool?> onChanged,
  }) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _neoBlack, width: 2),
              color: isSelected ? _neoBlack : _neoWhite,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: _neoWhite,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.oswald(
                    color: _neoBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.robotoMono(
                    color: _neoBlack.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeClientsList(_EmployeeInvoiceEmployeeState employee) {
    if (employee.isLoadingClients) return _buildNeoHintBox('LOADING CLIENTS...');
    if (employee.clients.isEmpty) {
      return _buildNeoHintBox('NO CLIENTS FOUND.');
    }

    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: _neoWhite,
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
      ),
      child: ListView.separated(
        itemCount: employee.clients.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, thickness: 1.5, color: _neoBlack),
        itemBuilder: (context, index) {
          final c = employee.clients[index];
          final email = c['clientEmail']?.toString() ?? '';
          final name = c['clientName']?.toString() ?? email;
          final isSelected =
              !employee.allClientsMode && email == employee.selectedClientEmail;
          final isDisabled = employee.allClientsMode;

          return InkWell(
            onTap: isDisabled
                ? null
                : () => _updateSelectedEmployee(
                      employee.email,
                      (e) => e.copyWith(selectedClientEmail: email),
                    ),
            child: Container(
              color: isSelected ? _neoBlack.withOpacity(0.05) : null,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (name.isNotEmpty ? name : 'UNKNOWN').toUpperCase(),
                          style: GoogleFonts.oswald(
                            color: isDisabled ? _neoBlack.withOpacity(0.4) : _neoBlack,
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                        Text(
                          email,
                          style: GoogleFonts.robotoMono(
                            color: isDisabled ? _neoBlack.withOpacity(0.3) : _neoBlack.withOpacity(0.6),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _neoGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: _neoBlack, width: 1.5),
                      ),
                      child: const Icon(Icons.check, color: _neoWhite, size: 12),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNeoHintBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _neoWhite,
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
      ),
      child: Text(
        text,
        style: GoogleFonts.robotoMono(
          color: _neoBlack.withOpacity(0.7),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildNeoErrorBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _neoRed,
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: _neoWhite, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text.toUpperCase(),
              style: GoogleFonts.oswald(
                color: _neoWhite,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const Color _neoYellow = Color(0xFFFFC107);
  static const Color _neoBeige = Color(0xFFF0F0E8);

  Widget _buildConfigurationPanel() {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: _neoWhite,
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
        boxShadow: const [
          BoxShadow(
            color: _neoBlack,
            offset: Offset(8, 8),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: _neoYellow,
            child: Text(
              '2) CONFIGURE & GENERATE',
              style: GoogleFonts.oswald(
                color: _neoBlack,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(height: _neoBorderWidth, color: _neoBlack),
          
          // Selection Summary
          _buildNeoSelectionSummary(),
          
          // Invoice Options Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: _neoBlack,
            child: Text(
              'INVOICE OPTIONS',
              style: GoogleFonts.oswald(
                color: _neoWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ),
          
          // Options List
          _buildNeoOptionsList(),
          
          // Date Range (Red Box)
          _buildNeoDateRange(),
          
          // Bank Details
          _buildNeoBankDetails(),
          
          Container(height: _neoBorderWidth, color: _neoBlack),

          // Generate Section
          Container(
            color: _neoBeige,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNeoGenerateSection(),
                if ((_generateError ?? '').isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildNeoErrorBox(_generateError!),
                ],
                if (_generatedResults.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildGeneratedPdfsSection(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeoSelectionSummary() {
    final selected = _selectedEmployeesByEmail.values.toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    
    return Container(
      color: _neoWhite,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SELECTION SUMMARY',
                style: GoogleFonts.oswald(
                  color: _neoBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: _neoBlack,
                child: Text(
                  '${selected.length} Selected',
                  style: GoogleFonts.robotoMono(
                    color: _neoWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (selected.isEmpty)
            Text(
              'No employees selected',
              style: GoogleFonts.robotoMono(color: _neoBlack.withOpacity(0.6)),
            )
          else
            ...selected.asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;
              final clientLabel = e.allClientsMode
                  ? 'All clients'
                  : (e.selectedClientEmail.isNotEmpty
                      ? e.selectedClientEmail
                      : 'No client selected');
              
              final bulletColor = index % 2 == 0 ? _neoBlue : _neoRed;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, color: bulletColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.robotoMono(
                            color: _neoBlack,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: e.name,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: ': $clientLabel',
                              style: TextStyle(color: _neoBlack.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildNeoOptionsList() {
    return Column(
      children: [
        _buildNeoSwitchTile(
          title: 'Apply Minimum Engagement (2h)',
          subtitle: 'Automatically adjust short shifts (< 2h) to 2 hours',
          value: _applyMinEngagement,
          onChanged: _selectedEmployeesByEmail.isEmpty
              ? null
              : (v) => setState(() => _applyMinEngagement = v),
        ),
        Container(height: 1, color: _neoBlack),
        _buildNeoSwitchTile(
          title: 'Include Approved Expenses',
          value: _includeExpenses,
          onChanged: _selectedEmployeesByEmail.isEmpty
              ? null
              : (v) => setState(() => _includeExpenses = v),
        ),
        Container(height: 1, color: _neoBlack),
        _buildNeoSwitchTile(
          title: 'Include Tax',
          value: _includeTax,
          onChanged: _selectedEmployeesByEmail.isEmpty
              ? null
              : (v) => setState(() => _includeTax = v),
        ),
        if (_includeTax) ...[
           Container(height: 1, color: _neoBlack),
           Container(
             color: _neoBeige,
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
             child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Tax Rate',
                    style: GoogleFonts.oswald(
                      color: _neoBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    initialValue: (_taxRate * 100).toStringAsFixed(1),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: GoogleFonts.robotoMono(fontSize: 14, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      suffixText: '%',
                      filled: true,
                      fillColor: _neoWhite,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: const BorderSide(color: _neoBlack, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: const BorderSide(color: _neoBlack, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: const BorderSide(color: _neoBlue, width: 2),
                      ),
                    ),
                    onChanged: (v) {
                      final parsed = double.tryParse(v);
                      if (parsed == null) return;
                      setState(() => _taxRate = parsed / 100.0);
                    },
                  ),
                ),
              ],
            ),
           ),
        ],
      ],
    );
  }

  Widget _buildNeoSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return Container(
      color: _neoBeige,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.oswald(
                    color: _neoBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.robotoMono(
                      color: _neoBlack.withOpacity(0.6),
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: onChanged != null ? () => onChanged(!value) : null,
            child: Container(
              width: 48,
              height: 24,
              decoration: BoxDecoration(
                color: _neoWhite,
                border: Border.all(color: _neoBlack, width: 1.5),
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: value ? _neoBlue : Colors.grey[300],
                        border: Border.all(color: _neoBlack, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeoDateRange() {
    final df = DateFormat('dd/MM/yyyy');
    final range = _dateRange;
    final startText = range != null ? df.format(range.start) : '--/--/----';
    final endText = range != null ? df.format(range.end) : '--/--/----';

    return InkWell(
      onTap: _selectedEmployeesByEmail.isEmpty ? null : _pickDateRange,
      child: Container(
        width: double.infinity,
        color: _neoRed,
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DATE RANGE',
                  style: GoogleFonts.oswald(
                    color: _neoWhite.withOpacity(0.8),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  startText,
                  style: GoogleFonts.oswald(
                    color: _neoWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'to $endText',
                  style: GoogleFonts.oswald(
                    color: _neoWhite.withOpacity(0.9),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: _neoWhite, width: 2),
                ),
                child: const Icon(
                  Icons.calendar_today_outlined,
                  color: _neoWhite,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeoBankDetails() {
    return Container(
      color: _neoWhite,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          iconColor: _neoBlack,
          collapsedIconColor: _neoBlack,
          title: Text(
            'Employee Bank Details',
            style: GoogleFonts.oswald(
              color: _neoBlack,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            'ADMIN BANK DETAILS WILL NOT BE USED.',
            style: GoogleFonts.robotoMono(
              color: _neoBlack.withOpacity(0.5),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          children: [
            Container(height: 1, color: _neoBlack),
            // Re-use existing bank details list logic but simplified/styled if needed
            // For now, using the logic from original code but wrapping in padding
             _buildBankDetailsList(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBankDetailsList() {
      final selected = _selectedEmployeesByEmail.values.toList();
      return Column(
        children: selected.asMap().entries.map((entry) {
          final index = entry.key;
          final e = entry.value;
          final bank = e.bankDetails;
          final isLast = index == selected.length - 1;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: isLast 
                ? null 
                : const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: _neoBlack, width: 1.5),
                    ),
                  ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    e.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _neoBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (bank == null)
                     Text(
                       'No bank details found',
                       textAlign: TextAlign.center,
                       style: GoogleFonts.robotoMono(color: _neoRed, fontWeight: FontWeight.w500),
                     )
                  else ...[
                     Text(
                       'Bank: ${bank['bankName']}',
                       textAlign: TextAlign.center,
                       style: GoogleFonts.robotoMono(
                         fontSize: 12,
                         color: _neoBlack,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     const SizedBox(height: 4),
                     Text(
                       'BSB: ${bank['bsb']}',
                       textAlign: TextAlign.center,
                       style: GoogleFonts.robotoMono(
                         fontSize: 12,
                         color: _neoBlack,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     const SizedBox(height: 4),
                     Text(
                       'ACC: ${bank['accountNumber']}',
                       textAlign: TextAlign.center,
                       style: GoogleFonts.robotoMono(
                         fontSize: 12,
                         color: _neoBlack,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                  ],
                  if (!isLast) ...[
                    const SizedBox(height: 24),
                    Container(
                      width: 100, // Short divider line
                      height: 1.5,
                      color: _neoBlack,
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      );
  }

  Widget _buildNeoGenerateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GENERATE',
          style: GoogleFonts.oswald(
            color: _neoBlack,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: _selectedEmployeesByEmail.isEmpty ? null : _generate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: _neoRed,
              border: Border.all(color: _neoBlack, width: _neoBorderWidth),
              boxShadow: const [
                BoxShadow(
                  color: _neoBlack,
                  offset: Offset(4, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GENERATE PDF',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(
                    color: _neoWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    height: 1.2,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.arrow_forward, color: _neoWhite),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneratedPdfsSection() {
    return Container(
      decoration: BoxDecoration(
        color: _neoWhite,
        border: Border.all(color: _neoBlack, width: _neoBorderWidth),
        boxShadow: const [
          BoxShadow(
            color: _neoBlack,
            offset: Offset(8, 8),
            blurRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Red underline header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GENERATED PDFS',
                style: GoogleFonts.oswald(
                  color: _neoBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 4,
                color: _neoRed,
              ),
            ],
          ),
          const SizedBox(height: 32),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _generatedResults.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: _neoBlack, thickness: 1.5),
            itemBuilder: (context, index) {
              final item = _generatedResults[index];
              final path = item.pdfPath;
              final name = path.split('/').last;
              
              String sizeStr = '0.0 KB';
              try {
                final file = File(path);
                if (file.existsSync()) {
                  final bytes = file.lengthSync();
                  if (bytes >= 1024 * 1024) {
                     sizeStr = '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
                  } else {
                     sizeStr = '${(bytes / 1024).toStringAsFixed(1)} KB';
                  }
                }
              } catch (_) {}
              
              final size = sizeStr; 

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.robotoMono(
                              color: _neoBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            size,
                            style: GoogleFonts.robotoMono(
                              color: _neoBlack.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewPage(
                              pdfPath: path,
                              receiptUrls: item.receiptUrls,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: _neoRed,
                          border: Border.all(color: _neoBlack, width: 1.5),
                          boxShadow: const [
                            BoxShadow(
                              color: _neoBlack,
                              offset: Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          'PDF',
                          style: GoogleFonts.oswald(
                            color: _neoWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bauhausPanel({
    required String title,
    required Color color,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2.5),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space2,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral, width: 2),
            ),
            child: Text(
              title.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          child,
        ],
      ),
    );
  }

  Widget _hintBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Text(
        text,
        style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              color: BauhausDesign.neutral,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget _errorInlineBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: BauhausDesign.space2),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.error,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Text(
        text,
        style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              color: BauhausDesign.surfaceLight,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}
