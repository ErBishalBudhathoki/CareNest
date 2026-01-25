import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/features/requests/viewmodels/requests_viewmodel.dart';
import 'package:carenest/app/features/requests/viewmodels/config_viewmodel.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class AddTimeOffRequestView extends ConsumerStatefulWidget {
  final String email;

  const AddTimeOffRequestView({super.key, required this.email});

  @override
  ConsumerState<AddTimeOffRequestView> createState() =>
      _AddTimeOffRequestViewState();
}

class _AddTimeOffRequestViewState extends ConsumerState<AddTimeOffRequestView> {
  final TextEditingController _noteController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String? selectedType;
  bool _showNoteField = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        child: BauhausCard(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: BauhausDesign.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                AppLocalizations.of(context)!.requestSent,
                style:
                    BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                AppLocalizations.of(context)!.requestSentMessage,
                textAlign: TextAlign.center,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              SizedBox(
                width: double.infinity,
                child: BauhausActionButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  text: "I'm done",
                  variant: BauhausActionVariant.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (selectedType == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.pleaseSelectLeaveType)),
        );
      }
      return;
    }

    if (endDate.isBefore(startDate)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.endDateBeforeStartDate)),
        );
      }
      return;
    }

    setState(() => _isSubmitting = true);

    final details = {
      'timeOffType': selectedType,
      'starts': startDate.toIso8601String(),
      'ends': endDate.toIso8601String(),
    };

    final success =
        await ref.read(requestsViewModelProvider.notifier).createRequest(
              'Time Off',
              details,
              _noteController.text,
            );

    if (mounted) setState(() => _isSubmitting = false);

    if (success) {
      if (mounted) _showSuccessDialog();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.failedToCreateRequest)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final leaveTypesAsync = ref.watch(leaveTypesProvider);

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(BauhausDesign.radiusLg)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: BauhausDesign.neutral.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.requestTypeTimeOff,
                style:
                    BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
              ),
              BauhausIconButton(
                icon: Icons.close,
                onPressed: () => Navigator.pop(context),
                variant: BauhausActionVariant.neutral,
                isSmall: true,
              )
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Type Section
          Text(
            AppLocalizations.of(context)!.leaveTypeLabel,
            style: BauhausDesign.getTextTheme(context)
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: BauhausDesign.space2),
          leaveTypesAsync.when(
            data: (types) {
              if (selectedType == null && types.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && selectedType == null) {
                    setState(() => selectedType = types.first.name);
                  }
                });
              }

              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                  color: BauhausDesign.surfaceWhite,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedType,
                    isExpanded: true,
                    hint: Text(AppLocalizations.of(context)!.selectLeaveType),
                    items: types.map((type) {
                      return DropdownMenuItem(
                        value: type.name,
                        child: Text(
                          type.name,
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => selectedType = val);
                    },
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) =>
                Text(AppLocalizations.of(context)!.errorLoadingTypes),
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Date Range Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.fromLabel,
                      style: BauhausDesign.getTextTheme(context)
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: startDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: BauhausDesign.primary,
                                  onPrimary: BauhausDesign.surfaceWhite,
                                  onSurface: BauhausDesign.textDark,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          setState(() {
                            startDate = date;
                            if (endDate.isBefore(startDate)) {
                              endDate = startDate;
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space3,
                            vertical: BauhausDesign.space2),
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(
                              color: BauhausDesign.primary.withOpacity(0.3)),
                        ),
                        child: Text(
                          DateFormat('MMMM dd yyyy').format(startDate),
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.toLabel,
                      style: BauhausDesign.getTextTheme(context)
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: endDate,
                          firstDate: startDate,
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: BauhausDesign.primary,
                                  onPrimary: BauhausDesign.surfaceWhite,
                                  onSurface: BauhausDesign.textDark,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          setState(() => endDate = date);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space3,
                            vertical: BauhausDesign.space2),
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(
                              color: BauhausDesign.primary.withOpacity(0.3)),
                        ),
                        child: Text(
                          DateFormat('MMMM dd yyyy').format(endDate),
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Add Note Section
          if (!_showNoteField)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _showNoteField = true;
                  });
                },
                icon: const Icon(Icons.edit_outlined,
                    color: BauhausDesign.primary),
                label: Text(
                  'Add a note',
                  style: BauhausDesign.getTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: BauhausDesign.primary),
                ),
              ),
            ),

          if (_showNoteField) ...[
            const SizedBox(height: BauhausDesign.space2),
            BauhausTextField(
              controller: _noteController,
              label: "Note",
              hintText: 'Type your note here...',
              maxLines: 4,
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],

          // Info Text
          Text(
            "All requests will be sent for a manager's approval",
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textMuted, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Bottom Buttons
          Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  text: "Cancel",
                  onPressed: () => Navigator.pop(context),
                  variant: BauhausActionVariant.neutral,
                  isOutlined: true,
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: BauhausActionButton(
                  text: "Send for approval",
                  onPressed: _isSubmitting ? () {} : _submit,
                  variant: BauhausActionVariant.primary,
                  isLoading: _isSubmitting,
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
        ],
      ),
    );
  }
}
