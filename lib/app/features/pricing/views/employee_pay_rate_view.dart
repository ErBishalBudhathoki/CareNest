import 'dart:math' as math;
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/pricing/viewmodels/employee_pay_rate_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/features/pricing/constants/schads_rate_constants.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class EmployeePayRateView extends ConsumerStatefulWidget {
  final String organizationId;
  final String adminEmail;

  const EmployeePayRateView({
    super.key,
    required this.organizationId,
    required this.adminEmail,
  });

  @override
  ConsumerState<EmployeePayRateView> createState() =>
      _EmployeePayRateViewState();
}

class _EmployeePayRateViewState extends ConsumerState<EmployeePayRateView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _baseRateController = TextEditingController();

  // Expanded Rate Controllers
  final TextEditingController _saturdayRateController = TextEditingController();
  final TextEditingController _sundayRateController = TextEditingController();
  final TextEditingController _publicHolidayRateController =
      TextEditingController();
  final TextEditingController _overtimeRateController =
      TextEditingController(); // First 2h
  final TextEditingController _overtimeRate2Controller =
      TextEditingController(); // After 2h
  final TextEditingController _eveningShiftRateController =
      TextEditingController(); // Afternoon Shift
  final TextEditingController _nightShiftRateController =
      TextEditingController(); // Night Shift

  String _payType = 'Hourly';
  String? _selectedLevel;
  String? _selectedPayPoint;
  String? _selectedStream;
  String? _selectedEmploymentType;
  List<String> _selectedAllowances = [];

  User? _selectedUser;
  bool _isSaving = false;
  String? _rateWarning; // To show validation warning
  void Function(VoidCallback fn)? _dialogSetState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _refreshEmployees(showLoading: true);
    });
  }

  @override
  void dispose() {
    _baseRateController.dispose();
    _saturdayRateController.dispose();
    _sundayRateController.dispose();
    _publicHolidayRateController.dispose();
    _overtimeRateController.dispose();
    _overtimeRate2Controller.dispose();
    _eveningShiftRateController.dispose();
    _nightShiftRateController.dispose();
    super.dispose();
  }

  Future<void> _refreshEmployees({bool showLoading = false}) async {
    await ref
        .read(employeePayRateViewModelProvider(widget.organizationId).notifier)
        .fetchEmployees(showLoading: showLoading);
  }

  void _updateUi(VoidCallback updates) {
    final localSetState = _dialogSetState;
    if (localSetState != null) {
      localSetState(updates);
      return;
    }
    if (!mounted) return;
    setState(updates);
  }

  void _selectUser(User user) {
    setState(() {
      _selectedUser = user;
      _baseRateController.text =
          user.payRate != 0.0 ? user.payRate.toString() : '';
      _payType = user.payType ?? 'Hourly';

      _selectedStream = _normalizeStream(user.stream);

      _selectedLevel = null;
      if (_selectedStream != null && user.classificationLevel != null) {
        final levels =
            SchadsRateConstants.levelsForStream[_selectedStream] ?? [];
        if (levels.contains(user.classificationLevel)) {
          _selectedLevel = user.classificationLevel;
        }
      }

      _selectedPayPoint = null;
      if (_selectedStream != null &&
          _selectedLevel != null &&
          user.payPoint != null) {
        final points =
            SchadsRateConstants.getPayPoints(_selectedStream!, _selectedLevel!);
        if (points.contains(user.payPoint)) {
          _selectedPayPoint = user.payPoint;
        }
      }

      _selectedEmploymentType = user.employmentType ?? 'Permanent';
      _selectedAllowances = user.activeAllowances ?? [];

      final rates = user.detailedRates;
      _saturdayRateController.text = rates?.saturdayRate.toString() ?? '';
      _sundayRateController.text = rates?.sundayRate.toString() ?? '';
      _publicHolidayRateController.text =
          rates?.publicHolidayRate.toString() ?? '';
      _overtimeRateController.text = rates?.overtimeRate.toString() ?? '';
      _overtimeRate2Controller.text = rates?.overtimeRate2.toString() ?? '';
      _eveningShiftRateController.text =
          rates?.eveningShiftRate.toString() ?? '';
      _nightShiftRateController.text = rates?.nightShiftRate.toString() ?? '';

      bool hasZeroRates = false;
      if (rates != null) {
        if ((rates.saturdayRate ?? 0) <= 0 || (rates.sundayRate ?? 0) <= 0) {
          hasZeroRates = true;
        }
      }

      if ((rates == null || hasZeroRates) && user.payRate > 0) {
        debugPrint('Detailed rates missing or zero, auto-calculating...');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _calculateSchadsRates();
        });
      }
    });
    _showEditDialog();
  }

  String? _normalizeStream(String? stream) {
    if (stream == null) return null;
    final trimmed = stream.trim();
    if (trimmed.isEmpty) return null;
    final lower = trimmed.toLowerCase();
    for (final option in SchadsRateConstants.streams) {
      if (option.toLowerCase() == lower) return option;
    }
    return trimmed;
  }

  // Auto-fill logic based on SCHADS multipliers
  void _calculateSchadsRates() {
    debugPrint('Calculating SCHADS rates...');
    final baseText = _baseRateController.text;
    if (baseText.isEmpty) {
      debugPrint('Base rate empty, skipping calculation');
      return;
    }

    final base = double.tryParse(baseText);
    if (base == null) {
      debugPrint('Invalid base rate format: $baseText');
      return;
    }

    final isCasual = _selectedEmploymentType == 'Casual';
    debugPrint('Base: $base, Casual: $isCasual');

    // Standard SCHADS multipliers (Permanent):
    // Saturday: 150% (1.5x)
    // Sunday: 200% (2.0x)
    // Public Holiday: 250% (2.5x)
    // Overtime (First 2h): 150% (1.5x)
    // Overtime (After 2h): 200% (2.0x)
    // Afternoon Shift (Evening): 112.5% (1.125x)
    // Night Shift: 115% (1.15x)

    double satMult = 1.5;
    double sunMult = 2.0;
    double phMult = 2.5;
    double ot1Mult = 1.5;
    double ot2Mult = 2.0;
    double eveningMult = 1.125;
    double nightMult = 1.15;

    if (isCasual) {
      // Casual Base = Perm Base * 1.25
      // Casual Sat = Perm Base * 1.75 = (Casual Base / 1.25) * 1.75 = 1.4 * Casual Base
      // Casual Sun = Perm Base * 2.25 = (Casual Base / 1.25) * 2.25 = 1.8 * Casual Base
      // Casual PH = Perm Base * 2.75 = (Casual Base / 1.25) * 2.75 = 2.2 * Casual Base
      // Casual Afternoon = Perm Base * (1 + 0.25 + 0.125) = Perm Base * 1.375 = (Casual Base / 1.25) * 1.375 = 1.1 * Casual Base
      // Casual Night = Perm Base * (1 + 0.25 + 0.15) = Perm Base * 1.4 = (Casual Base / 1.25) * 1.4 = 1.12 * Casual Base
      // Casual OT: Often same as Sat (1.75 of Perm) -> 1.4 * Casual Base

      satMult = 1.75 / 1.25; // 1.4
      sunMult = 2.25 / 1.25; // 1.8
      phMult = 2.75 / 1.25; // 2.2

      eveningMult = 1.375 / 1.25; // 1.1
      nightMult = 1.40 / 1.25; // 1.12

      ot1Mult = 1.75 / 1.25; // 1.4
      ot2Mult = 2.25 / 1.25; // 1.8 (After 2h is 225% of Perm)
    }

    _saturdayRateController.text = (base * satMult).toStringAsFixed(2);
    _sundayRateController.text = (base * sunMult).toStringAsFixed(2);
    _publicHolidayRateController.text = (base * phMult).toStringAsFixed(2);
    _overtimeRateController.text = (base * ot1Mult).toStringAsFixed(2);
    _overtimeRate2Controller.text = (base * ot2Mult).toStringAsFixed(2);
    _eveningShiftRateController.text = (base * eveningMult).toStringAsFixed(2);
    _nightShiftRateController.text = (base * nightMult).toStringAsFixed(2);

    debugPrint(
        'Rates calculated: Sat=${_saturdayRateController.text}, Sun=${_sundayRateController.text}');
  }

  Future<void> _saveRate() async {
    if (!_formKey.currentState!.validate()) return;

    final baseRate = double.tryParse(_baseRateController.text);
    if (baseRate == null) return;

    setState(() => _isSaving = true);
    // Use rootNavigator: true because showDialog defaults to root navigator
    // This ensures we pop the dialog, not the screen behind it if nested navigators are involved
    Navigator.of(context, rootNavigator: true).pop();

    try {
      final repository = ref.read(earningsRepositoryProvider);

      final rates = RatesModel(
          baseRate: baseRate,
          saturdayRate: double.tryParse(_saturdayRateController.text) ?? 0,
          sundayRate: double.tryParse(_sundayRateController.text) ?? 0,
          publicHolidayRate:
              double.tryParse(_publicHolidayRateController.text) ?? 0,
          overtimeRate: double.tryParse(_overtimeRateController.text) ?? 0,
          overtimeRate2: double.tryParse(_overtimeRate2Controller.text) ?? 0,
          nightShiftRate: double.tryParse(_nightShiftRateController.text) ?? 0,
          eveningShiftRate:
              double.tryParse(_eveningShiftRateController.text) ?? 0);

      await repository.setPayRate(
          _selectedUser!.email,
          baseRate,
          _payType,
          rates,
          _selectedLevel,
          _selectedPayPoint,
          _selectedStream,
          _selectedEmploymentType,
          _selectedAllowances,
          widget.organizationId,
          widget.adminEmail);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.payRatesUpdatedSuccess)),
        );
      }

      await _refreshEmployees(showLoading: false);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .errorUpdatingRate(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _updateRateFromClassification() {
    if (_selectedStream != null &&
        _selectedLevel != null &&
        _selectedPayPoint != null) {
      final key = '$_selectedStream - $_selectedLevel - $_selectedPayPoint';
      final rate = SchadsRateConstants.rates[key];
      if (rate != null) {
        double finalRate = rate;
        if (_selectedEmploymentType == 'Casual') {
          finalRate = rate * 1.25;
        }

        _updateUi(() {
          _baseRateController.text = finalRate.toStringAsFixed(2);
          _rateWarning = null;
        });
        _calculateSchadsRates();
      }
    }

    // Ensure we always recalculate if employment type changes, even if we didn't find a base rate
    // This fixes the issue where changing to "Casual" didn't update penalties if classification was incomplete
    _calculateSchadsRates();
  }

  void _validateBaseRate() {
    if (_selectedStream != null &&
        _selectedLevel != null &&
        _selectedPayPoint != null) {
      final key = '$_selectedStream - $_selectedLevel - $_selectedPayPoint';
      final awardRate = SchadsRateConstants.rates[key];
      if (awardRate != null) {
        final current = double.tryParse(_baseRateController.text) ?? 0;
        double minRate = awardRate;
        if (_selectedEmploymentType == 'Casual') {
          minRate = awardRate * 1.25;
        }

        if (current < minRate) {
          _updateUi(() {
            _rateWarning = AppLocalizations.of(context)!
                .rateBelowAwardWarning(minRate.toStringAsFixed(2));
          });
        } else {
          _updateUi(() {
            _rateWarning = null;
          });
        }
      }
    }
  }

  void _showEditDialog() {
    if (_selectedUser == null) return;

    showDialog(
      context: context,
      builder: (dialogContext) {
        final size = MediaQuery.of(dialogContext).size;
        return StatefulBuilder(
          builder: (dialogContext, dialogSetState) {
            _dialogSetState = dialogSetState;
            return Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              backgroundColor: Colors.transparent,
              child: Container(
                width: math.min(size.width * 0.95, 960),
                height: math.min(size.height * 0.95, 840),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceLight,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  boxShadow: const [
                    BoxShadow(
                        color: BauhausDesign.neutral, offset: Offset(4, 4))
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildPayRateDialogHeader(dialogContext),
                    const SizedBox(height: 16),
                    Expanded(child: _buildPayRateForm(dialogContext)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          child: Text(
                            AppLocalizations.of(dialogContext)!
                                .cancelAction
                                .toUpperCase(),
                            style: GoogleFonts.oswald(
                                color: BauhausDesign.neutral),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BauhausDesign.secondary,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          onPressed: _saveRate,
                          child: Text(
                            AppLocalizations.of(dialogContext)!
                                .saveRatesAction
                                .toUpperCase(),
                            style: GoogleFonts.oswald(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      _dialogSetState = null;
    });
  }

  Widget _buildPayRateDialogHeader(BuildContext dialogContext) {
    final l10n = AppLocalizations.of(dialogContext)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            l10n.setPayRatesTitle(_selectedUser!.name.toUpperCase()),
            style: GoogleFonts.oswald(
                color: BauhausDesign.textDark,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(dialogContext).pop(),
          tooltip: l10n.cancelAction,
        )
      ],
    );
  }

  Widget _buildPayRateForm(BuildContext dialogContext) {
    final l10n = AppLocalizations.of(dialogContext)!;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
                l10n.classificationEmploymentSection.toUpperCase()),
            DropdownButtonFormField<String>(
              value: _selectedStream,
              decoration: InputDecoration(
                labelText: l10n.streamLabel,
                border:
                    const OutlineInputBorder(borderRadius: BorderRadius.zero),
                filled: true,
                fillColor: BauhausDesign.surfaceLight,
              ),
              isExpanded: true,
              items: SchadsRateConstants.streams.map((s) {
                return DropdownMenuItem(
                  value: s,
                  child: Text(s,
                      style: GoogleFonts.inter(color: BauhausDesign.textDark)),
                );
              }).toList(),
              onChanged: (val) {
                _updateUi(() {
                  _selectedStream = _normalizeStream(val);
                  _selectedLevel = null;
                  _selectedPayPoint = null;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedEmploymentType,
              decoration: InputDecoration(
                labelText: l10n.employmentTypeLabel,
                border:
                    const OutlineInputBorder(borderRadius: BorderRadius.zero),
                filled: true,
                fillColor: BauhausDesign.surfaceLight,
              ),
              items: SchadsRateConstants.employmentTypes.map((t) {
                return DropdownMenuItem(
                  value: t,
                  child: Text(t,
                      style: GoogleFonts.inter(color: BauhausDesign.textDark)),
                );
              }).toList(),
              onChanged: (val) {
                _updateUi(() {
                  _selectedEmploymentType = val;
                });
                _updateRateFromClassification();
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedLevel,
                    decoration: InputDecoration(
                      helperText: _selectedStream == null
                          ? l10n.selectStreamFirstHint
                          : null,
                      labelText: l10n.levelLabel,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero),
                      filled: true,
                      fillColor: BauhausDesign.surfaceLight,
                    ),
                    isExpanded: true,
                    items: _selectedStream == null
                        ? []
                        : (SchadsRateConstants
                                    .levelsForStream[_selectedStream!] ??
                                [])
                            .map((level) {
                            return DropdownMenuItem(
                              value: level,
                              child: Text(level,
                                  style: GoogleFonts.inter(
                                      color: BauhausDesign.textDark),
                                  overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                    onChanged: _selectedStream == null
                        ? null
                        : (val) {
                            _updateUi(() {
                              _selectedLevel = val;
                              _selectedPayPoint = null;
                              _rateWarning = null;
                            });
                          },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedPayPoint,
                    decoration: InputDecoration(
                      helperText:
                          (_selectedStream == null || _selectedLevel == null)
                              ? l10n.selectLevelFirstHint
                              : null,
                      labelText: l10n.payPointLabel,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero),
                      filled: true,
                      fillColor: BauhausDesign.surfaceLight,
                    ),
                    isExpanded: true,
                    items: (_selectedStream == null || _selectedLevel == null)
                        ? []
                        : SchadsRateConstants.getPayPoints(
                                _selectedStream!, _selectedLevel!)
                            .map((pp) {
                            return DropdownMenuItem(
                              value: pp,
                              child: Text(pp,
                                  style: GoogleFonts.inter(
                                      color: BauhausDesign.textDark),
                                  overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                    onChanged:
                        (_selectedStream == null || _selectedLevel == null)
                            ? null
                            : (val) {
                                _updateUi(() {
                                  _selectedPayPoint = val;
                                });
                                _updateRateFromClassification();
                              },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_rateWarning != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red.withOpacity(0.1),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(_rateWarning!,
                              style: GoogleFonts.inter(
                                  color: Colors.red, fontSize: 12))),
                    ],
                  ),
                ),
              ),
            _buildSectionTitle(l10n.baseRateSection.toUpperCase()),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    controller: _baseRateController,
                    label: l10n.baseRateHourlyLabel,
                    onChanged: (_) => _calculateSchadsRates(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: _payType,
                    decoration: InputDecoration(
                      labelText: l10n.payTypeLabel,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero),
                      filled: true,
                      fillColor: BauhausDesign.surfaceLight,
                    ),
                    style: GoogleFonts.inter(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w500),
                    dropdownColor: BauhausDesign.surfaceLight,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                          value: 'Hourly',
                          child: Text(
                            l10n.hourlyLabel,
                            style: GoogleFonts.inter(
                                color: BauhausDesign.textDark),
                            overflow: TextOverflow.ellipsis,
                          )),
                      DropdownMenuItem(
                          value: 'Salary',
                          child: Text(
                            l10n.salaryLabel,
                            style: GoogleFonts.inter(
                                color: BauhausDesign.textDark),
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                    onChanged: (val) => _updateUi(() => _payType = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionTitle(l10n.penaltyRatesSection.toUpperCase()),
            Row(
              children: [
                Expanded(
                    child: _buildTextField(
                        controller: _saturdayRateController,
                        label: l10n.saturdayPenaltyLabel)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildTextField(
                        controller: _sundayRateController,
                        label: l10n.sundayPenaltyLabel)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildTextField(
                        controller: _publicHolidayRateController,
                        label: l10n.publicHolidayPenaltyLabel)),
                const SizedBox(width: 16),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildTextField(
                        controller: _eveningShiftRateController,
                        label: l10n.eveningShiftLabel)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildTextField(
                        controller: _nightShiftRateController,
                        label: l10n.nightShiftLabel)),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionTitle(l10n.overtimeSection.toUpperCase()),
            Row(
              children: [
                Expanded(
                    child: _buildTextField(
                        controller: _overtimeRateController,
                        label: l10n.overtimeFirst2hLabel)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildTextField(
                        controller: _overtimeRate2Controller,
                        label: l10n.overtimeAfter2hLabel)),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionTitle(l10n.allowancesSection.toUpperCase()),
            ...SchadsRateConstants.allowances.keys.map((allowance) {
              final isSelected = _selectedAllowances.contains(allowance);
              final rate = SchadsRateConstants.allowances[allowance];
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(allowance,
                    style: GoogleFonts.inter(
                        color: BauhausDesign.textDark, fontSize: 14)),
                subtitle: Text('\$${rate?.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                        color: BauhausDesign.neutral, fontSize: 12)),
                value: isSelected,
                activeColor: BauhausDesign.primary,
                onChanged: (val) {
                  _updateUi(() {
                    if (val == true) {
                      _selectedAllowances.add(allowance);
                    } else {
                      _selectedAllowances.remove(allowance);
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title,
          style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: BauhausDesign.neutral)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.inter(
        color: BauhausDesign.textDark,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          color: BauhausDesign.neutral,
          fontSize: 12, // Reduced size
        ),
        // Removed prefixText to save space, or keep it minimal
        // prefixText: '\$ ',
        border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: BauhausDesign.neutral),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: BauhausDesign.primary, width: 2),
        ),
        filled: true,
        fillColor: BauhausDesign.surfaceLight,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true, // Make field more compact
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.isEmpty)
          return AppLocalizations.of(context)!.requiredField;
        if (double.tryParse(value) == null)
          return AppLocalizations.of(context)!.invalidValue;
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch provider
    final employeeState =
        ref.watch(employeePayRateViewModelProvider(widget.organizationId));

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: employeeState.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: BauhausDesign.primary))
                  : employeeState.error != null
                      ? Center(child: Text('Error: ${employeeState.error}'))
                      : RefreshIndicator(
                          onRefresh: () =>
                              _refreshEmployees(showLoading: false),
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(BauhausDesign.space4),
                            itemCount: employeeState.employees.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: BauhausDesign.space4),
                            itemBuilder: (context, index) {
                              final user = employeeState.employees[index];
                              return _EmployeeCard(
                                user: user,
                                onTap: () => _selectUser(user),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: BauhausDesign.surfaceLight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Text(
                  AppLocalizations.of(context)!
                      .employeePayRatesTitle
                      .toUpperCase(),
                  style: GoogleFonts.oswald(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 4, color: BauhausDesign.neutral),
        ],
      ),
    );
  }
}

class _EmployeeCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const _EmployeeCard({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [
            BoxShadow(color: BauhausDesign.neutral, offset: Offset(4, 4))
          ],
        ),
        child: Row(
          children: [
            ProfileImageWidget(
              imageUrl: user.profilePic,
              size: 50,
              fallbackAsset: 'assets/icons/profile_placeholder.png',
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(0),
              borderWidth: 2,
              borderColor: BauhausDesign.neutral,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name.toUpperCase(),
                    style: GoogleFonts.oswald(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textDark),
                  ),
                  Text(
                    user.email,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: BauhausDesign.neutral),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  user.payRate != 0.0
                      ? '\$${user.payRate.toStringAsFixed(2)}'
                      : AppLocalizations.of(context)!.notSetLabel.toUpperCase(),
                  style: GoogleFonts.oswald(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: user.payRate != 0.0
                          ? BauhausDesign.success
                          : BauhausDesign.neutral),
                ),
                Text(
                  user.payType == 'Salary'
                      ? AppLocalizations.of(context)!
                          .perAnnumLabel
                          .toUpperCase()
                      : AppLocalizations.of(context)!
                          .perHourLabel
                          .toUpperCase(),
                  style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.textDark),
                ),
              ],
            ),
            const SizedBox(width: 16),
            const Icon(Icons.edit, color: BauhausDesign.primary),
          ],
        ),
      ),
    );
  }
}
