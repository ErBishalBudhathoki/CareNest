import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:carenest/app/features/training_compliance/models/compliance_checklist.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class ComplianceChecklistView extends ConsumerStatefulWidget {
  const ComplianceChecklistView({super.key});

  @override
  ConsumerState<ComplianceChecklistView> createState() =>
      _ComplianceChecklistViewState();
}

class _ComplianceChecklistViewState
    extends ConsumerState<ComplianceChecklistView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(complianceViewModelProvider.notifier).loadChecklists();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(complianceViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.complianceChecklistsTitle,
          style: BauhausDesign.getTextTheme(context).headlineLarge,
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary),
            )
          : state.checklists.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.noChecklistsMessage,
                style: BauhausDesign.getTextTheme(context).bodyLarge,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              itemCount: state.checklists.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: BauhausDesign.space3),
              itemBuilder: (context, index) {
                final checklist = state.checklists[index];
                return _buildChecklistCard(context, checklist);
              },
            ),
    );
  }

  Widget _buildChecklistCard(
    BuildContext context,
    ComplianceChecklist checklist,
  ) {
    final isCompleted = checklist.userStatus?.isCompleted ?? false;
    final totalItems = checklist.items.length;
    final completedItems =
        checklist.userStatus?.itemsStatus.values.where((v) => v).length ?? 0;

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  checklist.title,
                  style: BauhausDesign.getTextTheme(context).headlineLarge,
                ),
              ),
              if (isCompleted)
                const Icon(
                  Icons.verified,
                  color: BauhausDesign.success,
                  size: 24,
                ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            checklist.description,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
          const SizedBox(height: BauhausDesign.space3),
          LinearProgressIndicator(
            value: totalItems > 0 ? completedItems / totalItems : 0,
            backgroundColor: BauhausDesign.neutral.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
              isCompleted ? BauhausDesign.success : BauhausDesign.accent,
            ),
            minHeight: 8,
            borderRadius: BorderRadius.zero,
          ),
          const SizedBox(height: BauhausDesign.space3),
          SizedBox(
            width: double.infinity,
            child: BauhausButton(
              text: isCompleted
                  ? AppLocalizations.of(context)!.viewButton
                  : AppLocalizations.of(context)!.startChecklistButton,
              backgroundColor: isCompleted
                  ? BauhausDesign.secondary
                  : BauhausDesign.primary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChecklistDetailView(checklist: checklist),
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

class ChecklistDetailView extends ConsumerStatefulWidget {
  final ComplianceChecklist checklist;

  const ChecklistDetailView({super.key, required this.checklist});

  @override
  ConsumerState<ChecklistDetailView> createState() =>
      _ChecklistDetailViewState();
}

class _ChecklistDetailViewState extends ConsumerState<ChecklistDetailView> {
  late Map<String, bool> _itemsStatus;

  @override
  void initState() {
    super.initState();
    _itemsStatus = Map.from(widget.checklist.userStatus?.itemsStatus ?? {});
    // Initialize missing items as false
    for (var item in widget.checklist.items) {
      if (!_itemsStatus.containsKey(item.id ?? item.text)) {
        _itemsStatus[item.id ?? item.text] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          widget.checklist.title,
          style: BauhausDesign.getTextTheme(context).headlineLarge,
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              itemCount: widget.checklist.items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = widget.checklist.items[index];
                final itemId = item.id ?? item.text;
                final isChecked = _itemsStatus[itemId] ?? false;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space2,
                    vertical: BauhausDesign.space1,
                  ),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceLight,
                    border: Border.all(
                      color: BauhausDesign.neutral.withOpacity(0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      BauhausCheckbox(
                        value: isChecked,
                        activeColor: BauhausDesign.success,
                        onChanged: (val) {
                          setState(() {
                            _itemsStatus[itemId] = val ?? false;
                          });
                        },
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          item.text,
                          style: BauhausDesign.getTextTheme(context).bodyLarge,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: BauhausButton(
              text: AppLocalizations.of(context)!.saveProgressButton,
              onPressed: () {
                final isCompleted = widget.checklist.items.every((item) {
                  final itemId = item.id ?? item.text;
                  // If required, must be checked. Assuming all required for now or check isRequired
                  return !item.isRequired || (_itemsStatus[itemId] ?? false);
                });

                ref
                    .read(complianceViewModelProvider.notifier)
                    .updateChecklistStatus(
                      widget.checklist.id!,
                      _itemsStatus,
                      isCompleted,
                    );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
