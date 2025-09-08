import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/app/shared/design_system/modern_pricing_design_system.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';

class NdisItemManagementView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String? organizationId;

  const NdisItemManagementView({
    super.key,
    required this.adminEmail,
    this.organizationId,
  });

  @override
  ConsumerState<NdisItemManagementView> createState() =>
      _NdisItemManagementViewState();
}

class _NdisItemManagementViewState extends ConsumerState<NdisItemManagementView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _itemCodeController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Core Supports';
  String _selectedUnit = 'Hour';
  bool _isActive = true;
  String _searchQuery = '';
  bool _isLoading = false;
  bool _showOnboarding = true;
  Set<String> _selectedItemIds = {};

  final List<String> _categories = [
    'Core Supports',
    'Capacity Building',
    'Capital Supports',
    'Support Coordination',
  ];

  final List<String> _units = [
    'Hour',
    'Day',
    'Week',
    'Month',
    'Each',
    'Kilometer',
  ];

  // Mock data for NDIS items
  List<Map<String, dynamic>> _ndisItems = [
    {
      'id': '1',
      'code': '01_001_0103_1_1',
      'name': 'Assistance with personal activities',
      'description': 'Support with personal care and daily living activities',
      'category': 'Core Supports',
      'unitPrice': 62.17,
      'unit': 'Hour',
      'isActive': true,
      'lastUpdated': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '2',
      'code': '01_002_0103_1_1',
      'name': 'Assistance with household tasks',
      'description': 'Support with household cleaning and maintenance',
      'category': 'Core Supports',
      'unitPrice': 62.17,
      'unit': 'Hour',
      'isActive': true,
      'lastUpdated': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '3',
      'code': '01_003_0103_1_1',
      'name': 'Assistance with community participation',
      'description': 'Support to participate in community activities',
      'category': 'Core Supports',
      'unitPrice': 62.17,
      'unit': 'Hour',
      'isActive': true,
      'lastUpdated': DateTime.now(),
    },
    {
      'id': '4',
      'code': '02_001_0106_6_1',
      'name': 'Group activities in the community',
      'description': 'Participation in group community activities',
      'category': 'Core Supports',
      'unitPrice': 15.54,
      'unit': 'Hour',
      'isActive': true,
      'lastUpdated': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'id': '5',
      'code': '07_001_0125_6_1',
      'name': 'Support coordination',
      'description': 'Coordination of supports and services',
      'category': 'Support Coordination',
      'unitPrice': 193.99,
      'unit': 'Hour',
      'isActive': false,
      'lastUpdated': DateTime.now().subtract(const Duration(days: 7)),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _itemCodeController.dispose();
    _itemNameController.dispose();
    _unitPriceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredItems {
    return _ndisItems.where((item) {
      final matchesSearch = _searchQuery.isEmpty ||
          item['name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          item['code']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernPricingDesign.surfacePrimary,
      body: CustomScrollView(
        slivers: [
          _buildModernAppBar(),
          SliverToBoxAdapter(
            child: _buildModernContent(),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildModernAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: ModernPricingDesign.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'NDIS Item Management',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ModernPricingDesign.primaryColor,
                ModernPricingDesign.primaryColor.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.download, color: Colors.white),
          onPressed: () {
            _showSnackBar('Export functionality coming soon...');
          },
        ),
        IconButton(
          icon: const Icon(Icons.upload, color: Colors.white),
          onPressed: () {
            _showSnackBar('Import functionality coming soon...');
          },
        ),
      ],
    );
  }

  Widget _buildModernContent() {
    final filteredItems = _filteredItems;
    final isEmpty = !_isLoading && filteredItems.isEmpty;

    return Stack(
      children: [
        Column(
          children: [
            _buildSearchAndFilters(),
            _buildStatsRow(),
            if (_isLoading)
              SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ModernPricingDesign.primaryColor,
                    semanticsLabel: 'Loading NDIS items',
                  ),
                ),
              )
            else if (isEmpty)
              SizedBox(
                height: 400,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox,
                          size: 48, color: ModernPricingDesign.textSecondary),
                      const SizedBox(height: 12),
                      Text(
                        'No NDIS items found.',
                        style:
                            TextStyle(color: ModernPricingDesign.textSecondary),
                      ),
                    ],
                  ),
                ),
              )
            else
              _buildItemsList(),
            if (_selectedItemIds.isNotEmpty)
              Container(
                color: ModernPricingDesign.surfaceSecondary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Text('${_selectedItemIds.length} selected'),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Delete selected',
                      onPressed: _deleteSelectedItems,
                    ),
                  ],
                ),
              ),
          ],
        ),
        if (_showOnboarding)
          Positioned(
            top: 20,
            left: 24,
            right: 24,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ModernPricingDesign.surfaceCard,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: ModernPricingDesign.cardShadow,
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: ModernPricingDesign.primaryColor),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Tip: Use the checkboxes to select multiple items for bulk actions.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: 'Dismiss',
                      onPressed: () => setState(() => _showOnboarding = false),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: ModernPricingDesign.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              boxShadow: ModernPricingDesign.cardShadow,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by item name or code...',
                hintStyle: TextStyle(color: ModernPricingDesign.textSecondary),
                prefixIcon: Icon(Icons.search,
                    color: ModernPricingDesign.textSecondary),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear,
                            color: ModernPricingDesign.textSecondary),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : '';
                      });
                    },
                    backgroundColor: ModernPricingDesign.surfaceCard,
                    selectedColor:
                        ModernPricingDesign.primaryColor.withValues(alpha: 0.2),
                    checkmarkColor: ModernPricingDesign.primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? ModernPricingDesign.primaryColor
                          : ModernPricingDesign.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? ModernPricingDesign.primaryColor
                            : ModernPricingDesign.borderColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    )
        .animate(delay: 200.ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.2, end: 0);
  }

  Widget _buildStatsRow() {
    final activeItems = _ndisItems.where((item) => item['isActive']).length;
    final inactiveItems = _ndisItems.length - activeItems;
    final filteredCount = _filteredItems.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ModernPricingDesign.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: ModernPricingDesign.cardShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', _ndisItems.length.toString(),
              ModernPricingDesign.accentBlue),
          _buildStatItem('Active', activeItems.toString(),
              ModernPricingDesign.accentGreen),
          _buildStatItem('Inactive', inactiveItems.toString(),
              ModernPricingDesign.accentRed),
          _buildStatItem('Filtered', filteredCount.toString(),
              ModernPricingDesign.primaryColor),
        ],
      ),
    )
        .animate(delay: 300.ms)
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: ModernPricingDesign.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildItemsList() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ModernPricingDesign.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: ModernPricingDesign.cardShadow,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
          final isSelected = _selectedItemIds.contains(item['id']);
          return Semantics(
            label: 'NDIS item card',
            child: GestureDetector(
              onLongPress: () => setState(() {
                if (isSelected) {
                  _selectedItemIds.remove(item['id']);
                } else {
                  _selectedItemIds.add(item['id']);
                }
              }),
              child: Row(
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: (checked) => setState(() {
                      if (checked == true) {
                        _selectedItemIds.add(item['id']);
                      } else {
                        _selectedItemIds.remove(item['id']);
                      }
                    }),
                    activeColor: ModernPricingDesign.primaryColor,
                  ),
                  Expanded(child: _buildItemCard(item, index)),
                ],
              ),
            ),
          );
        },
      ),
    )
        .animate(delay: 400.ms)
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.2, end: 0);
  }

  Widget _buildItemCard(Map<String, dynamic> item, int index) {
    final isActive = item['isActive'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive
            ? ModernPricingDesign.surfaceCard
            : ModernPricingDesign.surfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? ModernPricingDesign.primaryColor.withValues(alpha: 0.2)
              : ModernPricingDesign.borderColor,
          width: 1,
        ),
        boxShadow: isActive ? ModernPricingDesign.cardShadow : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ModernPricingDesign.primaryColor
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item['code'],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: ModernPricingDesign.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? ModernPricingDesign.accentGreen
                                    .withValues(alpha: 0.1)
                                : ModernPricingDesign.textSecondary
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isActive ? 'Active' : 'Inactive',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? ModernPricingDesign.accentGreen
                                  : ModernPricingDesign.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isActive
                            ? ModernPricingDesign.textPrimary
                            : ModernPricingDesign.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['description'],
                      style: TextStyle(
                        fontSize: 13,
                        color: ModernPricingDesign.textSecondary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${item['unitPrice'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isActive
                          ? ModernPricingDesign.accentGreen
                          : ModernPricingDesign.textSecondary,
                    ),
                  ),
                  Text(
                    'per ${item['unit']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: ModernPricingDesign.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Category: ${item['category']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ModernPricingDesign.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 90,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 2,
                  children: [
                    GestureDetector(
                      onTap: () => _editItem(item),
                      child: Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: Icon(Icons.edit,
                            size: 14, color: ModernPricingDesign.primaryColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _toggleItemStatus(item),
                      child: Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: Icon(
                          isActive ? Icons.visibility_off : Icons.visibility,
                          size: 14,
                          color: isActive
                              ? ModernPricingDesign.accentOrange
                              : ModernPricingDesign.accentGreen,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _deleteItem(item),
                      child: Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: Icon(Icons.delete,
                            size: 14, color: ModernPricingDesign.accentRed),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate(delay: (index * 100).ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.2, end: 0);
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      heroTag: "fab_add_item",
      onPressed: () => _addNewItem(),
      backgroundColor: ModernPricingDesign.primaryColor,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Add Item',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    )
        .animate(delay: 600.ms)
        .scale(begin: const Offset(0.5, 0.5))
        .fadeIn(duration: 400.ms);
  }

  void _addNewItem() {
    _clearForm();
    _showItemDialog(isEdit: false);
  }

  void _editItem(Map<String, dynamic> item) {
    _itemCodeController.text = item['code'];
    _itemNameController.text = item['name'];
    _unitPriceController.text = item['unitPrice'].toString();
    _descriptionController.text = item['description'];
    _selectedCategory = item['category'];
    _selectedUnit = item['unit'];
    _isActive = item['isActive'];

    _showItemDialog(isEdit: true, item: item);
  }

  void _clearForm() {
    _itemCodeController.clear();
    _itemNameController.clear();
    _unitPriceController.clear();
    _descriptionController.clear();
    _selectedCategory = 'Core Supports';
    _selectedUnit = 'Hour';
    _isActive = true;
  }

  void _showItemDialog({required bool isEdit, Map<String, dynamic>? item}) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            isEdit ? 'Edit NDIS Item' : 'Add New NDIS Item',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(
                    controller: _itemCodeController,
                    label: 'Item Code',
                    hint: 'e.g., 01_001_0103_1_1',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _itemNameController,
                    label: 'Item Name',
                    hint: 'e.g., Assistance with personal activities',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Brief description of the service',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          value: _selectedCategory,
                          label: 'Category',
                          items: _categories,
                          onChanged: (value) {
                            setDialogState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdown(
                          value: _selectedUnit,
                          label: 'Unit',
                          items: _units,
                          onChanged: (value) {
                            setDialogState(() {
                              _selectedUnit = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _unitPriceController,
                    label: 'Unit Price (\$)',
                    hint: '0.00',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _isActive,
                        onChanged: (value) {
                          setDialogState(() {
                            _isActive = value!;
                          });
                        },
                        activeColor: const Color(0xFF6C5CE7),
                      ),
                      const Text(
                        'Active',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_validateForm()) {
                  if (isEdit) {
                    _updateItem(item!);
                  } else {
                    _createItem();
                  }
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
              ),
              child: Text(isEdit ? 'Update' : 'Create'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _validateForm() {
    if (_itemCodeController.text.trim().isEmpty) {
      _showSnackBar('Please enter item code', isError: true);
      return false;
    }
    if (_itemNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter item name', isError: true);
      return false;
    }
    if (_unitPriceController.text.trim().isEmpty) {
      _showSnackBar('Please enter unit price', isError: true);
      return false;
    }
    final price = double.tryParse(_unitPriceController.text.trim());
    if (price == null || price < 0) {
      _showSnackBar('Please enter a valid price', isError: true);
      return false;
    }
    return true;
  }

  void _createItem() {
    final newItem = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'code': _itemCodeController.text.trim(),
      'name': _itemNameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'category': _selectedCategory,
      'unitPrice': double.parse(_unitPriceController.text.trim()),
      'unit': _selectedUnit,
      'isActive': _isActive,
      'lastUpdated': DateTime.now(),
    };

    setState(() {
      _ndisItems.add(newItem);
    });

    _showSnackBar('NDIS item created successfully!');
  }

  void _updateItem(Map<String, dynamic> item) {
    final index = _ndisItems.indexWhere((i) => i['id'] == item['id']);
    if (index != -1) {
      setState(() {
        _ndisItems[index] = {
          ...item,
          'code': _itemCodeController.text.trim(),
          'name': _itemNameController.text.trim(),
          'description': _descriptionController.text.trim(),
          'category': _selectedCategory,
          'unitPrice': double.parse(_unitPriceController.text.trim()),
          'unit': _selectedUnit,
          'isActive': _isActive,
          'lastUpdated': DateTime.now(),
        };
      });

      _showSnackBar('NDIS item updated successfully!');
    }
  }

  void _toggleItemStatus(Map<String, dynamic> item) {
    final index = _ndisItems.indexWhere((i) => i['id'] == item['id']);
    if (index != -1) {
      setState(() {
        _ndisItems[index]['isActive'] = !_ndisItems[index]['isActive'];
        _ndisItems[index]['lastUpdated'] = DateTime.now();
      });

      final status =
          _ndisItems[index]['isActive'] ? 'activated' : 'deactivated';
      _showSnackBar('Item $status successfully!');
    }
  }

  void _deleteItem(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete "${item['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _ndisItems.removeWhere((i) => i['id'] == item['id']);
              });
              Navigator.pop(context);
              _showSnackBar('Item deleted successfully!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : const Color(0xFF6C5CE7),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _deleteSelectedItems() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Selected Items'),
        content: Text(
            'Are you sure you want to delete ${_selectedItemIds.length} selected items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _ndisItems.removeWhere(
                    (item) => _selectedItemIds.contains(item['id']));
                _selectedItemIds.clear();
              });
              Navigator.pop(context);
              _showSnackBar('Selected items deleted successfully!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
