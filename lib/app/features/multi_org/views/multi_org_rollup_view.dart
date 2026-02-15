import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
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
    return Scaffold(
      backgroundColor: BauhausTheme.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.multiOrgRollupTitle,
            style: BauhausTheme.headerStyle),
        backgroundColor: BauhausTheme.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausTheme.black),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausTheme.blue))
          : _error != null
              ? Center(
                  child: Text(_error!,
                      style: BauhausTheme.bodyStyle
                          .copyWith(color: BauhausTheme.red)))
              : _orgs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.business_rounded,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            'No Organization Data',
                            style: BauhausTheme.subHeaderStyle,
                          ),
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
                          decoration: BauhausTheme.blockDecoration.copyWith(
                            border:
                                Border.all(color: BauhausTheme.black, width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  org.organizationName.isNotEmpty
                                      ? org.organizationName
                                      : AppLocalizations.of(context)!
                                          .unknownOrg,
                                  style: BauhausTheme.subHeaderStyle),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStat(
                                      AppLocalizations.of(context)!.clientsCaps,
                                      org.clientCount.toString()),
                                  _buildStat(
                                      AppLocalizations.of(context)!
                                          .invoicesCaps,
                                      org.invoiceCount.toString()),
                                  _buildStat(
                                      AppLocalizations.of(context)!.revenueCaps,
                                      '\$${org.revenue.toStringAsFixed(2)}'),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: BauhausTheme.labelStyle),
        Text(value,
            style:
                BauhausTheme.bodyStyle.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
