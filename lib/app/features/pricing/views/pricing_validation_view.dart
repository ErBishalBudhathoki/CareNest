import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';

class PricingValidationView extends StatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const PricingValidationView({
    Key? key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  }) : super(key: key);

  @override
  _PricingValidationViewState createState() => _PricingValidationViewState();
}

class _PricingValidationViewState extends State<PricingValidationView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedValidationType = 'All';
  String _selectedSeverity = 'All';

  // Mock validation data
  final List<Map<String, dynamic>> _validationResults = [
    {
      'id': 'VAL001',
      'type': 'Price Range',
      'severity': 'Error',
      'message': 'NDIS item 01_001_0103_1_1 price exceeds maximum allowed rate',
      'details': 'Current: \$150.00, Maximum: \$120.00',
      'itemCode': '01_001_0103_1_1',
      'timestamp': '2024-01-15 10:30:00',
      'status': 'Unresolved',
    },
    {
      'id': 'VAL002',
      'type': 'Duplicate Entry',
      'severity': 'Warning',
      'message': 'Duplicate service rate found for Support Worker Level 2',
      'details': 'Multiple entries with same parameters detected',
      'itemCode': 'SW_L2_001',
      'timestamp': '2024-01-15 09:15:00',
      'status': 'Resolved',
    },
    {
      'id': 'VAL003',
      'type': 'Missing Data',
      'severity': 'Error',
      'message': 'Required pricing information missing for new NDIS item',
      'details': 'Unit price and billing code not specified',
      'itemCode': '01_002_0104_1_1',
      'timestamp': '2024-01-15 08:45:00',
      'status': 'Unresolved',
    },
    {
      'id': 'VAL004',
      'type': 'Rate Consistency',
      'severity': 'Warning',
      'message': 'Inconsistent pricing across similar service types',
      'details': 'Variation exceeds 15% threshold',
      'itemCode': 'MULTI',
      'timestamp': '2024-01-15 07:20:00',
      'status': 'Under Review',
    },
  ];

  final List<Map<String, dynamic>> _validationRules = [
    {
      'id': 'RULE001',
      'name': 'NDIS Price Range Validation',
      'description': 'Ensures NDIS item prices are within allowed ranges',
      'status': 'Active',
      'lastUpdated': '2024-01-10',
      'violations': 12,
    },
    {
      'id': 'RULE002',
      'name': 'Duplicate Entry Check',
      'description': 'Identifies duplicate pricing entries',
      'status': 'Active',
      'lastUpdated': '2024-01-08',
      'violations': 3,
    },
    {
      'id': 'RULE003',
      'name': 'Required Field Validation',
      'description': 'Checks for missing mandatory pricing data',
      'status': 'Active',
      'lastUpdated': '2024-01-12',
      'violations': 8,
    },
    {
      'id': 'RULE004',
      'name': 'Rate Consistency Check',
      'description': 'Validates pricing consistency across similar services',
      'status': 'Inactive',
      'lastUpdated': '2024-01-05',
      'violations': 0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      // This forces a rebuild when the tab changes
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing Validation',
            style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Validation Results'),
            Tab(text: 'Validation Rules'),
            Tab(text: 'Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildValidationResultsTab(),
          _buildValidationRulesTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  // This method is no longer used since we've moved to a simpler layout structure
  // with AppBar directly in the Scaffold
  Widget _buildAppBar() {
    return Container(
      height: 250,
      color: AppColors.colorPrimary,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.colorPrimary,
                  AppColors.colorPrimary.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -50,
                  top: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                const Positioned(
                  left: 25,
                  bottom: 65,
                  child: Icon(
                    Icons.verified_user,
                    size: 40,
                    color: Colors.white70,
                  ),
                ),
                Positioned(
                  left: 80,
                  bottom: 20,
                  child: const Text(
                    'Pricing Validation',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(text: 'Validation Results'),
              Tab(text: 'Validation Rules'),
              Tab(text: 'Reports'),
            ],
          ),
        ],
      ),
    );
  }

  // This method is no longer used since we've moved to a simpler layout structure
  Widget _buildStatCards() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Issues',
              '23',
              Icons.error_outline,
              Colors.red,
              '+5 from last week',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Resolved',
              '18',
              Icons.check_circle_outline,
              Colors.green,
              '78% resolution rate',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Active Rules',
              '12',
              Icons.rule,
              Colors.blue,
              '3 updated today',
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // This method is no longer used since we've moved to a simpler layout structure
  // with TabBarView directly in the Scaffold body
  Widget _buildTabContent() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildValidationResultsTab(),
          _buildValidationRulesTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildValidationResultsTab() {
    final filteredResults = _validationResults.where((result) {
      final matchesSearch = result['message']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesType = _selectedValidationType == 'All' ||
          result['type'] == _selectedValidationType;
      final matchesSeverity =
          _selectedSeverity == 'All' || result['severity'] == _selectedSeverity;
      return matchesSearch && matchesType && matchesSeverity;
    }).toList();

    return SafeArea(
      child: Container(
        color: Colors.blue[50], // Distinctive background color for this tab
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.blue[100],
              child: const Text(
                "VALIDATION RESULTS TAB",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            _buildValidationFilters(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredResults.length,
                itemBuilder: (context, index) {
                  final result = filteredResults[index];
                  return _buildValidationResultCard(result, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search validation results...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedValidationType,
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: [
                    'All',
                    'Price Range',
                    'Duplicate Entry',
                    'Missing Data',
                    'Rate Consistency'
                  ]
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValidationType = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedSeverity,
                  decoration: InputDecoration(
                    labelText: 'Severity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['All', 'Error', 'Warning', 'Info']
                      .map((severity) => DropdownMenuItem(
                            value: severity,
                            child: Text(severity),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSeverity = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValidationResultCard(Map<String, dynamic> result, int index) {
    final severityColor = result['severity'] == 'Error'
        ? Colors.red
        : result['severity'] == 'Warning'
            ? Colors.orange
            : Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: severityColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            result['severity'] == 'Error'
                ? Icons.error
                : result['severity'] == 'Warning'
                    ? Icons.warning
                    : Icons.info,
            color: severityColor,
          ),
        ),
        title: Text(
          result['message'],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: severityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    result['severity'],
                    style: TextStyle(
                      color: severityColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  result['type'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Item: ${result['itemCode']} • ${result['timestamp']}',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 11,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  result['details'],
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Use a more responsive layout based on available width
                    final bool isNarrow = constraints.maxWidth < 350;

                    return isNarrow
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: result['status'] == 'Resolved'
                                      ? Colors.green.withValues(alpha: 0.1)
                                      : result['status'] == 'Under Review'
                                          ? Colors.orange.withValues(alpha: 0.1)
                                          : Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  result['status'],
                                  style: TextStyle(
                                    color: result['status'] == 'Resolved'
                                        ? Colors.green
                                        : result['status'] == 'Under Review'
                                            ? Colors.orange
                                            : Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        _resolveValidationIssue(result['id']),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      minimumSize: const Size(60, 36),
                                    ),
                                    child: const Text('Resolve'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        _viewValidationDetails(result),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      minimumSize: const Size(60, 36),
                                    ),
                                    child: const Text('View Details'),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: result['status'] == 'Resolved'
                                      ? Colors.green.withValues(alpha: 0.1)
                                      : result['status'] == 'Under Review'
                                          ? Colors.orange.withValues(alpha: 0.1)
                                          : Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  result['status'],
                                  style: TextStyle(
                                    color: result['status'] == 'Resolved'
                                        ? Colors.green
                                        : result['status'] == 'Under Review'
                                            ? Colors.orange
                                            : Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 70,
                                child: TextButton(
                                  onPressed: () =>
                                      _resolveValidationIssue(result['id']),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    minimumSize: const Size(40, 36),
                                  ),
                                  child: const Text('Resolve',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                child: TextButton(
                                  onPressed: () =>
                                      _viewValidationDetails(result),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    minimumSize: const Size(40, 36),
                                  ),
                                  child: const Text('View Details',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3, end: 0);
  }

  Widget _buildValidationRulesTab() {
    return SafeArea(
      child: Container(
        color: Colors.green[50], // Distinctive background color for this tab
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.green[100],
              child: const Text(
                "VALIDATION RULES TAB",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: _validationRules.length,
                  itemBuilder: (context, index) {
                    final rule = _validationRules[index];
                    return _buildValidationRuleCard(rule, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationRuleCard(Map<String, dynamic> rule, int index) {
    final isActive = rule['status'] == 'Active';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.green[200]! : Colors.grey[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  rule['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  rule['status'],
                  style: TextStyle(
                    color: isActive ? Colors.green : Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            rule['description'],
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.error_outline,
                size: 16,
                color: Colors.red[400],
              ),
              const SizedBox(width: 4),
              Text(
                '${rule['violations']} violations',
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'Updated: ${rule['lastUpdated']}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton.icon(
                onPressed: () => _editValidationRule(rule),
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Edit'),
              ),
              TextButton.icon(
                onPressed: () => _toggleValidationRule(rule['id']),
                icon: Icon(
                  isActive ? Icons.pause : Icons.play_arrow,
                  size: 16,
                ),
                label: Text(isActive ? 'Disable' : 'Enable'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _runValidationRule(rule['id']),
                child: const Text('Run Now'),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideY(begin: 0.3, end: 0);
  }

  Widget _buildReportsTab() {
    return SafeArea(
      child: Container(
        color: Colors.purple[50], // Distinctive background color for this tab
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.purple[100],
              child: const Text(
                "REPORTS TAB",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    const Text(
                      'Validation Reports',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildReportCard(
                      'Daily Validation Summary',
                      'Comprehensive daily report of all validation activities',
                      Icons.today,
                      Colors.blue,
                      () => _generateReport('daily'),
                    ),
                    const SizedBox(height: 12),
                    _buildReportCard(
                      'Weekly Trends Analysis',
                      'Weekly analysis of validation trends and patterns',
                      Icons.trending_up,
                      Colors.green,
                      () => _generateReport('weekly'),
                    ),
                    const SizedBox(height: 12),
                    _buildReportCard(
                      'Rule Performance Report',
                      'Performance metrics for all validation rules',
                      Icons.analytics,
                      Colors.orange,
                      () => _generateReport('performance'),
                    ),
                    const SizedBox(height: 12),
                    _buildReportCard(
                      'Custom Report Builder',
                      'Create custom validation reports with specific criteria',
                      Icons.build,
                      Colors.purple,
                      () => _openCustomReportBuilder(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_forward_ios),
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  void _resolveValidationIssue(String issueId) {
    setState(() {
      final index = _validationResults.indexWhere((r) => r['id'] == issueId);
      if (index != -1) {
        _validationResults[index]['status'] = 'Resolved';
      }
    });
    _showSnackBar('Validation issue resolved successfully');
  }

  void _viewValidationDetails(Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Validation Details - ${result['id']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${result['type']}'),
            const SizedBox(height: 8),
            Text('Severity: ${result['severity']}'),
            const SizedBox(height: 8),
            Text('Item Code: ${result['itemCode']}'),
            const SizedBox(height: 8),
            Text('Message: ${result['message']}'),
            const SizedBox(height: 8),
            Text('Details: ${result['details']}'),
            const SizedBox(height: 8),
            Text('Timestamp: ${result['timestamp']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _editValidationRule(Map<String, dynamic> rule) {
    _showSnackBar('Edit validation rule: ${rule['name']}');
  }

  void _toggleValidationRule(String ruleId) {
    setState(() {
      final index = _validationRules.indexWhere((r) => r['id'] == ruleId);
      if (index != -1) {
        _validationRules[index]['status'] =
            _validationRules[index]['status'] == 'Active'
                ? 'Inactive'
                : 'Active';
      }
    });
    _showSnackBar('Validation rule status updated');
  }

  void _runValidationRule(String ruleId) {
    _showSnackBar('Running validation rule...');
  }

  void _generateReport(String type) {
    _showSnackBar('Generating $type report...');
  }

  void _openCustomReportBuilder() {
    _showSnackBar('Opening custom report builder...');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.colorPrimary,
      ),
    );
  }
}
