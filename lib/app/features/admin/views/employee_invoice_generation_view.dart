import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/features/admin/utils/employee_invoice_payload.dart';
import 'package:carenest/app/features/admin/utils/employee_invoice_validation.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer_io.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/config/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: BauhausDesign.primary,
              onPrimary: BauhausDesign.textDark,
              surface: BauhausDesign.surfaceLight,
              onSurface: BauhausDesign.textDark,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
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
              children: [
                Expanded(child: _buildSelectionPanel()),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(child: _buildConfigurationPanel()),
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

  Widget _buildSelectionPanel() {
    return _bauhausPanel(
      title: '1) Select Employees & Clients',
      color: BauhausDesign.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Employees',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildEmployeesList(),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'Selected Employees',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildSelectedEmployeesConfig(),
        ],
      ),
    );
  }

  Widget _buildEmployeesList() {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: ListView.separated(
        itemCount: _employees.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: BauhausDesign.neutral),
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

          return ListTile(
            dense: true,
            title: Text(
              name.isNotEmpty ? name : 'Unknown',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  ),
            ),
            subtitle: Text(
              email,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Checkbox(
              value: isSelected,
              activeColor: BauhausDesign.primary,
              checkColor: BauhausDesign.textDark,
              onChanged: (_) => _toggleEmployee(e),
            ),
            onTap: () => _toggleEmployee(e),
          );
        },
      ),
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

    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space2,
        ),
        collapsedIconColor: BauhausDesign.textDark,
        iconColor: BauhausDesign.textDark,
        title: Text(
          employee.name.isNotEmpty ? employee.name : employee.email,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w900,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          employee.email,
          style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: BauhausDesign.neutral,
                fontWeight: FontWeight.w600,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (employee.isLoadingClients || employee.isLoadingBankDetails)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (hasClientSelectionError || hasBankError)
              const Icon(Icons.error_outline_rounded,
                  color: BauhausDesign.error, size: 18)
            else
              const Icon(Icons.check_circle_rounded,
                  color: BauhausDesign.success, size: 18),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                BauhausDesign.space4,
                0,
                BauhausDesign.space4,
                BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEmployeeClientModeToggle(employee),
                const SizedBox(height: BauhausDesign.space3),
                _buildEmployeeClientsList(employee),
                if (hasClientSelectionError) ...[
                  const SizedBox(height: BauhausDesign.space3),
                  _errorInlineBox(
                      'Select a client for ${employee.name} (specific-client mode).'),
                ],
                if (hasBankError) ...[
                  const SizedBox(height: BauhausDesign.space3),
                  _errorInlineBox(employee.bankDetailsError),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeClientModeToggle(_EmployeeInvoiceEmployeeState employee) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.backgroundLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        children: [
          RadioListTile<bool>(
            value: true,
            groupValue: employee.allClientsMode,
            dense: true,
            activeColor: BauhausDesign.primary,
            title: Text(
              'All clients for this employee',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            onChanged: (v) => _updateSelectedEmployee(
              employee.email,
              (e) => e.copyWith(allClientsMode: true, selectedClientEmail: ''),
            ),
          ),
          RadioListTile<bool>(
            value: false,
            groupValue: employee.allClientsMode,
            dense: true,
            activeColor: BauhausDesign.primary,
            title: Text(
              'Specific client for this employee',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            onChanged: (v) => _updateSelectedEmployee(
              employee.email,
              (e) => e.copyWith(allClientsMode: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeClientsList(_EmployeeInvoiceEmployeeState employee) {
    if (employee.isLoadingClients) return _hintBox('Loading clients...');
    if (employee.clients.isEmpty) {
      return _hintBox('No clients found for this employee.');
    }

    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: ListView.separated(
        itemCount: employee.clients.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: BauhausDesign.neutral),
        itemBuilder: (context, index) {
          final c = employee.clients[index];
          final email = c['clientEmail']?.toString() ?? '';
          final name = c['clientName']?.toString() ?? email;
          final isSelected =
              !employee.allClientsMode && email == employee.selectedClientEmail;

          return ListTile(
            dense: true,
            enabled: !employee.allClientsMode,
            title: Text(
              name.isNotEmpty ? name : 'Unknown Client',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  ),
            ),
            subtitle: Text(
              email,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: isSelected
                ? Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: BauhausDesign.success,
                      borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                      border: Border.all(
                          color: BauhausDesign.neutral, width: 1.5),
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: BauhausDesign.textDark, size: 16),
                  )
                : null,
            onTap: employee.allClientsMode
                ? null
                : () => _updateSelectedEmployee(
                      employee.email,
                      (e) => e.copyWith(selectedClientEmail: email),
                    ),
          );
        },
      ),
    );
  }

  Widget _buildConfigurationPanel() {
    return _bauhausPanel(
      title: '2) Configure & Generate',
      color: BauhausDesign.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSelectionSummary(),
          const SizedBox(height: BauhausDesign.space4),
          _buildOptionsSection(),
          const SizedBox(height: BauhausDesign.space4),
          _buildBankDetailsSection(),
          const SizedBox(height: BauhausDesign.space4),
          _buildGenerateSection(),
          if ((_generateError ?? '').isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space3),
            _errorInlineBox(_generateError!),
          ],
          if (_generatedResults.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space4),
            _buildGeneratedPdfsSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectionSummary() {
    final selected = _selectedEmployeesByEmail.values.toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    final employeeLine =
        selected.isEmpty ? 'No employees selected' : '${selected.length} selected';

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selection Summary',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            'Employees: $employeeLine',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          if (selected.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space3),
            ...selected.map((e) {
              final clientLabel = e.allClientsMode
                  ? 'All clients'
                  : (e.selectedClientEmail.isNotEmpty
                      ? e.selectedClientEmail
                      : 'Select a client');
              return Padding(
                padding: const EdgeInsets.only(bottom: BauhausDesign.space1),
                child: Text(
                  '${e.name}: $clientLabel',
                  style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildOptionsSection() {
    final df = DateFormat('dd/MM/yyyy');
    final range = _dateRange;
    final rangeText = range == null
        ? 'Select a date range'
        : '${df.format(range.start)} - ${df.format(range.end)}';

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice Options',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          SwitchListTile(
            value: _includeExpenses,
            onChanged: _selectedEmployeesByEmail.isEmpty
                ? null
                : (v) => setState(() => _includeExpenses = v),
            title: Text(
              'Include Approved Expenses',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            activeColor: BauhausDesign.primary,
          ),
          SwitchListTile(
            value: _includeTax,
            onChanged: _selectedEmployeesByEmail.isEmpty
                ? null
                : (v) => setState(() => _includeTax = v),
            title: Text(
              'Include Tax',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            activeColor: BauhausDesign.primary,
          ),
          if (_includeTax) ...[
            const SizedBox(height: BauhausDesign.space2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Tax Rate',
                    style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                          color: BauhausDesign.neutral,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    initialValue: (_taxRate * 100).toStringAsFixed(1),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      suffixText: '%',
                      filled: true,
                      fillColor: BauhausDesign.backgroundLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                        borderSide:
                            const BorderSide(color: BauhausDesign.neutral, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                        borderSide:
                            const BorderSide(color: BauhausDesign.neutral, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                        borderSide:
                            const BorderSide(color: BauhausDesign.primary, width: 2),
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
          ],
          const SizedBox(height: BauhausDesign.space3),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Date Range',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            subtitle: Text(
              rangeText,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(BauhausDesign.space2),
              decoration: BoxDecoration(
                color: BauhausDesign.backgroundLight,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              ),
              child: const Icon(Icons.date_range_rounded,
                  size: 18, color: BauhausDesign.textDark),
            ),
            onTap: _selectedEmployeesByEmail.isEmpty ? null : _pickDateRange,
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsSection() {
    final selected = _selectedEmployeesByEmail.values.toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    if (selected.isEmpty) {
      return _hintBox('Select employees to load bank details.');
    }

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Employee Bank Details',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            'Admin bank details will not be used.',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.neutral,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          ...selected.map((e) {
            final data = e.bankDetails ?? const <String, dynamic>{};
            final bankName = data['bankName']?.toString() ?? '';
            final accountName = data['accountName']?.toString() ?? '';
            final bsb = data['bsb']?.toString() ?? '';
            final accountNumber = data['accountNumber']?.toString() ?? '';

            return Container(
              margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.backgroundLight,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name.isNotEmpty ? e.name : e.email,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w900,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    e.email,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.neutral,
                              fontWeight: FontWeight.w600,
                            ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  if (e.isLoadingBankDetails)
                    _hintBox('Loading bank details...')
                  else if (e.bankDetailsError.isNotEmpty)
                    _errorInlineBox(e.bankDetailsError)
                  else ...[
                    _bankRow('Bank Name', bankName),
                    _bankRow('Account Name', accountName),
                    _bankRow('BSB', bsb),
                    _bankRow('Account Number', accountNumber),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _bankRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space2,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.backgroundLight,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              ),
              child: Text(
                value.isNotEmpty ? value : '—',
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateSection() {
    final validation = _validationResult;
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Generate',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          if (!validation.isValid) _errorInlineBox(validation.message),
          const SizedBox(height: BauhausDesign.space2),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isGenerating ? null : (_canGenerate ? _generate : null),
              style: ElevatedButton.styleFrom(
                backgroundColor: BauhausDesign.primary,
                foregroundColor: BauhausDesign.textDark,
                padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  side: const BorderSide(color: BauhausDesign.neutral, width: 2.5),
                ),
              ),
              child: _isGenerating
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: BauhausDesign.textDark,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Text(
                          'Generating...',
                          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: BauhausDesign.textDark,
                              ),
                        ),
                      ],
                    )
                  : Text(
                      'Generate Employee Invoice PDF',
                      style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: BauhausDesign.textDark,
                          ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedPdfsSection() {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Generated PDFs',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _generatedResults.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: BauhausDesign.neutral),
            itemBuilder: (context, index) {
              final item = _generatedResults[index];
              final path = item.pdfPath;
              final name = path.split('/').last;
              return ListTile(
                dense: true,
                title: Text(
                  name,
                  style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                  ),
                  child: const Icon(Icons.picture_as_pdf_rounded,
                      size: 18, color: BauhausDesign.textDark),
                ),
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
