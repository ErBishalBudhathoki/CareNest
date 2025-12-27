import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';

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

class _AddHolidayScreenState extends ConsumerState<AddHolidayScreen>
    with TickerProviderStateMixin {
  final TextEditingController _holidayController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  late AnimationController _headerController;
  late AnimationController _formController;
  late AnimationController _buttonController;

  late Animation<double> _headerSlideAnimation;
  late Animation<double> _formFadeAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _formController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _headerSlideAnimation = Tween<double>(
      begin: -100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.elasticOut,
    ));

    _formFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.easeOutCubic,
    ));

    _buttonScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.elasticOut,
    ));

    // Start animations
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _formController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _formController.dispose();
    _buttonController.dispose();
    _holidayController.dispose();
    _dateController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ModernInvoiceDesign.background,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Modern Glass App Bar
          SliverAppBar(
            expandedHeight: kToolbarHeight + 10,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        ModernInvoiceDesign.background.withValues(alpha: 0.8),
                    border: Border(
                      bottom: BorderSide(
                        color:
                            ModernInvoiceDesign.border.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ModernInvoiceDesign.border,
                ),
                boxShadow: ModernInvoiceDesign.shadowSm,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            title: Text(
              'Add Holiday',
              style: ModernInvoiceDesign.headlineMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: ModernInvoiceDesign.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            centerTitle: true,
          ),

          // Enhanced Header Section
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _headerSlideAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _headerSlideAnimation.value),
                  child: _buildEnhancedHeader(screenWidth, screenHeight),
                );
              },
            ),
          ),

          // Form Section
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _formFadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _formFadeAnimation.value,
                  child: _buildFormSection(screenWidth),
                );
              },
            ),
          ),

          // Submit Button
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _buttonScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _buttonScaleAnimation.value,
                  child: _buildSubmitButton(screenWidth),
                );
              },
            ),
          ),

          // Bottom padding
          SliverToBoxAdapter(
            child: SizedBox(height: ModernInvoiceDesign.space10),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedHeader(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        ModernInvoiceDesign.space4,
        0,
        ModernInvoiceDesign.space4,
        ModernInvoiceDesign.space6,
      ),
      padding: EdgeInsets.all(screenWidth * 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radius3xl),
        color: const Color(0xFFEEF2FF), // Light Lavender/Indigo
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ModernInvoiceDesign.primary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Animated icon
          Container(
            width: screenWidth * 0.18,
            height: screenWidth * 0.18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: ModernInvoiceDesign.shadowSm,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                fit: BoxFit.contain,
              ),
            ),
          )
              .animate(delay: 400.ms)
              .scale(duration: 800.ms, curve: Curves.elasticOut)
              .then()
              .shimmer(delay: 1000.ms, duration: 2000.ms),

          SizedBox(height: screenWidth * 0.05),

          // Title with modern typography - Dark Text
          Text(
            'Add New Holiday',
            style: ModernInvoiceDesign.displaySmall.copyWith(
              color: ModernInvoiceDesign.textPrimary, // Dark Text
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ).animate(delay: 600.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3),

          SizedBox(height: screenWidth * 0.02),

          // Subtitle - Dark Grey Text
          Text(
            'Create a new holiday entry for your calendar',
            textAlign: TextAlign.center,
            style: ModernInvoiceDesign.bodyMedium.copyWith(
              color: ModernInvoiceDesign.textSecondary, // Dark Grey Text
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ).animate(delay: 800.ms).fadeIn(duration: 800.ms),
        ],
      ),
    );
  }

  Widget _buildFormSection(double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ModernInvoiceDesign.space4),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Holiday Details',
              style: ModernInvoiceDesign.headlineSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: ModernInvoiceDesign.textPrimary,
              ),
            ),
            SizedBox(height: ModernInvoiceDesign.space6),

            // Holiday Name Field
            _buildModernTextField(
              controller: _holidayController,
              label: 'Holiday Name',
              hint: 'e.g., Christmas Day, New Year',
              iconAsset: 'assets/icons/3D Icons/3dicons-fire-dynamic-color.png',
              screenWidth: screenWidth,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a holiday name';
                }
                return null;
              },
            ).animate(delay: 100.ms).slideX(begin: 0.3).fadeIn(),

            SizedBox(height: ModernInvoiceDesign.space5),

            // Date Field
            _buildModernTextField(
              controller: _dateController,
              label: 'Date',
              hint: 'DD-MM-YYYY',
              iconAsset:
                  'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
              screenWidth: screenWidth,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a date';
                }
                if (!RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value)) {
                  return 'Please use DD-MM-YYYY format';
                }
                return null;
              },
            ).animate(delay: 200.ms).slideX(begin: 0.3).fadeIn(),

            SizedBox(height: ModernInvoiceDesign.space5),

            // Day Field
            _buildModernTextField(
              controller: _dayController,
              label: 'Day of Week',
              hint: 'e.g., Monday, Tuesday',
              iconAsset:
                  'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
              screenWidth: screenWidth,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the day of week';
                }
                return null;
              },
            ).animate(delay: 300.ms).slideX(begin: 0.3).fadeIn(),

            SizedBox(height: ModernInvoiceDesign.space8),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String iconAsset,
    required double screenWidth,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: ModernInvoiceDesign.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: ModernInvoiceDesign.textSecondary,
          ),
        ),
        SizedBox(height: ModernInvoiceDesign.space2),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
            boxShadow: ModernInvoiceDesign.shadowSm,
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            style: ModernInvoiceDesign.bodyLarge.copyWith(
              fontWeight: FontWeight.w500,
              color: ModernInvoiceDesign.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: ModernInvoiceDesign.bodyLarge.copyWith(
                color: ModernInvoiceDesign.textTertiary,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: ModernInvoiceDesign.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  iconAsset,
                  width: 24,
                  height: 24,
                ),
              ),
              filled: true,
              fillColor: ModernInvoiceDesign.surface,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                borderSide: BorderSide(
                  color: ModernInvoiceDesign.border,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                borderSide: const BorderSide(
                  color: ModernInvoiceDesign.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                borderSide: BorderSide(
                  color: ModernInvoiceDesign.error,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                borderSide: BorderSide(
                  color: ModernInvoiceDesign.error,
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: ModernInvoiceDesign.space5,
                vertical: ModernInvoiceDesign.space4,
              ),
              errorStyle: ModernInvoiceDesign.labelMedium.copyWith(
                color: ModernInvoiceDesign.error,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ModernInvoiceDesign.space4),
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radius2xl),
        boxShadow: ModernInvoiceDesign.shadowPrimaryGlow,
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _addHolidayItem,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ModernInvoiceDesign.radius2xl),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: _isLoading
                ? LinearGradient(
                    colors: [
                      ModernInvoiceDesign.neutral300,
                      ModernInvoiceDesign.neutral300,
                    ],
                  )
                : ModernInvoiceDesign.primaryGradient,
            borderRadius: BorderRadius.circular(ModernInvoiceDesign.radius2xl),
          ),
          child: Center(
            child: _isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: ModernInvoiceDesign.space3),
                      Text(
                        'Creating Holiday...',
                        style: ModernInvoiceDesign.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                          width: 28,
                          height: 28,
                        ),
                      ),
                      SizedBox(width: ModernInvoiceDesign.space3),
                      Text(
                        'Add Holiday',
                        style: ModernInvoiceDesign.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
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

        // Enhanced success animation
        _showSuccessDialog();

        Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.pop(context);
        });
      } else {
        debugPrint("Holiday Not Added ${ins['message']}");
        throw Exception('Failed to add holiday');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to add holiday. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.surface,
              borderRadius:
                  BorderRadius.circular(ModernInvoiceDesign.radius2xl),
              boxShadow: ModernInvoiceDesign.shadowLg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: ModernInvoiceDesign.successGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            ModernInvoiceDesign.success.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.elasticOut)
                    .then()
                    .shimmer(duration: 1500.ms),
                const SizedBox(height: 20),
                Text(
                  'Holiday Created!',
                  style: ModernInvoiceDesign.headlineMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: ModernInvoiceDesign.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your holiday has been added successfully',
                  style: ModernInvoiceDesign.bodyMedium.copyWith(
                    color: ModernInvoiceDesign.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ).animate().scale(duration: 400.ms, curve: Curves.elasticOut).fadeIn();
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: ModernInvoiceDesign.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: ModernInvoiceDesign.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        ),
      ),
    );
  }
}
