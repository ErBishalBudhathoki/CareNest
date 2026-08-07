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
        title: Text(
          AppLocalizations.of(context)!.manageTrainingTitle,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddModuleDialog(context),
        backgroundColor: BauhausDesign.primary,
        label: Text(
          AppLocalizations.of(context)!.addModuleButton,
          style: BauhausDesign.getTextTheme(
            context,
          ).labelLarge?.copyWith(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary),
            )
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
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: BauhausDesign.neutral,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
                child: Text(
                  module.contentType,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelLarge?.copyWith(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            module.description,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            '${module.durationMinutes} minutes',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Expanded(
                child: BauhausButton(
                  text: AppLocalizations.of(context)!.editButton,
                  backgroundColor: BauhausDesign.secondary,
                  onPressed: () => _showEditModuleDialog(context, module),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: BauhausButton(
                  text: 'Progress',
                  backgroundColor: BauhausDesign.primary,
                  onPressed: () => _showProgressDialog(context, module),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: BauhausButton(
                  text: AppLocalizations.of(context)!.deleteButton,
                  backgroundColor: BauhausDesign.error,
                  onPressed: () => _confirmDeleteModule(context, module),
                ),
              ),
            ],
          ),
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

  void _showEditModuleDialog(BuildContext context, TrainingModule module) {
    showDialog(
      context: context,
      builder: (context) => EditTrainingModuleDialog(module: module),
    );
  }

  Future<void> _confirmDeleteModule(
    BuildContext context,
    TrainingModule module,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteButton),
        content: const Text('Delete this training module?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.deleteButton),
          ),
        ],
      ),
    );

    if (shouldDelete == true && module.id != null) {
      await ref
          .read(trainingViewModelProvider.notifier)
          .deleteModule(module.id!);
    }
  }

  Future<void> _showProgressDialog(
    BuildContext context,
    TrainingModule module,
  ) async {
    if (module.id == null) return;
    final repo = ref.read(trainingComplianceRepositoryProvider);
    try {
      final response = await repo.getTrainingModuleProgress(module.id!);
      final data = response['data'] as List<dynamic>? ?? [];
      final summary = response['summary'] as Map<String, dynamic>? ?? {};

      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Training Progress',
            style: BauhausDesign.getTextTheme(context).headlineLarge,
          ),
          content: SizedBox(
            width: 360,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completed: ${summary['completed'] ?? 0} / ${summary['total'] ?? data.length}',
                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                ),
                const SizedBox(height: BauhausDesign.space3),
                if (data.isEmpty)
                  Text(
                    'No progress yet.',
                    style: BauhausDesign.getTextTheme(context).bodyMedium,
                  )
                else
                  SizedBox(
                    height: 240,
                    child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final entry = Map<String, dynamic>.from(
                          data[index] as Map,
                        );
                        final user = entry['user'] as Map<String, dynamic>?;
                        final name = user == null
                            ? 'Unknown'
                            : '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'
                                  .trim();
                        final email = user?['email'] ?? '';
                        final status = entry['status'] ?? 'not_started';
                        final progress = entry['progressPercentage'] ?? 0;
                        return ListTile(
                          title: Text(name.isEmpty ? email : name),
                          subtitle: Text(email),
                          trailing: Text(
                            '${status.toString().toUpperCase()} • $progress%',
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class AddTrainingModuleDialog extends ConsumerStatefulWidget {
  const AddTrainingModuleDialog({super.key});

  @override
  ConsumerState<AddTrainingModuleDialog> createState() =>
      _AddTrainingModuleDialogState();
}

class EditTrainingModuleDialog extends ConsumerStatefulWidget {
  final TrainingModule module;

  const EditTrainingModuleDialog({super.key, required this.module});

  @override
  ConsumerState<EditTrainingModuleDialog> createState() =>
      _EditTrainingModuleDialogState();
}

class _EditTrainingModuleDialogState
    extends ConsumerState<EditTrainingModuleDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final TextEditingController _durationController;
  late final TextEditingController _contentUrlController;
  late final TextEditingController _contentTextController;
  late String _contentType;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.module.title);
    _descController = TextEditingController(text: widget.module.description);
    _durationController = TextEditingController(
      text: widget.module.durationMinutes.toString(),
    );
    _contentUrlController = TextEditingController(
      text: widget.module.contentUrl ?? '',
    );
    _contentTextController = TextEditingController(
      text: widget.module.contentText ?? '',
    );
    _contentType = widget.module.contentType;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth > 560 ? 520.0 : screenWidth - 32;
    final dropdownTextStyle =
        BauhausDesign.getTextTheme(
          context,
        ).bodyMedium?.copyWith(color: BauhausDesign.textDark) ??
        const TextStyle(color: BauhausDesign.textDark);

    return AlertDialog(
      backgroundColor: BauhausDesign.surfaceLight,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      title: Text(
        AppLocalizations.of(context)!.editButton,
        style: BauhausDesign.getTextTheme(context).headlineLarge,
      ),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.titleLabel,
                  ),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.of(context)!.requiredValidation
                      : null,
                ),
                const SizedBox(height: BauhausDesign.space3),
                TextFormField(
                  controller: _descController,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.descriptionLabel,
                  ),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.of(context)!.requiredValidation
                      : null,
                  maxLines: 2,
                ),
                const SizedBox(height: BauhausDesign.space3),
                DropdownButtonFormField<String>(
                  value: _contentType,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.contentTypeLabel,
                  ),
                  dropdownColor: BauhausDesign.surfaceLight,
                  iconEnabledColor: BauhausDesign.textDark,
                  style: dropdownTextStyle,
                  items: ['Video', 'Text', 'Link']
                      .map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child: Text(t, style: dropdownTextStyle),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _contentType = v!),
                ),
                const SizedBox(height: BauhausDesign.space3),
                if (_contentType == 'Video' || _contentType == 'Link')
                  TextFormField(
                    controller: _contentUrlController,
                    decoration: BauhausDesign.inputDecoration('').copyWith(
                      labelText: AppLocalizations.of(context)!.contentUrlLabel,
                    ),
                    validator: (v) => v?.isEmpty == true
                        ? AppLocalizations.of(context)!.requiredValidation
                        : null,
                  ),
                if (_contentType == 'Text')
                  TextFormField(
                    controller: _contentTextController,
                    decoration: BauhausDesign.inputDecoration('').copyWith(
                      labelText: AppLocalizations.of(context)!.contentLabel(
                        AppLocalizations.of(context)!.articleType,
                      ),
                    ),
                    validator: (v) => v?.isEmpty == true
                        ? AppLocalizations.of(context)!.requiredValidation
                        : null,
                    maxLines: 4,
                  ),
                const SizedBox(height: BauhausDesign.space3),
                TextFormField(
                  controller: _durationController,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(
                      context,
                    )!.durationMinutesLabel,
                  ),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.of(context)!.requiredValidation
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppLocalizations.of(context)!.cancelButton,
            style: BauhausDesign.getTextTheme(
              context,
            ).labelLarge?.copyWith(color: BauhausDesign.textDark),
          ),
        ),
        BauhausButton(
          text: AppLocalizations.of(context)!.saveProgressButton,
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
              ref
                  .read(trainingViewModelProvider.notifier)
                  .updateModule(widget.module.id!, data);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
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
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth > 560 ? 520.0 : screenWidth - 32;
    final dropdownTextStyle =
        BauhausDesign.getTextTheme(
          context,
        ).bodyMedium?.copyWith(color: BauhausDesign.textDark) ??
        const TextStyle(color: BauhausDesign.textDark);

    return AlertDialog(
      backgroundColor: BauhausDesign.surfaceLight,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      title: Text(
        AppLocalizations.of(context)!.addModuleTitle,
        style: BauhausDesign.getTextTheme(context).headlineLarge,
      ),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.titleLabel,
                  ),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.of(context)!.requiredValidation
                      : null,
                ),
                const SizedBox(height: BauhausDesign.space3),
                TextFormField(
                  controller: _descController,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.descriptionLabel,
                  ),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.of(context)!.requiredValidation
                      : null,
                  maxLines: 2,
                ),
                const SizedBox(height: BauhausDesign.space3),
                DropdownButtonFormField<String>(
                  value: _contentType,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.contentTypeLabel,
                  ),
                  dropdownColor: BauhausDesign.surfaceLight,
                  iconEnabledColor: BauhausDesign.textDark,
                  style: dropdownTextStyle,
                  items: ['Video', 'Text', 'Link']
                      .map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child: Text(t, style: dropdownTextStyle),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _contentType = v!),
                ),
                const SizedBox(height: BauhausDesign.space3),
                if (_contentType == 'Video' || _contentType == 'Link')
                  TextFormField(
                    controller: _contentUrlController,
                    decoration: BauhausDesign.inputDecoration('').copyWith(
                      labelText: AppLocalizations.of(context)!.contentUrlLabel,
                    ),
                    validator: (v) => v?.isEmpty == true
                        ? AppLocalizations.of(context)!.requiredValidation
                        : null,
                  ),
                if (_contentType == 'Text')
                  TextFormField(
                    controller: _contentTextController,
                    decoration: BauhausDesign.inputDecoration('').copyWith(
                      labelText: AppLocalizations.of(context)!.contentLabel(
                        AppLocalizations.of(context)!.articleType,
                      ),
                    ),
                    validator: (v) => v?.isEmpty == true
                        ? AppLocalizations.of(context)!.requiredValidation
                        : null,
                    maxLines: 4,
                  ),
                const SizedBox(height: BauhausDesign.space3),
                TextFormField(
                  controller: _durationController,
                  decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(
                      context,
                    )!.durationMinutesLabel,
                  ),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.of(context)!.requiredValidation
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppLocalizations.of(context)!.cancelButton,
            style: BauhausDesign.getTextTheme(
              context,
            ).labelLarge?.copyWith(color: BauhausDesign.textDark),
          ),
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
