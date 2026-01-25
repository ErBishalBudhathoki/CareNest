import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
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
  final bool _isLoading = false;
  bool _showOnboarding = true;
  final Set<String> _selectedItemIds = {};

  List<String> _getCategories(BuildContext context) => [
        AppLocalizations.of(context)!.coreSupport,
        AppLocalizations.of(context)!.capacityBuilding,
        AppLocalizations.of(context)!.capitalSupport,
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
  final List<Map<String, dynamic>> _ndisItems = [
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
      backgroundColor: BauhausDesign.backgroundLight,
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
      backgroundColor: BauhausDesign.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          AppLocalizations.of(context)!.ndisItemManagementTitle,
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                color: BauhausDesign.surfaceWhite,
              ),
        ),
        background: Container(
          color: BauhausDesign.primary,
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
            _showSnackBar(AppLocalizations.of(context)!.exportComingSoon);
          },
        ),
        IconButton(
          icon: const Icon(Icons.upload, color: BauhausDesign.surfaceWhite),
          onPressed: () {
            _showSnackBar(AppLocalizations.of(context)!.importComingSoon);
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
                    color: BauhausDesign.primary,
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
                          size: 48, color: BauhausDesign.textMuted),
                      const SizedBox(height: 12),
                      Text(
                        AppLocalizations.of(context)!.noNdisItemsFound,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                    ],
                  ),
                ),
              )
            else
              _buildItemsList(),
            if (_selectedItemIds.isNotEmpty)
              Container(
                color: BauhausDesign.surfaceOffWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Text(
                        AppLocalizations.of(context)!
                            .selectedCount(_selectedItemIds.length.toString()),
                        style: BauhausDesign.getTextTheme(context).bodyMedium),
                    const Spacer(),
                    IconButton(
                      icon:
                          const Icon(Icons.delete, color: BauhausDesign.error),
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
            child: BauhausCard(
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: BauhausDesign.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.tipBulkActions,
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: AppLocalizations.of(context)!.dismissAction,
                    onPressed: () => setState(() => _showOnboarding = false),
                  ),
                ],
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
          BauhausSearchBar(
            controller: _searchController,
            hintText: AppLocalizations.of(context)!.searchItemsHint,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            onClear: () {
              setState(() {
                _searchQuery = '';
              });
            },
          ),
          const SizedBox(height: 16),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getCategories(context).map((category) {
                final isSelected = _selectedCategory == category;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: BauhausChip(
                    label: category,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedCategory = isSelected ? '' : category;
                      });
                    },
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
      child: BauhausCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(AppLocalizations.of(context)!.statTotal,
                _ndisItems.length.toString(), BauhausDesign.info),
            _buildStatItem(AppLocalizations.of(context)!.statActive,
                activeItems.toString(), BauhausDesign.success),
            _buildStatItem(AppLocalizations.of(context)!.statInactive,
                inactiveItems.toString(), BauhausDesign.error),
            _buildStatItem(AppLocalizations.of(context)!.statFiltered,
                filteredCount.toString(), BauhausDesign.primary),
          ],
        ),
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
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                color: color,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textMuted,
                fontSize: 12,
              ),
        ),
      ],
    );
  }

  Widget _buildItemsList() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
                  BauhausCheckbox(
                    value: isSelected,
                    onChanged: (checked) => setState(() {
                      if (checked == true) {
                        _selectedItemIds.add(item['id']);
                      } else {
                        _selectedItemIds.remove(item['id']);
                      }
                    }),
                    activeColor: BauhausDesign.primary,
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BauhausCard(
        backgroundColor: isActive
            ? BauhausDesign.surfaceWhite
            : BauhausDesign.surfaceOffWhite,
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
                              color: BauhausDesign.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item['code'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: BauhausDesign.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? BauhausDesign.success.withOpacity(0.1)
                                  : BauhausDesign.textMuted.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              isActive
                                  ? AppLocalizations.of(context)!.statActive
                                  : AppLocalizations.of(context)!.statInactive,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isActive
                                    ? BauhausDesign.success
                                    : BauhausDesign.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['name'],
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              color: isActive
                                  ? BauhausDesign.textDark
                                  : BauhausDesign.textMuted,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['description'],
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontSize: 13,
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
                      style: BauhausDesign.getTextTheme(context)
                          .headlineMedium
                          ?.copyWith(
                            color: isActive
                                ? BauhausDesign.success
                                : BauhausDesign.textMuted,
                          ),
                    ),
                    Text(
                      'per ${item['unit']}',
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontSize: 12,
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
                    AppLocalizations.of(context)!
                        .categoryValueLabel(item['category'].toString()),
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                          fontSize: 12,
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
                              size: 14, color: BauhausDesign.primary),
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
                                ? BauhausDesign.accent
                                : BauhausDesign.success,
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
                              size: 14, color: BauhausDesign.error),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
      backgroundColor: BauhausDesign.primary,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        AppLocalizations.of(context)!.addItemAction,
        style: const TextStyle(
            color: BauhausDesign.surfaceWhite, fontWeight: FontWeight.w600),
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
          backgroundColor: BauhausDesign.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            side: const BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
          title: Text(
            isEdit
                ? AppLocalizations.of(context)!.editNdisItemTitle
                : AppLocalizations.of(context)!.addNewNdisItemTitle,
            style: BauhausDesign.getTextTheme(context).headlineMedium,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(
                    controller: _itemCodeController,
                    label: AppLocalizations.of(context)!.itemCodeLabel,
                    hint: AppLocalizations.of(context)!.itemCodeHint,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _itemNameController,
                    label: AppLocalizations.of(context)!.itemNameLabel,
                    hint: AppLocalizations.of(context)!.itemNameHint,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _descriptionController,
                    label: AppLocalizations.of(context)!.detailsLabel,
                    hint: AppLocalizations.of(context)!.itemDescriptionHint,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          value: _selectedCategory,
                          label: AppLocalizations.of(context)!.categoryLabel,
                          items: _getCategories(context),
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
                          label: AppLocalizations.of(context)!.unitLabel,
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
                    label: AppLocalizations.of(context)!.unitPriceLabel,
                    hint: AppLocalizations.of(context)!.unitPriceHint,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      BauhausCheckbox(
                        value: _isActive,
                        onChanged: (value) {
                          setDialogState(() {
                            _isActive = value!;
                          });
                        },
                        activeColor: BauhausDesign.primary,
                      ),
                      Text(
                        AppLocalizations.of(context)!.statActive,
                        style: const TextStyle(
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
            BauhausActionButton(
              text: AppLocalizations.of(context)!.cancelAction,
              variant: BauhausActionVariant.ghost,
              onPressed: () => Navigator.pop(context),
            ),
            BauhausActionButton(
              text: isEdit
                  ? AppLocalizations.of(context)!.updateAction
                  : AppLocalizations.of(context)!.createAction,
              variant: BauhausActionVariant.primary,
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
          style: BauhausDesign.getTextTheme(context).labelLarge,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: BauhausDesign.inputDecoration(hint),
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
          style: BauhausDesign.getTextTheme(context).labelLarge,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          onChanged: onChanged,
          decoration: BauhausDesign.inputDecoration(''),
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
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete "${item['name']}"?'),
        actions: [
          BauhausActionButton(
            text: 'Cancel',
            variant: BauhausActionVariant.ghost,
            onPressed: () => Navigator.pop(context),
          ),
          BauhausActionButton(
            text: 'Delete',
            variant: BauhausActionVariant.danger,
            onPressed: () {
              setState(() {
                _ndisItems.removeWhere((i) => i['id'] == item['id']);
              });
              Navigator.pop(context);
              _showSnackBar('Item deleted successfully!');
            },
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
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
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        title: const Text('Delete Selected Items'),
        content: Text(
            'Are you sure you want to delete ${_selectedItemIds.length} selected items?'),
        actions: [
          BauhausActionButton(
            text: 'Cancel',
            variant: BauhausActionVariant.ghost,
            onPressed: () => Navigator.pop(context),
          ),
          BauhausActionButton(
            text: 'Delete',
            variant: BauhausActionVariant.danger,
            onPressed: () {
              setState(() {
                _ndisItems.removeWhere(
                    (item) => _selectedItemIds.contains(item['id']));
                _selectedItemIds.clear();
              });
              Navigator.pop(context);
              _showSnackBar('Selected items deleted successfully!');
            },
          ),
        ],
      ),
    );
  }
}
