import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:go_router/go_router.dart';

class NdisItemSelectionView extends ConsumerStatefulWidget {
  const NdisItemSelectionView({Key? key}) : super(key: key);

  @override
  ConsumerState<NdisItemSelectionView> createState() =>
      _NdisItemSelectionViewState();
}

class _NdisItemSelectionViewState extends ConsumerState<NdisItemSelectionView> {
  final NDISMatcher _ndisMatcher = NDISMatcher();
  List<NDISItem> _allNdisItems = [];
  List<NDISItem> _filteredNdisItems = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
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
            backgroundColor: Colors.red,
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
      appBar: AppBar(
        title: const Text('Select NDIS Item'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterNdisItems,
              decoration: const InputDecoration(
                labelText: 'Search by Item Number or Description',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          _isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: _filteredNdisItems.isEmpty && _searchQuery.isNotEmpty
                      ? const Center(
                          child: Text('No matching NDIS items found.'))
                      : ListView.builder(
                          itemCount: _filteredNdisItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredNdisItems[index];
                            return ListTile(
                              title: Text(item.itemName),
                              subtitle: Text(item.itemNumber),
                              onTap: () {
                                Navigator.of(context)
                                    .pop(item); // Return selected item
                              },
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }
}
