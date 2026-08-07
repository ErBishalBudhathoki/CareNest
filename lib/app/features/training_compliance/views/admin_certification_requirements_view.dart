import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:carenest/app/features/training_compliance/models/certification_requirement.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class AdminCertificationRequirementsView extends ConsumerStatefulWidget {
  const AdminCertificationRequirementsView({super.key});

  @override
  ConsumerState<AdminCertificationRequirementsView> createState() =>
      _AdminCertificationRequirementsViewState();
}

class _AdminCertificationRequirementsViewState
    extends ConsumerState<AdminCertificationRequirementsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(certificationRequirementsViewModelProvider.notifier)
          .loadRequirements(includeInactive: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(certificationRequirementsViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Certification Requirements',
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
        onPressed: () => _showEditDialog(context),
        backgroundColor: BauhausDesign.primary,
        label: Text(
          AppLocalizations.of(context)!.addButton,
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
          : state.requirements.isEmpty
          ? Center(
              child: Text(
                'No requirements found.',
                style: BauhausDesign.getTextTheme(context).bodyLarge,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              itemCount: state.requirements.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: BauhausDesign.space3),
              itemBuilder: (context, index) {
                final requirement = state.requirements[index];
                return _buildRequirementCard(context, requirement);
              },
            ),
    );
  }

  Widget _buildRequirementCard(
    BuildContext context,
    CertificationRequirement requirement,
  ) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BauhausDesign.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  requirement.name,
                  style: BauhausDesign.getTextTheme(context).headlineLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: requirement.isActive
                      ? BauhausDesign.success
                      : BauhausDesign.neutral,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
                child: Text(
                  requirement.isActive ? 'ACTIVE' : 'INACTIVE',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelLarge?.copyWith(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          if (requirement.description.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space2),
            Text(
              requirement.description,
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            ),
          ],
          const SizedBox(height: BauhausDesign.space2),
          Text(
            requirement.isRequired ? 'Required' : 'Optional',
            style: BauhausDesign.getTextTheme(
              context,
            ).labelLarge?.copyWith(color: BauhausDesign.textMuted),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Expanded(
                child: BauhausButton(
                  text: AppLocalizations.of(context)!.editButton,
                  backgroundColor: BauhausDesign.secondary,
                  onPressed: () => _showEditDialog(context, requirement),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: BauhausButton(
                  text: AppLocalizations.of(context)!.deleteButton,
                  backgroundColor: BauhausDesign.error,
                  onPressed: () => _confirmDelete(context, requirement),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
    BuildContext context, [
    CertificationRequirement? requirement,
  ]) {
    showDialog(
      context: context,
      builder: (context) => _RequirementDialog(requirement: requirement),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    CertificationRequirement requirement,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteButton),
        content: const Text('Delete this requirement?'),
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

    if (shouldDelete == true && requirement.id.isNotEmpty) {
      await ref
          .read(certificationRequirementsViewModelProvider.notifier)
          .deleteRequirement(requirement.id);
    }
  }
}

class _RequirementDialog extends ConsumerStatefulWidget {
  final CertificationRequirement? requirement;

  const _RequirementDialog({this.requirement});

  @override
  ConsumerState<_RequirementDialog> createState() => _RequirementDialogState();
}

class _RequirementDialogState extends ConsumerState<_RequirementDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  bool _isRequired = true;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.requirement?.name ?? '',
    );
    _descController = TextEditingController(
      text: widget.requirement?.description ?? '',
    );
    _isRequired = widget.requirement?.isRequired ?? true;
    _isActive = widget.requirement?.isActive ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.requirement != null;
    return AlertDialog(
      backgroundColor: BauhausDesign.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      title: Text(
        isEdit ? 'Edit Requirement' : 'Add Requirement',
        style: BauhausDesign.getTextTheme(context).headlineLarge,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: BauhausDesign.inputDecoration(
                  '',
                ).copyWith(labelText: AppLocalizations.of(context)!.titleLabel),
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
                maxLines: 2,
              ),
              const SizedBox(height: BauhausDesign.space3),
              _BauhausSwitchRow(
                label: 'Required',
                value: _isRequired,
                onChanged: (val) => setState(() => _isRequired = val),
                variant: BauhausSwitchVariant.primary,
              ),
              const SizedBox(height: BauhausDesign.space2),
              _BauhausSwitchRow(
                label: 'Active',
                value: _isActive,
                onChanged: (val) => setState(() => _isActive = val),
                variant: BauhausSwitchVariant.secondary,
              ),
            ],
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
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            final data = {
              'name': _nameController.text,
              'description': _descController.text,
              'isRequired': _isRequired,
              'isActive': _isActive,
            };
            final vm = ref.read(
              certificationRequirementsViewModelProvider.notifier,
            );
            if (isEdit && widget.requirement != null) {
              await vm.updateRequirement(widget.requirement!.id, data);
            } else {
              await vm.createRequirement(data);
            }
            if (mounted) Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _BauhausSwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final BauhausSwitchVariant variant;

  const _BauhausSwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: BauhausDesign.getTextTheme(
              context,
            ).labelLarge?.copyWith(color: BauhausDesign.textDark),
          ),
        ),
        BauhausSwitch(value: value, onChanged: onChanged, variant: variant),
      ],
    );
  }
}
