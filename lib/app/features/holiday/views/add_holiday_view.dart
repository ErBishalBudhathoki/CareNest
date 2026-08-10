import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddHolidayScreen extends ConsumerStatefulWidget {
  final Function(Map<String, String>) addHoliday;
  final List<dynamic> holidays;

  const AddHolidayScreen({
    super.key,
    required this.addHoliday,
    required this.holidays,
  });

  @override
  ConsumerState<AddHolidayScreen> createState() => _AddHolidayScreenState();
}

class _AddHolidayScreenState extends ConsumerState<AddHolidayScreen> {
  final TextEditingController _holidayController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    _holidayController.dispose();
    _dateController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: BauhausDesign.primary,
              onPrimary: BauhausDesign.surfaceWhite,
              surface: BauhausDesign.surfaceWhite,
              onSurface: BauhausDesign.textDark,
            ),
            dialogTheme: DialogThemeData(backgroundColor: BauhausDesign.surfaceWhite),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
        _dayController.text = DateFormat('EEEE').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: BauhausIconButton(
            icon: Icons.arrow_back_ios_new,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'Add Holiday',
          style: BauhausDesign.getTextTheme(context).headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              BauhausCard(
                padding: const EdgeInsets.all(BauhausDesign.space6),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: BauhausDesign.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusMd,
                        ),
                      ),
                      child: Icon(
                        Icons.add_circle,
                        color: BauhausDesign.secondary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Entry',
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).headlineSmall,
                          ),
                          Text(
                            'Create a new holiday entry',
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(color: BauhausDesign.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),

              const SizedBox(height: BauhausDesign.space6),

              // Form Fields
              Text(
                'Holiday Details',
                style: BauhausDesign.getTextTheme(context).labelLarge,
              ),
              const SizedBox(height: BauhausDesign.space2),
              BauhausTextField(
                controller: _holidayController,
                label: 'Holiday Name',
                hintText: 'e.g., Christmas Day',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a holiday name';
                  }
                  return null;
                },
              ).animate(delay: 100.ms).fadeIn().slideX(),

              const SizedBox(height: BauhausDesign.space4),

              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: BauhausTextField(
                    controller: _dateController,
                    label: 'Date',
                    hintText: 'Select Date',
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: BauhausDesign.textMuted,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
              ).animate(delay: 200.ms).fadeIn().slideX(),

              const SizedBox(height: BauhausDesign.space4),

              BauhausTextField(
                controller: _dayController,
                label: 'Day of Week',
                hintText: 'Auto-filled based on date',
                readOnly: true, // Auto-filled
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Day will be auto-filled';
                  }
                  return null;
                },
              ).animate(delay: 300.ms).fadeIn().slideX(),

              const SizedBox(height: BauhausDesign.space8),

              BauhausActionButton(
                onPressed: _isLoading ? null : _addHolidayItem,
                text: 'Create Holiday',
                icon: _isLoading ? null : Icons.check,
                isFullWidth: true,
                isLoading: _isLoading,
              ).animate(delay: 400.ms).scale(),
            ],
          ),
        ),
      ),
    );
  }

  void _addHolidayItem() async {
    final apiMethod = ref.read(apiMethodProvider);
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String holiday = _holidayController.text.trim();
    final String date = _dateController.text.trim();
    final String day = _dayController.text.trim();

    final Map<String, String> newHoliday = {
      'Holiday': holiday,
      'Date': date,
      'Day': day,
    };

    try {
      var ins = await apiMethod.addHolidayItem(newHoliday);

      if (ins['status'] == 'success' && mounted) {
        debugPrint("Holiday Added");

        widget.addHoliday(newHoliday);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Holiday created successfully',
                style: BauhausDesign.getTextTheme(
                  context,
                ).labelLarge?.copyWith(color: BauhausDesign.surfaceWhite),
              ),
              backgroundColor: BauhausDesign.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              ),
            ),
          );
          Navigator.pop(context);
        }
      } else {
        debugPrint("Holiday Not Added ${ins['message']}");
        throw Exception('Failed to add holiday');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to add holiday',
              style: BauhausDesign.getTextTheme(
                context,
              ).labelLarge?.copyWith(color: BauhausDesign.surfaceWhite),
            ),
            backgroundColor: BauhausDesign.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
