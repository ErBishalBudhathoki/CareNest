import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/pricing/viewmodels/employee_pay_rate_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/features/pricing/constants/schads_rate_constants.dart';

class EmployeePayRateView extends ConsumerStatefulWidget {
  final String organizationId;
  final String adminEmail;

  const EmployeePayRateView({
    super.key,
    required this.organizationId,
    required this.adminEmail,
  });

  @override
  ConsumerState<EmployeePayRateView> createState() => _EmployeePayRateViewState();
}

class _EmployeePayRateViewState extends ConsumerState<EmployeePayRateView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _baseRateController = TextEditingController();
  
  // Expanded Rate Controllers
  final TextEditingController _saturdayRateController = TextEditingController();
  final TextEditingController _sundayRateController = TextEditingController();
  final TextEditingController _publicHolidayRateController = TextEditingController();
  final TextEditingController _overtimeRateController = TextEditingController(); // First 2h
  final TextEditingController _overtimeRate2Controller = TextEditingController(); // After 2h
  
  String _payType = 'Hourly';
  String? _selectedLevel;
  String? _selectedPayPoint;
  String? _selectedStream;
  String? _selectedEmploymentType;
  List<String> _selectedAllowances = [];

  User? _selectedUser;
  bool _isSaving = false;
  String? _rateWarning; // To show validation warning

  @override
  void dispose() {
    _baseRateController.dispose();
    _saturdayRateController.dispose();
    _sundayRateController.dispose();
    _publicHolidayRateController.dispose();
    _overtimeRateController.dispose();
    _overtimeRate2Controller.dispose();
    super.dispose();
  }

  void _selectUser(User user) {
    setState(() {
      _selectedUser = user;
      _baseRateController.text = user.payRate.toString();
      _payType = user.payType ?? 'Hourly';
      
      // Validate and set Stream
      if (user.stream != null && SchadsRateConstants.streams.contains(user.stream)) {
        _selectedStream = user.stream;
      } else {
        _selectedStream = null;
      }

      // Validate and set Level
      _selectedLevel = null;
      if (_selectedStream != null && user.classificationLevel != null) {
         final levels = SchadsRateConstants.levelsForStream[_selectedStream] ?? [];
         if (levels.contains(user.classificationLevel)) {
             _selectedLevel = user.classificationLevel;
         }
      }

      // Validate and set Pay Point
      _selectedPayPoint = null;
      if (_selectedStream != null && _selectedLevel != null && user.payPoint != null) {
          final points = SchadsRateConstants.getPayPoints(_selectedStream!, _selectedLevel!);
          if (points.contains(user.payPoint)) {
              _selectedPayPoint = user.payPoint;
          }
      }

      _selectedEmploymentType = user.employmentType ?? 'Permanent';
      _selectedAllowances = user.activeAllowances ?? [];
      
      // Load detailed rates if available, otherwise 0
      final rates = user.detailedRates;
      _saturdayRateController.text = rates?.saturdayRate.toString() ?? '';
      _sundayRateController.text = rates?.sundayRate.toString() ?? '';
      _publicHolidayRateController.text = rates?.publicHolidayRate.toString() ?? '';
      _overtimeRateController.text = rates?.overtimeRate.toString() ?? '';
      _overtimeRate2Controller.text = rates?.overtimeRate2.toString() ?? '';
    });
    _showEditDialog();
  }

  // Auto-fill logic based on SCHADS multipliers
  void _calculateSchadsRates() {
      final base = double.tryParse(_baseRateController.text);
      if (base == null) return;
      
      final isCasual = _selectedEmploymentType == 'Casual';
      
      // Standard SCHADS multipliers:
      // Saturday: 150% (1.5x)
      // Sunday: 200% (2.0x)
      // Public Holiday: Permanent 250% (2.5x), Casual 275% (2.75x)
      // Overtime (First 2h): 150% (1.5x)
      // Overtime (After 2h): 200% (2.0x)
      
      // If casual, base rate already includes 25% loading. 
      // Multipliers apply to the loaded rate usually, BUT for Casuals, penalties often replace loading or apply to base.
      // User Requirement: "Penalty totals must equal base × the Award multiplier"
      // "Casual public holiday 275%" -> This usually means 275% of the PERMANENT base, or 220% of CASUAL base?
      // Wait, User said: "Casual base = award minimum × 1.25".
      // "Public holiday 250% for permanent; casual public holiday 275%."
      // If Casual Base = 1.25 * PermBase.
      // Casual PH = 2.75 * PermBase.
      // So Casual PH = (2.75 / 1.25) * CasualBase = 2.2 * CasualBase.
      // HOWEVER, typically systems calculate from the displayed "Base Rate".
      // If the displayed Base Rate is the Casual Rate (loaded), we need to be careful.
      // Let's assume the user enters/sees the CASUAL rate.
      
      double satMult = 1.5;
      double sunMult = 2.0;
      double phMult = 2.5;
      double ot1Mult = 1.5;
      double ot2Mult = 2.0;
      
      if (isCasual) {
          // If we are operating on the Casual Base Rate (which is 125% of Perm):
          // We want the final result to be X% of Perm Base.
          // Sat: 150% of Perm Base = (1.5 / 1.25) * Casual Base = 1.2 * Casual Base?
          // NO, usually Casuals get 150% (inclusive of loading) or 175%? 
          // Pay Guide says: Casual Sat = 150%? No, let's look at table.
          // SACS Level 1 PP 1 Perm: $26.30. Sat: $39.45 (150%).
          // SACS Level 1 PP 1 Casual: $32.88 (125%). Sat: $46.03.
          // $46.03 / $26.30 = 1.75 (175%).
          // $46.03 / $32.88 = 1.4.
          
          // Let's stick to the User's instruction: "Penalty totals must equal base × the Award multiplier".
          // But which base?
          // "Casual base = award minimum × 1.25".
          // "Saturday 150%...". 
          // If I use the Casual Base as the input 'base', I need to know the multiplier relative to THAT.
          
          // Let's simplify: 
          // We have a "Reference Base Rate" (Permanent).
          // If Casual, displayed Base is Ref * 1.25.
          // Sat = Ref * 1.5 (Perm) or Ref * 1.75 (Casual)?
          // User said: "Saturday 150%... Your current Saturday/Sunday numbers are consistent".
          // Current logic was base * 1.5.
          // Let's assume the user wants standard multipliers applied to the *entered* rate, 
          // BUT for Casuals, the multipliers might be different.
          
          // Actually, let's look at the Pay Guide again.
          // Casual Sat is $46.03 (175% of Perm Base).
          // Casual Sun is $59.18 (225% of Perm Base).
          // Casual PH is $72.33 (275% of Perm Base).
          
          // So if we have the Casual Base ($32.88), we need:
          // Sat: $46.03 / $32.88 = 1.4
          // Sun: $59.18 / $32.88 = 1.8
          // PH: $72.33 / $32.88 = 2.2
          
          // This is getting complicated to hardcode multipliers if we don't know the exact base.
          // BUT, if we use the Award Logic:
          // 1. Get the relevant Award Permanent Base for the selected level.
          // 2. Calculate everything from that.
          
          // If the user manually overrides the base, we preserve the ratio?
          // Or do we just apply the standard "150%" to whatever base is there?
          // The user said: "Validation model... Penalty totals must equal base × the Award multiplier".
          // This implies strict multipliers.
          
          // Let's try to infer the Permanent Base.
          // If Casual, PermBase = Base / 1.25.
          // Sat = PermBase * 1.75
          // Sun = PermBase * 2.25
          // PH = PermBase * 2.75
          
          // Let's use this logic if it's Casual.
          
          satMult = 1.75 / 1.25; // 1.4
          sunMult = 2.25 / 1.25; // 1.8
          phMult = 2.75 / 1.25;  // 2.2
          
          // Overtime for Casuals?
          // Table 1 Casual: OT First 2h: $46.03 (175% of Perm, 140% of Casual).
          // Usually Casuals don't get OT on top of loading, or they do?
          // Pay Guide: Casual OT First 2h: $46.03. Same as Saturday.
          ot1Mult = 1.75 / 1.25;
          ot2Mult = 2.25 / 1.25; // Check Table: After 2h $59.18 (same as Sunday). Yes.
      }
      
      _saturdayRateController.text = (base * satMult).toStringAsFixed(2);
      _sundayRateController.text = (base * sunMult).toStringAsFixed(2);
      _publicHolidayRateController.text = (base * phMult).toStringAsFixed(2);
      _overtimeRateController.text = (base * ot1Mult).toStringAsFixed(2);
      _overtimeRate2Controller.text = (base * ot2Mult).toStringAsFixed(2);
  }

  Future<void> _saveRate() async {
    if (!_formKey.currentState!.validate()) return;

    final baseRate = double.tryParse(_baseRateController.text);
    if (baseRate == null) return;

    setState(() => _isSaving = true);
    Navigator.pop(context);

    try {
      final repository = ref.read(earningsRepositoryProvider);
      
      final rates = RatesModel(
          baseRate: baseRate,
          saturdayRate: double.tryParse(_saturdayRateController.text) ?? 0,
          sundayRate: double.tryParse(_sundayRateController.text) ?? 0,
          publicHolidayRate: double.tryParse(_publicHolidayRateController.text) ?? 0,
          overtimeRate: double.tryParse(_overtimeRateController.text) ?? 0,
          overtimeRate2: double.tryParse(_overtimeRate2Controller.text) ?? 0,
          nightShiftRate: 0, 
          eveningShiftRate: 0
      );
      
      await repository.setPayRate(
        _selectedUser!.email, 
        baseRate, 
        _payType, 
        rates,
        _selectedLevel,
        _selectedPayPoint,
        _selectedStream,
        _selectedEmploymentType,
        _selectedAllowances
      );

      if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pay rates updated successfully')),
          );
      }
      
      // Force refresh the list
      ref.invalidate(employeePayRateViewModelProvider(widget.organizationId));
      
    } catch (e) {
      if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating rate: $e')),
          );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _updateRateFromClassification() {
    if (_selectedStream != null && _selectedLevel != null && _selectedPayPoint != null) {
      final key = '$_selectedStream - $_selectedLevel - $_selectedPayPoint';
      final rate = SchadsRateConstants.rates[key];
      if (rate != null) {
        double finalRate = rate;
        if (_selectedEmploymentType == 'Casual') {
          finalRate = rate * 1.25;
        }
        
        setState(() {
          _baseRateController.text = finalRate.toStringAsFixed(2);
          _rateWarning = null;
        });
        _calculateSchadsRates();
      }
    }
  }
  
  void _validateBaseRate() {
      if (_selectedStream != null && _selectedLevel != null && _selectedPayPoint != null) {
          final key = '$_selectedStream - $_selectedLevel - $_selectedPayPoint';
          final awardRate = SchadsRateConstants.rates[key];
          if (awardRate != null) {
              final current = double.tryParse(_baseRateController.text) ?? 0;
              double minRate = awardRate;
              if (_selectedEmploymentType == 'Casual') {
                  minRate = awardRate * 1.25;
              }
              
              if (current < minRate) {
                  setState(() {
                      _rateWarning = 'Rate is below Award minimum (\$${minRate.toStringAsFixed(2)})';
                  });
              } else {
                  setState(() {
                      _rateWarning = null;
                  });
              }
          }
      }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: BauhausDesign.surfaceLight,
        titlePadding: EdgeInsets.zero,
        title: Container(
            padding: const EdgeInsets.all(16),
            color: BauhausDesign.primary,
            child: Text(
                'SET PAY RATES: ${_selectedUser!.name.toUpperCase()}',
                style: GoogleFonts.oswald(color: Colors.white, fontSize: 20),
            ),
        ),
        content: SizedBox(
          width: 500,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('CLASSIFICATION & EMPLOYMENT'),
                  // Stream Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedStream,
                    decoration: const InputDecoration(
                      labelText: 'Stream',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                      filled: true,
                      fillColor: BauhausDesign.surfaceLight,
                    ),
                    isExpanded: true,
                    items: SchadsRateConstants.streams.map((s) {
                      return DropdownMenuItem(
                        value: s,
                        child: Text(s, style: GoogleFonts.inter(color: BauhausDesign.textDark)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setDialogState(() {
                        _selectedStream = val;
                        _selectedLevel = null;
                        _selectedPayPoint = null;
                      });
                      setState(() {}); // Sync parent state
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Employment Type Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedEmploymentType,
                    decoration: const InputDecoration(
                      labelText: 'Employment Type',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                      filled: true,
                      fillColor: BauhausDesign.surfaceLight,
                    ),
                    items: SchadsRateConstants.employmentTypes.map((t) {
                      return DropdownMenuItem(
                        value: t,
                        child: Text(t, style: GoogleFonts.inter(color: BauhausDesign.textDark)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setDialogState(() {
                        _selectedEmploymentType = val;
                      });
                      setState(() {}); // Sync parent state
                      _updateRateFromClassification();
                    },
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedLevel,
                          decoration: const InputDecoration(
                            labelText: 'Level',
                            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                            filled: true,
                            fillColor: BauhausDesign.surfaceLight,
                          ),
                          isExpanded: true,
                          items: _selectedStream == null 
                              ? [] 
                              : (SchadsRateConstants.levelsForStream[_selectedStream!] ?? []).map((level) {
                            return DropdownMenuItem(
                              value: level, 
                              child: Text(level, style: GoogleFonts.inter(color: BauhausDesign.textDark), overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: _selectedStream == null ? null : (val) {
                            setDialogState(() {
                              _selectedLevel = val;
                              _selectedPayPoint = null;
                              _rateWarning = null;
                            });
                            setState(() {}); // Sync parent state
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedPayPoint,
                          decoration: const InputDecoration(
                            labelText: 'Pay Point',
                            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                            filled: true,
                            fillColor: BauhausDesign.surfaceLight,
                          ),
                          isExpanded: true,
                          items: (_selectedStream == null || _selectedLevel == null)
                              ? []
                              : SchadsRateConstants.getPayPoints(_selectedStream!, _selectedLevel!).map((pp) {
                                  return DropdownMenuItem(
                                    value: pp, 
                                    child: Text(pp, style: GoogleFonts.inter(color: BauhausDesign.textDark), overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                          onChanged: (_selectedStream == null || _selectedLevel == null) ? null : (val) {
                            setDialogState(() {
                              _selectedPayPoint = val;
                            });
                            setState(() {}); // Sync parent state
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
                                      Expanded(child: Text(_rateWarning!, style: GoogleFonts.inter(color: Colors.red, fontSize: 12))),
                                  ],
                              ),
                          ),
                      ),
 
                   _buildSectionTitle('BASE RATE'),
                  Row(
                      children: [
                          Expanded(
                              flex: 2,
                              child: _buildTextField(
                                  controller: _baseRateController,
                                  label: 'Base Rate (Hourly)',
                                  onChanged: (_) => _calculateSchadsRates(),
                              ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                              flex: 1,
                              child: DropdownButtonFormField<String>(
                                value: _payType,
                                decoration: const InputDecoration(
                                    labelText: 'Pay Type',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                                    filled: true,
                                    fillColor: BauhausDesign.surfaceLight,
                                ),
                                style: GoogleFonts.inter(
                                    color: BauhausDesign.textDark,
                                    fontWeight: FontWeight.w500,
                                ),
                                dropdownColor: BauhausDesign.surfaceLight,
                                isExpanded: true,
                                items: [
                                  DropdownMenuItem(
                                      value: 'Hourly', 
                                      child: Text(
                                          'Hourly', 
                                          style: GoogleFonts.inter(color: BauhausDesign.textDark),
                                          overflow: TextOverflow.ellipsis,
                                      )
                                  ),
                                  DropdownMenuItem(
                                      value: 'Salary', 
                                      child: Text(
                                          'Salary',
                                          style: GoogleFonts.inter(color: BauhausDesign.textDark),
                                          overflow: TextOverflow.ellipsis,
                                      )
                                  ),
                                ],
                                onChanged: (val) => setDialogState(() => _payType = val!),
                              ),
                          ),
                      ],
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSectionTitle('PENALTY RATES (TOTAL HOURLY)'),
                  Row(
                      children: [
                          Expanded(child: _buildTextField(controller: _saturdayRateController, label: 'Saturday (150%)')),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTextField(controller: _sundayRateController, label: 'Sunday (200%)')),
                      ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                      children: [
                          Expanded(child: _buildTextField(controller: _publicHolidayRateController, label: 'Public Holiday (250%)')),
                          const SizedBox(width: 16),
                          Expanded(child: Container()),
                      ],
                  ),
                  
                  const SizedBox(height: 16),
                  _buildSectionTitle('OVERTIME (TOTAL HOURLY)'),
                  Row(
                      children: [
                          Expanded(child: _buildTextField(controller: _overtimeRateController, label: 'First 2 Hours (150%)')),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTextField(controller: _overtimeRate2Controller, label: 'After 2 Hours (200%)')),
                      ],
                  ),

                  const SizedBox(height: 16),
                  _buildSectionTitle('ALLOWANCES (ENABLED)'),
                  ...SchadsRateConstants.allowances.keys.map((allowance) {
                      final isSelected = _selectedAllowances.contains(allowance);
                      final rate = SchadsRateConstants.allowances[allowance];
                      return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(allowance, style: GoogleFonts.inter(color: BauhausDesign.textDark, fontSize: 14)),
                          subtitle: Text('\$${rate?.toStringAsFixed(2)}', style: GoogleFonts.inter(color: BauhausDesign.neutral, fontSize: 12)),
                          value: isSelected,
                          activeColor: BauhausDesign.primary,
                          onChanged: (val) {
                              setDialogState(() {
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
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('CANCEL', style: GoogleFonts.oswald(color: BauhausDesign.neutral)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: BauhausDesign.secondary,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            onPressed: _saveRate,
            child: Text('SAVE RATES', style: GoogleFonts.oswald(color: Colors.white)),
          ),
        ],
      ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
      return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
              title, 
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: BauhausDesign.neutral)
          ),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true, // Make field more compact
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        if (double.tryParse(value) == null) return 'Invalid';
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch provider
    final employeeState = ref.watch(employeePayRateViewModelProvider(widget.organizationId));
    
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: SafeArea(
          child: Column(
              children: [
                  _buildHeader(),
                  Expanded(
                      child: employeeState.isLoading
                          ? const Center(child: CircularProgressIndicator(color: BauhausDesign.primary))
                          : employeeState.error != null
                              ? Center(child: Text('Error: ${employeeState.error}'))
                              : ListView.separated(
                                  padding: const EdgeInsets.all(BauhausDesign.space4),
                                  itemCount: employeeState.employees.length,
                                  separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space4),
                                  itemBuilder: (context, index) {
                                    final user = employeeState.employees[index];
                                    return _EmployeeCard(
                                        user: user,
                                        onTap: () => _selectUser(user),
                                    );
                                  },
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
                  'EMPLOYEE PAY RATES',
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
                    boxShadow: const [BoxShadow(color: BauhausDesign.neutral, offset: Offset(4, 4))],
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
                                        style: GoogleFonts.oswald(fontSize: 18, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
                                    ),
                                    Text(
                                        user.email,
                                        style: GoogleFonts.inter(fontSize: 12, color: BauhausDesign.neutral),
                                    ),
                                ],
                            ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                Text(
                                    user.payRate > 0 
                                        ? '\$${user.payRate.toStringAsFixed(2)}'
                                        : 'NOT SET',
                                    style: GoogleFonts.oswald(
                                        fontSize: 20, 
                                        fontWeight: FontWeight.bold,
                                        color: user.payRate > 0 ? BauhausDesign.success : BauhausDesign.neutral
                                    ),
                                ),
                                Text(
                                    user.payType == 'Salary' ? 'PER ANNUM' : 'PER HOUR',
                                    style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
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
