import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class NdisItemSelectionView extends ConsumerStatefulWidget {
  const NdisItemSelectionView({super.key});

  @override
  ConsumerState<NdisItemSelectionView> createState() =>
      _NdisItemSelectionViewState();
}

class _NdisItemSelectionViewState extends ConsumerState<NdisItemSelectionView> {
  late final NDISMatcher _ndisMatcher;
  List<NDISItem> _allNdisItems = [];
  List<NDISItem> _filteredNdisItems = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _ndisMatcher = NDISMatcher(
      apiMethod: ref.read(app_providers.apiMethodProvider),
    );
    _loadNdisItems();
  }

  Future<void> _loadNdisItems() async {
    try {
      await _ndisMatcher.loadItems();
      setState(() {
        _allNdisItems = _ndisMatcher.items;
        _filteredNdisItems = _allNdisItems;
        _isLoading = false;
      });
    } catch (e, s) {
      log.severe("Failed to load NDIS items in NdisItemSelectionView", e, s);
      setState(() {
        _isLoading = false;
        // Optionally show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load NDIS items. Please try again.'),
          ),
        );
      });
    }
  }

  void _filterNdisItems(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredNdisItems = _allNdisItems;
      } else {
        _filteredNdisItems = _allNdisItems.where((item) {
          final lowerQuery = query.toLowerCase();
          return item.itemNumber.toLowerCase().contains(lowerQuery) ||
              item.itemName.toLowerCase().contains(lowerQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        title: Text(
          'Select NDIS Item',
          style: BauhausDesign.getTextTheme(context).titleLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: TextField(
              onChanged: _filterNdisItems,
              decoration: BauhausDesign.defaultInputDecoration.copyWith(
                labelText: 'Search by Item Number or Description',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          _isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : Expanded(
                  child: _filteredNdisItems.isEmpty && _searchQuery.isNotEmpty
                      ? Center(
                          child: Text(
                            'No matching NDIS items found.',
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).bodyMedium,
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space4,
                          ),
                          itemCount: _filteredNdisItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredNdisItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: BauhausDesign.space2,
                              ),
                              child: BauhausCard(
                                padding: const EdgeInsets.all(
                                  BauhausDesign.space4,
                                ),
                                onTap: () {
                                  Navigator.of(
                                    context,
                                  ).pop(item); // Return selected item
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.itemName,
                                      style: BauhausDesign.getTextTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: BauhausDesign.space1,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: BauhausDesign.space2,
                                        vertical: BauhausDesign.space1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: BauhausDesign.primary
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          BauhausDesign.radiusXs,
                                        ),
                                      ),
                                      child: Text(
                                        item.itemNumber,
                                        style:
                                            BauhausDesign.getTextTheme(
                                              context,
                                            ).labelSmall?.copyWith(
                                              color: BauhausDesign.primary,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }
}
