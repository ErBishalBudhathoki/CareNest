import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:carenest/app/features/training_compliance/models/compliance_checklist.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class AdminComplianceManagementView extends ConsumerStatefulWidget {
  const AdminComplianceManagementView({super.key});

  @override
  ConsumerState<AdminComplianceManagementView> createState() =>
      _AdminComplianceManagementViewState();
}

class _AdminComplianceManagementViewState
    extends ConsumerState<AdminComplianceManagementView> {
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
        title: Text(AppLocalizations.of(context)!.manageChecklistsTitle,
            style: BauhausDesign.getTextTheme(context).headlineLarge),
        backgroundColor: BauhausDesign.surfaceLight,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddChecklistDialog(context),
        backgroundColor: BauhausDesign.primary,
        label: Text(AppLocalizations.of(context)!.addChecklistButton,
            style: BauhausDesign.getTextTheme(context)
                .labelLarge
                ?.copyWith(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : state.checklists.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noChecklistsFound,
                    style: BauhausDesign.getTextTheme(context).bodyLarge,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: state.checklists.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: BauhausDesign.space3),
                  itemBuilder: (context, index) {
                    final list = state.checklists[index];
                    return _buildChecklistCard(context, list);
                  },
                ),
    );
  }

  Widget _buildChecklistCard(BuildContext context, ComplianceChecklist list) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BauhausDesign.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            list.title,
            style: BauhausDesign.getTextTheme(context).headlineLarge,
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(list.description,
              style: BauhausDesign.getTextTheme(context).bodyMedium),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            '${list.items.length} items',
            style: BauhausDesign.getTextTheme(context)
                .labelLarge
                ?.copyWith(color: BauhausDesign.neutral),
          ),
        ],
      ),
    );
  }

  void _showAddChecklistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddChecklistDialog(),
    );
  }
}

class AddChecklistDialog extends ConsumerStatefulWidget {
  const AddChecklistDialog({super.key});

  @override
  ConsumerState<AddChecklistDialog> createState() => _AddChecklistDialogState();
}

class _AddChecklistDialogState extends ConsumerState<AddChecklistDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final List<TextEditingController> _itemControllers = [
    TextEditingController()
  ];

  void _addItem() {
    setState(() {
      _itemControllers.add(TextEditingController());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _itemControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: BauhausDesign.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      title: Text(AppLocalizations.of(context)!.addChecklistTitle,
          style: BauhausDesign.getTextTheme(context).headlineLarge),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.titleLabel),
                validator: (v) => v?.isEmpty == true
                    ? AppLocalizations.of(context)!.requiredValidation
                    : null,
              ),
              const SizedBox(height: BauhausDesign.space3),
              TextFormField(
                controller: _descController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.descriptionLabel),
                validator: (v) => v?.isEmpty == true
                    ? AppLocalizations.of(context)!.requiredValidation
                    : null,
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(AppLocalizations.of(context)!.itemsLabel,
                  style: BauhausDesign.getTextTheme(context).labelLarge),
              const SizedBox(height: BauhausDesign.space2),
              ..._itemControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: BauhausDesign.inputDecoration('')
                              .copyWith(
                                  labelText: AppLocalizations.of(context)!
                                      .itemNumberLabel(index + 1)),
                          validator: (v) => v?.isEmpty == true
                              ? AppLocalizations.of(context)!.requiredValidation
                              : null,
                        ),
                      ),
                      if (_itemControllers.length > 1)
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: BauhausDesign.error),
                          onPressed: () => _removeItem(index),
                        ),
                    ],
                  ),
                );
              }),
              TextButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: Text(AppLocalizations.of(context)!.addItemButton),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancelButton,
              style: BauhausDesign.getTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: BauhausDesign.textDark)),
        ),
        BauhausButton(
          text: AppLocalizations.of(context)!.createButton,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final data = {
                'title': _titleController.text,
                'description': _descController.text,
                'items': _itemControllers
                    .map((c) => {'text': c.text, 'isRequired': true})
                    .toList(),
              };
              ref
                  .read(complianceViewModelProvider.notifier)
                  .createChecklist(data);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
