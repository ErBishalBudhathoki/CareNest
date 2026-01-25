import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:carenest/app/features/training_compliance/models/training_module.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class AdminTrainingManagementView extends ConsumerStatefulWidget {
  const AdminTrainingManagementView({super.key});

  @override
  ConsumerState<AdminTrainingManagementView> createState() =>
      _AdminTrainingManagementViewState();
}

class _AdminTrainingManagementViewState
    extends ConsumerState<AdminTrainingManagementView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trainingViewModelProvider.notifier).loadModules();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(trainingViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.manageTrainingTitle,
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
        onPressed: () => _showAddModuleDialog(context),
        backgroundColor: BauhausDesign.primary,
        label: Text(AppLocalizations.of(context)!.addModuleButton,
            style: BauhausDesign.getTextTheme(context)
                .labelLarge
                ?.copyWith(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : state.modules.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noModulesFound,
                    style: BauhausDesign.getTextTheme(context).bodyLarge,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: state.modules.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: BauhausDesign.space3),
                  itemBuilder: (context, index) {
                    final module = state.modules[index];
                    return _buildModuleCard(context, module);
                  },
                ),
    );
  }

  Widget _buildModuleCard(BuildContext context, TrainingModule module) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BauhausDesign.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  module.title,
                  style: BauhausDesign.getTextTheme(context).headlineLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space2,
                    vertical: BauhausDesign.space1),
                decoration: BoxDecoration(
                  color: BauhausDesign.neutral,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
                child: Text(
                  module.contentType,
                  style: BauhausDesign.getTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(module.description,
              style: BauhausDesign.getTextTheme(context).bodyMedium),
          const SizedBox(height: BauhausDesign.space2),
          Text('${module.durationMinutes} minutes',
              style: BauhausDesign.getTextTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showAddModuleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddTrainingModuleDialog(),
    );
  }
}

class AddTrainingModuleDialog extends ConsumerStatefulWidget {
  const AddTrainingModuleDialog({super.key});

  @override
  ConsumerState<AddTrainingModuleDialog> createState() =>
      _AddTrainingModuleDialogState();
}

class _AddTrainingModuleDialogState
    extends ConsumerState<AddTrainingModuleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _durationController = TextEditingController();
  final _contentUrlController = TextEditingController();
  final _contentTextController = TextEditingController();
  String _contentType = 'Video';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: BauhausDesign.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      title: Text(AppLocalizations.of(context)!.addModuleTitle,
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
                maxLines: 2,
              ),
              const SizedBox(height: BauhausDesign.space3),
              DropdownButtonFormField<String>(
                value: _contentType,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.contentTypeLabel),
                items: ['Video', 'Text', 'Link']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _contentType = v!),
              ),
              const SizedBox(height: BauhausDesign.space3),
              if (_contentType == 'Video' || _contentType == 'Link')
                TextFormField(
                  controller: _contentUrlController,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                      labelText: AppLocalizations.of(context)!.contentUrlLabel),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.of(context)!.requiredValidation
                      : null,
                ),
              if (_contentType == 'Text')
                TextFormField(
                  controller: _contentTextController,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                      labelText: AppLocalizations.of(context)!.contentLabel(
                          AppLocalizations.of(context)!.articleType)),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.of(context)!.requiredValidation
                      : null,
                  maxLines: 4,
                ),
              const SizedBox(height: BauhausDesign.space3),
              TextFormField(
                controller: _durationController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText:
                        AppLocalizations.of(context)!.durationMinutesLabel),
                validator: (v) => v?.isEmpty == true
                    ? AppLocalizations.of(context)!.requiredValidation
                    : null,
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
                'contentType': _contentType,
                'durationMinutes': int.parse(_durationController.text),
                if (_contentType == 'Video' || _contentType == 'Link')
                  'contentUrl': _contentUrlController.text,
                if (_contentType == 'Text')
                  'contentText': _contentTextController.text,
              };
              ref.read(trainingViewModelProvider.notifier).createModule(data);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
