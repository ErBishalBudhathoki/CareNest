import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';

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
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Modern Glass App Bar
          SliverAppBar(
            expandedHeight: screenHeight * 0.12,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.8),
                        Colors.white.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2),
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
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: ModernInvoiceDesign.textPrimary,
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
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedHeader(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        screenWidth * 0.04,
        screenHeight * 0.02,
        screenWidth * 0.04,
        screenWidth * 0.04,
      ),
      child: Stack(
        children: [
          // Background with mesh gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const RadialGradient(
                  colors: [
                    Color(0xFF10B981),
                    Color(0xFF3B82F6),
                    Color(0xFF6366F1),
                  ],
                  stops: [0.0, 0.6, 1.0],
                  center: Alignment.topRight,
                  radius: 1.5,
                ),
              ),
            ),
          ),
          // Glassmorphism overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.06),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.25),
                      Colors.white.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Animated icon with glow
                    Container(
                      width: screenWidth * 0.18,
                      height: screenWidth * 0.18,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFF1F5F9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                      ),
                    )
                        .animate(delay: 400.ms)
                        .scale(duration: 800.ms, curve: Curves.elasticOut)
                        .then()
                        .shimmer(delay: 1000.ms, duration: 2000.ms),

                    SizedBox(height: screenWidth * 0.05),

                    // Title with modern typography
                    Text(
                      'Create New Holiday',
                      style: TextStyle(
                        fontSize: screenWidth * 0.065,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                        letterSpacing: -0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    )
                        .animate(delay: 600.ms)
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: 0.3),

                    SizedBox(height: screenWidth * 0.02),

                    // Subtitle
                    Text(
                      'Add a special day to your calendar',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ).animate(delay: 800.ms).fadeIn(duration: 800.ms),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 1000.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.4);
  }

  Widget _buildFormSection(double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Holiday Details',
              style: TextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: screenWidth * 0.06),

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

            SizedBox(height: screenWidth * 0.05),

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

            SizedBox(height: screenWidth * 0.05),

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

            SizedBox(height: screenWidth * 0.08),
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
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
            letterSpacing: 0.1,
          ),
        ),
        SizedBox(height: screenWidth * 0.025),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: screenWidth * 0.04,
                color: const Color(0xFF9CA3AF),
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF8B5CF6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  iconAsset,
                  width: screenWidth * 0.055,
                  height: screenWidth * 0.055,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: const Color(0xFFE5E7EB),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF6366F1),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFEF4444),
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFEF4444),
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.045,
              ),
              errorStyle: TextStyle(
                fontSize: screenWidth * 0.032,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFEF4444),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      width: double.infinity,
      height: screenWidth * 0.14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _addHolidayItem,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: _isLoading
                ? LinearGradient(
                    colors: [
                      Colors.grey.withValues(alpha: 0.6),
                      Colors.grey.withValues(alpha: 0.4),
                    ],
                  )
                : const LinearGradient(
                    colors: [
                      Color(0xFF10B981),
                      Color(0xFF059669),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: _isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.05,
                        height: screenWidth * 0.05,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Text(
                        'Creating Holiday...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.042,
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
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                          width: screenWidth * 0.07,
                          height: screenWidth * 0.07,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Text(
                        'Add Holiday',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.042,
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
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF10B981),
                        Color(0xFF059669),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.3),
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E293B),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your holiday has been added successfully',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xFF64748B),
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
                color: Colors.white.withValues(alpha: 0.2),
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
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(16),
        elevation: 8,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
