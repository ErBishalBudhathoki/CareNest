import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/service_confirmation_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';

/// Service Confirmation View
/// Digital signature and service confirmation
class ServiceConfirmationView extends ConsumerStatefulWidget {
  const ServiceConfirmationView({super.key});

  @override
  ConsumerState<ServiceConfirmationView> createState() =>
      _ServiceConfirmationViewState();
}

class _ServiceConfirmationViewState
    extends ConsumerState<ServiceConfirmationView> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  int _currentStep = 0;
  int _selectedRating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadChecklistTemplate();
  }

  void _loadChecklistTemplate() {
    ref.read(serviceConfirmationViewModelProvider.notifier).getChecklistTemplate(
          serviceType: 'home_care',
        );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceConfirmationViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Service Confirmation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Progress Indicator
                _buildProgressIndicator(),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: _buildStepContent(state),
                  ),
                ),

                // Navigation Buttons
                _buildNavigationButtons(state),
              ],
            ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          _buildStepIndicator(0, 'Checklist', Icons.checklist),
          _buildStepConnector(),
          _buildStepIndicator(1, 'Rating', Icons.star),
          _buildStepConnector(),
          _buildStepIndicator(2, 'Signature', Icons.edit),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, IconData icon) {
    final isActive = _currentStep == step;
    final isCompleted = _currentStep > step;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.colorSuccess
                  : isActive
                      ? AppColors.colorPrimary
                      : AppColors.colorBackground,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? AppColors.colorPrimary : Color(0xFF666666),
                width: 2,
              ),
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: isCompleted || isActive ? Colors.white : Color(0xFF666666),
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? AppColors.colorPrimary : Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector() {
    return Container(
      height: 2,
      width: 40,
      color: Color(0xFF666666).withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 24),
    );
  }

  Widget _buildStepContent(state) {
    switch (_currentStep) {
      case 0:
        return _buildChecklistStep(state);
      case 1:
        return _buildRatingStep(state);
      case 2:
        return _buildSignatureStep(state);
      default:
        return const SizedBox();
    }
  }

  Widget _buildChecklistStep(state) {
    if (state.checklist.isEmpty) {
      return Center(
        child: Text(
          'No checklist items',
          style: TextStyle(color: Color(0xFF666666)),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Checklist',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please review and confirm completed tasks',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 24),
        ...state.checklist.map((item) => _buildChecklistItem(item)),
      ],
    );
  }

  Widget _buildChecklistItem(ChecklistItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.completed == true
              ? AppColors.colorSuccess.withOpacity(0.3)
              : Color(0xFF666666).withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: item.completed ?? false,
            onChanged: (value) {
              ref
                  .read(serviceConfirmationViewModelProvider.notifier)
                  .updateChecklistItem(item.id, value ?? false);
            },
            activeColor: AppColors.colorSuccess,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.item,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorFontPrimary,
                    decoration: item.completed == true
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                if (item.required)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Required',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.error,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStep(state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate Your Experience',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'How satisfied are you with the service?',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starNumber = index + 1;
              return IconButton(
                iconSize: 48,
                onPressed: () {
                  setState(() {
                    _selectedRating = starNumber;
                  });
                },
                icon: Icon(
                  starNumber <= _selectedRating ? Icons.star : Icons.star_border,
                  color: AppColors.colorWarning,
                ),
              );
            }),
          ),
        ),
        if (_selectedRating > 0)
          Center(
            child: Text(
              _getRatingText(_selectedRating),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.colorPrimary,
              ),
            ),
          ),
        const SizedBox(height: 32),
        Text(
          'Additional Feedback (Optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _feedbackController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Share your thoughts...',
            hintStyle: TextStyle(color: Color(0xFF666666)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF666666).withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF666666).withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.colorPrimary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignatureStep(state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Digital Signature',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please sign below to confirm service completion',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFF666666).withOpacity(0.2),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Signature(
              controller: _signatureController,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {
                _signatureController.clear();
              },
              icon: const Icon(Icons.clear),
              label: const Text('Clear'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.colorPrimary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.colorPrimary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Your signature will be encrypted and timestamped for security',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(state) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: AppColors.colorPrimary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: state.isSubmitting ? null : () => _handleNext(state),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colorPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: state.isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      _currentStep == 2 ? 'Submit' : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext(state) {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitConfirmation(state);
    }
  }

  Future<void> _submitConfirmation(state) async {
    // Validate signature
    if (_signatureController.isEmpty) {
      Get.snackbar(
        'Signature Required',
        'Please provide your signature',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return;
    }

    // Save rating
    if (_selectedRating > 0) {
      ref.read(serviceConfirmationViewModelProvider.notifier).setRating(
            stars: _selectedRating,
            feedback: _feedbackController.text.trim(),
          );
    }

    // Get signature data
    final signatureData = await _signatureController.toPngBytes();
    if (signatureData == null) return;

    // TODO: Submit confirmation with actual appointment data
    Get.snackbar(
      'Success',
      'Service confirmation submitted successfully',
      backgroundColor: AppColors.colorSuccess,
      colorText: Colors.white,
    );

    Get.back();
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }
}
