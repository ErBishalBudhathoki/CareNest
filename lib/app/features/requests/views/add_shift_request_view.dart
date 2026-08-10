import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/features/requests/viewmodels/requests_viewmodel.dart';
import 'package:carenest/app/features/requests/viewmodels/config_viewmodel.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class AddShiftRequestView extends ConsumerStatefulWidget {
  final String email;

  const AddShiftRequestView({super.key, required this.email});

  @override
  ConsumerState<AddShiftRequestView> createState() =>
      _AddShiftRequestViewState();
}

class _AddShiftRequestViewState extends ConsumerState<AddShiftRequestView> {
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime? endDate;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  bool _showNoteField = false;
  bool _isSubmitting = false;
  String? selectedJob;

  @override
  void initState() {
    super.initState();
    endDate = selectedDate;
  }

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
                  color: BauhausDesign.success.withValues(alpha: 0.1),
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
                style: BauhausDesign.getTextTheme(
                  context,
                ).headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                AppLocalizations.of(context)!.requestSentMessage,
                textAlign: TextAlign.center,
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
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
                  text: AppLocalizations.of(context)!.imDone,
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
    if (selectedJob == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.pleaseSelectJob),
          ),
        );
      }
      return;
    }

    setState(() => _isSubmitting = true);

    final start = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startTime.hour,
      startTime.minute,
    );

    final endDateTime = endDate ?? selectedDate;
    final end = DateTime(
      endDateTime.year,
      endDateTime.month,
      endDateTime.day,
      endTime.hour,
      endTime.minute,
    );

    if (end.isBefore(start)) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.endTimeBeforeStartTime),
          ),
        );
      }
      return;
    }

    final details = {
      'job': selectedJob,
      'starts': start.toIso8601String(),
      'ends': end.toIso8601String(),
    };

    final success = await ref
        .read(requestsViewModelProvider.notifier)
        .createRequest(
          AppLocalizations.of(context)!.requestTypeShift,
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
            content: Text(AppLocalizations.of(context)!.failedToCreateRequest),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobRolesAsync = ref.watch(jobRolesProvider);

    final start = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startTime.hour,
      startTime.minute,
    );

    final endDateTime = endDate ?? selectedDate;
    var end = DateTime(
      endDateTime.year,
      endDateTime.month,
      endDateTime.day,
      endTime.hour,
      endTime.minute,
    );

    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final totalHoursStr = duration.isNegative
        ? AppLocalizations.of(context)!.invalidDuration
        : '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(BauhausDesign.radiusLg),
        ),
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
                color: BauhausDesign.neutral.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.addShift,
                style: BauhausDesign.getTextTheme(
                  context,
                ).headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              BauhausIconButton(
                icon: Icons.close,
                onPressed: () => Navigator.pop(context),
                variant: BauhausActionVariant.neutral,
                isSmall: true,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Job Section
          Text(
            AppLocalizations.of(context)!.jobLabel,
            style: BauhausDesign.getTextTheme(
              context,
            ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: BauhausDesign.space2),
          jobRolesAsync.when(
            data: (roles) {
              if (selectedJob == null && roles.isNotEmpty) {
                // Avoid setState during build, defer to next frame
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && selectedJob == null) {
                    setState(() => selectedJob = roles.first.title);
                  }
                });
              }

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                  color: BauhausDesign.surfaceWhite,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedJob,
                    isExpanded: true,
                    hint: Text(AppLocalizations.of(context)!.selectJob),
                    items: roles.map((role) {
                      return DropdownMenuItem(
                        value: role.title,
                        child: Text(
                          role.title,
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => selectedJob = val);
                    },
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) =>
                Text(AppLocalizations.of(context)!.errorLoadingRoles),
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Start Time Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.startsLabel,
                style: BauhausDesign.getTextTheme(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 30),
                        ),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
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
                          selectedDate = date;
                          if (endDate != null && endDate!.isBefore(date)) {
                            endDate = date;
                          }
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space3,
                        vertical: BauhausDesign.space2,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                        border: Border.all(
                          color: BauhausDesign.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        DateFormat('MMMM dd yyyy').format(selectedDate),
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  GestureDetector(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: startTime,
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
                      if (time != null) {
                        setState(() => startTime = time);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space3,
                        vertical: BauhausDesign.space2,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                        border: Border.all(
                          color: BauhausDesign.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        startTime.format(context),
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),

          // End Time Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.endsLabel,
                style: BauhausDesign.getTextTheme(
                  context,
                ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? selectedDate,
                        firstDate: selectedDate,
                        lastDate: DateTime.now().add(const Duration(days: 365)),
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
                        vertical: BauhausDesign.space2,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                        border: Border.all(
                          color: BauhausDesign.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        DateFormat(
                          'MMMM dd yyyy',
                        ).format(endDate ?? selectedDate),
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  GestureDetector(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: endTime,
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
                      if (time != null) {
                        setState(() => endTime = time);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space3,
                        vertical: BauhausDesign.space2,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                        border: Border.all(
                          color: BauhausDesign.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        endTime.format(context),
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Total Hours Section
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              color: BauhausDesign.neutral.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalHours,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  totalHoursStr,
                  style: BauhausDesign.getTextTheme(context).titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.primary,
                      ),
                ),
              ],
            ),
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
                icon: const Icon(
                  Icons.edit_outlined,
                  color: BauhausDesign.primary,
                ),
                label: Text(
                  AppLocalizations.of(context)!.addNote,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelLarge?.copyWith(color: BauhausDesign.primary),
                ),
              ),
            ),

          if (_showNoteField) ...[
            const SizedBox(height: BauhausDesign.space2),
            BauhausTextField(
              controller: _noteController,
              label: AppLocalizations.of(context)!.noteLabel,
              hintText: AppLocalizations.of(context)!.typeNoteHint,
              maxLines: 4,
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],

          // Info Text
          Text(
            AppLocalizations.of(context)!.requestApprovalInfo,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.textMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Bottom Buttons
          Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  text: AppLocalizations.of(context)!.cancelButton,
                  onPressed: () => Navigator.pop(context),
                  variant: BauhausActionVariant.neutral,
                  isOutlined: true,
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: BauhausActionButton(
                  text: AppLocalizations.of(context)!.sendForApproval,
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
