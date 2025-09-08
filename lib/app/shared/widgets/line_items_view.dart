import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:carenest/app/features/invoice/viewmodels/line_items_viewmodel.dart';

class LineItemsView extends ConsumerStatefulWidget {
  const LineItemsView({super.key});

  @override
  _LineItemsControllerState createState() {
    return _LineItemsControllerState();
  }
}

class _LineItemsControllerState extends ConsumerState<LineItemsView> {
  final ApiMethod apiMethod = ApiMethod();

  List<Map<String, dynamic>> _lineItems = [];

  @override
  void initState() {
    fetchSupportItems();
    super.initState();
  }

  Future<void> fetchSupportItems() async {
    await ref.read(lineItemViewModelProvider.notifier).getSupportItems();
    setState(() {
      _lineItems = ref.watch(lineItemViewModelProvider);
    });
  }

  Widget _buildTile(String? title, Color? backgroundColor) {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            title!,
            style: ModernSaasDesign.bodyLarge.copyWith(
              color: ModernSaasDesign.textOnPrimary,
            ),
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'line_items_scaffold_key');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Support item list with description',
          style: ModernSaasDesign.headlineSmall,
        ),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            if (_lineItems.isEmpty) {
              return const Text("No support item retrieved");
            } else {
              return AnimationList(
                duration: 1000,
                reBounceDepth: 10.0,
                children: _lineItems.map((item) {
                  final itemNumber = item['itemNumber'] ?? '';
                  final itemName = item['itemDescription'] ?? '';
                  return _buildTile(
                    "$itemNumber\n$itemName",
                    ModernSaasDesign.primary,
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
