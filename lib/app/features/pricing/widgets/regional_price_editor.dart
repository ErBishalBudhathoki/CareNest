import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/pricing/viewmodels/scoped_pricing_editor.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String pricingRegionLabel(AppLocalizations l10n, PriceRegion region) =>
    switch (region) {
      PriceRegion.remote => l10n.pricingRemoteRegion,
      PriceRegion.veryRemote => l10n.pricingVeryRemoteRegion,
      _ => l10n.pricingNationalRegion,
    };

class RegionalCaps extends StatelessWidget {
  const RegionalCaps({super.key, required this.item, this.caps});
  final NDISItem item;
  final Map<String, dynamic>? caps;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labels = [
      l10n.pricingNationalCap,
      l10n.pricingRemoteCap,
      l10n.pricingVeryRemoteCap,
    ];
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        for (var index = 0; index < pricingRegions.length; index++)
          Text(
            '${labels[index]}: ${regionalPricingCap(item, pricingRegions[index], caps: caps)?.toStringAsFixed(2) ?? l10n.naLabel}',
          ),
      ],
    );
  }
}

class RegionalPriceEditor extends ConsumerStatefulWidget {
  const RegionalPriceEditor({
    super.key,
    required this.item,
    required this.organizationId,
    required this.onSaved,
    this.clientId,
    this.userEmail,
    this.onDirtyChanged,
    this.session,
    this.onScopeResolved,
  });
  final NDISItem item;
  final String organizationId;
  final String? clientId;
  final String? userEmail;
  final ValueChanged<Map<String, dynamic>> onSaved;
  final ValueChanged<bool>? onDirtyChanged;
  final ScopedPricingEditor? session;
  final ValueChanged<Map<String, dynamic>?>? onScopeResolved;

  @override
  ConsumerState<RegionalPriceEditor> createState() =>
      _RegionalPriceEditorState();
}

class _RegionalPriceEditorState extends ConsumerState<RegionalPriceEditor> {
  late final ScopedPricingEditor editor;
  final controller = TextEditingController();
  bool loading = true;
  bool saving = false;
  bool failed = false;

  @override
  void initState() {
    super.initState();
    editor =
        widget.session ??
        ScopedPricingEditor(
          api: ref.read(app_providers.apiMethodProvider),
          organizationId: widget.organizationId,
          item: widget.item,
          clientId: widget.clientId?.trim().isNotEmpty == true
              ? widget.clientId
              : null,
        );
    _load();
  }

  Future<void> _load() async {
    try {
      if (editor.drafts.isEmpty) await editor.load();
      if (!mounted) return;
      controller.text = editor.draft.priceText;
      setState(() => loading = false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onScopeResolved?.call(editor.draft.saved);
      });
    } catch (_) {
      if (mounted)
        setState(() {
          loading = false;
          failed = true;
        });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _changed() {
    widget.onDirtyChanged?.call(editor.hasUnsavedChanges);
    setState(() {});
  }

  Future<void> _save() async {
    setState(() => saving = true);
    try {
      final prefs = SharedPreferencesUtils();
      await prefs.init();
      final email = widget.userEmail ?? prefs.getString('userEmail') ?? '';
      if (email.trim().isEmpty) throw StateError('Missing user context');
      final saved = await editor.save(email);
      if (!mounted) return;
      widget.onSaved(saved);
      widget.onDirtyChanged?.call(editor.hasUnsavedChanges);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.customPricingSaved),
        ),
      );
    } catch (_) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.saveFailed)),
        );
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (loading) return const Center(child: CircularProgressIndicator());
    if (failed) return Text(l10n.pricingLoadFailed);
    final cap = regionalPricingCap(
      widget.item,
      editor.draft.region,
      caps: editor.caps,
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegionalCaps(item: widget.item, caps: editor.caps),
          const SizedBox(height: 12),
          if (editor.clientId != null)
            DropdownButtonFormField<bool>(
              initialValue: editor.clientScope,
              decoration: InputDecoration(labelText: l10n.pricingScopeLabel),
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: false,
                  child: Text(l10n.orgWideRateLabel),
                ),
                DropdownMenuItem(
                  value: true,
                  child: Text(l10n.clientSpecificRateLabel),
                ),
              ],
              onChanged: saving
                  ? null
                  : (value) {
                      editor.clientScope = value!;
                      controller.text = editor.draft.priceText;
                      widget.onScopeResolved?.call(editor.draft.saved);
                      _changed();
                    },
            ),
          DropdownButtonFormField<PriceRegion>(
            key: ValueKey(editor.clientScope),
            initialValue: editor.draft.region,
            decoration: InputDecoration(labelText: l10n.pricingRegionLabel),
            isExpanded: true,
            items: [
              for (final region in pricingRegions)
                DropdownMenuItem(
                  value: region,
                  child: Text(pricingRegionLabel(l10n, region)),
                ),
            ],
            onChanged: saving
                ? null
                : (value) {
                    editor.draft.region = value!;
                    editor.draft.regionTouched = true;
                    _changed();
                  },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            enabled: !saving,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.customPriceHourlyLabel,
              errorText: cap == null
                  ? l10n.pricingCapUnavailable
                  : !editor.draft.validFor(widget.item, editor.caps)
                  ? l10n.priceExceedsCap
                  : null,
            ),
            onChanged: (value) {
              editor.draft.priceText = value;
              _changed();
            },
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed:
                saving || !editor.draft.validFor(widget.item, editor.caps)
                ? null
                : _save,
            child: Text(
              saving ? l10n.loadingMessage : l10n.saveCustomPriceAction,
            ),
          ),
        ],
      ),
    );
  }
}
