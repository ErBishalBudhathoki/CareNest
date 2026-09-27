import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import '../models/multi_org_rollup_model.dart';
import '../repositories/multi_org_repository.dart';

class MultiOrgRollupView extends ConsumerStatefulWidget {
  const MultiOrgRollupView({super.key});

  @override
  ConsumerState<MultiOrgRollupView> createState() => _MultiOrgRollupViewState();
}

class _MultiOrgRollupViewState extends ConsumerState<MultiOrgRollupView> {
  bool _isLoading = true;
  List<MultiOrgRollup> _orgs = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final multiOrgRepository = ref.read(multiOrgRepositoryProvider);
      final orgs = await multiOrgRepository.getRollup();
      setState(() {
        _orgs = orgs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.multiOrgRollupTitle,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor: colorScheme.inverseSurface,
        foregroundColor: colorScheme.onInverseSurface,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onInverseSurface),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: colorScheme.primary))
          : _error != null
          ? Center(
              child: Text(
                _error!,
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.error),
              ),
            )
          : _orgs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.business_rounded,
                    size: 64,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text('No Organization Data', style: textTheme.titleMedium),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orgs.length,
              itemBuilder: (context, index) {
                final org = _orgs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    border: Border.all(color: colorScheme.outline, width: 2),
                    boxShadow: const [BauhausDesign.shadowHard],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        org.organizationName.isNotEmpty
                            ? org.organizationName
                            : AppLocalizations.of(context)!.unknownOrg,
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStat(
                            context,
                            AppLocalizations.of(context)!.clientsCaps,
                            org.clientCount.toString(),
                          ),
                          _buildStat(
                            context,
                            AppLocalizations.of(context)!.invoicesCaps,
                            org.invoiceCount.toString(),
                          ),
                          _buildStat(
                            context,
                            AppLocalizations.of(context)!.revenueCaps,
                            '\$${org.revenue.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
