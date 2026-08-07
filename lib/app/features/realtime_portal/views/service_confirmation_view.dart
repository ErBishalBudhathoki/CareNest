import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signature/signature.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/service_confirmation_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:google_fonts/google_fonts.dart';

/// Service Confirmation View
/// Digital signature and service confirmation following Bauhaus Neo-Brutalist rules
class ServiceConfirmationView extends ConsumerStatefulWidget {
  const ServiceConfirmationView({super.key});

  @override
  ConsumerState<ServiceConfirmationView> createState() =>
      _ServiceConfirmationViewState();
}

class _ServiceConfirmationViewState
    extends ConsumerState<ServiceConfirmationView> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 4,
    penColor: BauhausDesign.neutral,
    exportBackgroundColor: Colors.white,
  );

  int _currentStep = 0;
  int _selectedRating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChecklistTemplate();
    });
  }

  void _loadChecklistTemplate() {
    ref
        .read(serviceConfirmationViewModelProvider.notifier)
        .getChecklistTemplate(serviceType: 'home_care');
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
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final appointmentId = args?['appointmentId'] as String? ?? 'appt_default';
    final clientId = args?['clientId'] as String? ?? 'client_default';
    final workerId = args?['workerId'] as String? ?? 'worker_default';
    final workerName = args?['workerName'] as String? ?? 'Worker';
    final serviceName = args?['serviceName'] as String? ?? 'Home Care';

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Service Confirmation',
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
            color: BauhausDesign.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BauhausDesign.primary),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: BauhausDesign.neutral, height: 1.5),
        ),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  BauhausDesign.primary,
                ),
              ),
            )
          : Column(
              children: [
                // Progress Indicator
                _buildProgressIndicator(),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(BauhausDesign.space5),
                    child: _buildStepContent(state, workerName, serviceName),
                  ),
                ),

                // Navigation Buttons
                _buildNavigationButtons(
                  state,
                  appointmentId,
                  clientId,
                  workerId,
                ),
              ],
            ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space5,
      ),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(
            color: BauhausDesign.neutral,
            width: BauhausDesign.borderThick,
          ),
        ),
      ),
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
                  ? BauhausDesign.success
                  : isActive
                  ? BauhausDesign.primary
                  : Colors.white,
              border: Border.all(
                color: BauhausDesign.neutral,
                width: BauhausDesign.borderThick,
              ),
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: isCompleted || isActive
                  ? Colors.white
                  : BauhausDesign.textMuted,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: BauhausDesign.neoMonoStyle(
              context,
              fontSize: BauhausDesign.fontXs,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? BauhausDesign.primary : BauhausDesign.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector() {
    return Container(
      height: 4,
      width: 25,
      color: BauhausDesign.neutral,
      margin: const EdgeInsets.only(bottom: 24),
    );
  }

  Widget _buildStepContent(
    ServiceConfirmationState state,
    String workerName,
    String serviceName,
  ) {
    switch (_currentStep) {
      case 0:
        return _buildChecklistStep(state, serviceName);
      case 1:
        return _buildRatingStep(state, workerName);
      case 2:
        return _buildSignatureStep(state);
      default:
        return const SizedBox();
    }
  }

  Widget _buildChecklistStep(
    ServiceConfirmationState state,
    String serviceName,
  ) {
    if (state.checklist.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space5),
          decoration: BauhausDesign.cardDecoration,
          child: Text(
            'No checklist items available.',
            style: GoogleFonts.inter(
              fontSize: BauhausDesign.fontMd,
              fontWeight: FontWeight.bold,
              color: BauhausDesign.textMuted,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Checklist',
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Text(
          'Confirm completed tasks for $serviceName',
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontMd,
            color: BauhausDesign.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: BauhausDesign.space6),
        ...state.checklist.map((item) => _buildChecklistItem(item)),
      ],
    );
  }

  Widget _buildChecklistItem(ChecklistItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BauhausDesign.cardDecoration,
      child: Row(
        children: [
          Checkbox(
            value: item.completed ?? false,
            onChanged: (value) {
              ref
                  .read(serviceConfirmationViewModelProvider.notifier)
                  .updateChecklistItem(item.id, value ?? false);
            },
            activeColor: BauhausDesign.success,
            checkColor: Colors.white,
            side: const BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.item,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontLg,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.textDark,
                    decoration: item.completed == true
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                if (item.required)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'REQUIRED TASK',
                      style: BauhausDesign.neoMonoStyle(
                        context,
                        color: BauhausDesign.primary,
                        fontSize: BauhausDesign.fontXs,
                        fontWeight: FontWeight.bold,
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

  Widget _buildRatingStep(ServiceConfirmationState state, String workerName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate Your Experience',
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Text(
          'How satisfied are you with $workerName\'s service?',
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontMd,
            color: BauhausDesign.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: BauhausDesign.space6),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starNumber = index + 1;
              final isHighlighted = starNumber <= _selectedRating;
              return IconButton(
                iconSize: 48,
                onPressed: () {
                  setState(() {
                    _selectedRating = starNumber;
                  });
                },
                icon: Icon(
                  isHighlighted ? Icons.star : Icons.star_border,
                  color: isHighlighted
                      ? BauhausDesign.accent
                      : BauhausDesign.neutral,
                ),
              );
            }),
          ),
        ),
        if (_selectedRating > 0) ...[
          const SizedBox(height: BauhausDesign.space3),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: BauhausDesign.accent,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
              ),
              child: Text(
                _getRatingText(_selectedRating).toUpperCase(),
                style: BauhausDesign.neoMonoStyle(
                  context,
                  fontSize: BauhausDesign.fontLg,
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: BauhausDesign.space6),
        Text(
          'Additional Feedback (Optional)',
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontLg,
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
          ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        TextField(
          controller: _feedbackController,
          maxLines: 4,
          style: GoogleFonts.inter(
            color: BauhausDesign.textDark,
            fontSize: BauhausDesign.fontMd,
            fontWeight: FontWeight.w500,
          ),
          decoration: BauhausDesign.inputDecoration('Share your thoughts...'),
        ),
      ],
    );
  }

  Widget _buildSignatureStep(ServiceConfirmationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Digital Signature',
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Text(
          'Please sign below to confirm service completion',
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontMd,
            color: BauhausDesign.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: BauhausDesign.space5),
        // Draw board wrapped in Bauhaus Card style with hard shadow
        Container(
          height: 200,
          decoration: BauhausDesign.cardDecoration,
          child: Signature(
            controller: _signatureController,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: TextButton.icon(
                onPressed: () {
                  _signatureController.clear();
                },
                style: TextButton.styleFrom(
                  foregroundColor: BauhausDesign.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                icon: const Icon(Icons.clear, size: 16),
                label: Text(
                  'CLEAR',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space5),
        // Security Information box
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: Row(
            children: [
              const Icon(Icons.lock, color: BauhausDesign.success, size: 24),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: Text(
                  'Your signature will be encrypted and timestamped for security',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontMd,
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(
    ServiceConfirmationState state,
    String appointmentId,
    String clientId,
    String workerId,
  ) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space5),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          top: BorderSide(
            color: BauhausDesign.neutral,
            width: BauhausDesign.borderThick,
          ),
        ),
      ),
      child: Row(
        children: [
          if (_currentStep > 0) ...[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  boxShadow: const [BauhausDesign.shadowHardSm],
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _currentStep--;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'BACK',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.neutral,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
          ],
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: state.isSubmitting
                    ? BauhausDesign.textMuted
                    : BauhausDesign.primary,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: state.isSubmitting
                    ? []
                    : const [BauhausDesign.shadowHardSm],
              ),
              child: TextButton(
                onPressed: state.isSubmitting
                    ? null
                    : () =>
                          _handleNext(state, appointmentId, clientId, workerId),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                        _currentStep == 2 ? 'SUBMIT' : 'NEXT',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext(
    ServiceConfirmationState state,
    String appointmentId,
    String clientId,
    String workerId,
  ) {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitConfirmation(state, appointmentId, clientId, workerId);
    }
  }

  Future<void> _submitConfirmation(
    ServiceConfirmationState state,
    String appointmentId,
    String clientId,
    String workerId,
  ) async {
    // Validate signature
    if (_signatureController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please provide your signature',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: BauhausDesign.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Save rating
    if (_selectedRating > 0) {
      ref
          .read(serviceConfirmationViewModelProvider.notifier)
          .setRating(
            stars: _selectedRating,
            feedback: _feedbackController.text.trim(),
          );
    }

    // Get signature data
    final signatureData = await _signatureController.toPngBytes();
    if (signatureData == null) return;

    final base64Sig = base64Encode(signatureData);

    try {
      // Save signature first
      await ref
          .read(serviceConfirmationViewModelProvider.notifier)
          .saveSignature(
            appointmentId: appointmentId,
            clientId: clientId,
            signatureData: base64Sig,
          );

      final updatedState = ref.read(serviceConfirmationViewModelProvider);
      final signature =
          updatedState.signature ??
          DigitalSignature(
            id: 'sig_${DateTime.now().millisecondsSinceEpoch}',
            appointmentId: appointmentId,
            clientId: clientId,
            signatureData: base64Sig,
            timestamp: DateTime.now(),
            hash: 'hash_${DateTime.now().millisecondsSinceEpoch}',
            verified: true,
          );

      // Submit final confirmation
      await ref
          .read(serviceConfirmationViewModelProvider.notifier)
          .submitConfirmation(
            appointmentId: appointmentId,
            clientId: clientId,
            workerId: workerId,
            signature: signature,
            checklist: updatedState.checklist,
            rating:
                updatedState.rating ??
                ClientRating(
                  stars: _selectedRating,
                  feedback: _feedbackController.text.trim(),
                  tags: [],
                  timestamp: DateTime.now(),
                ),
            photoUrls: [],
            incidents: updatedState.incidents,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Service confirmation submitted successfully',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: BauhausDesign.success,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to submit confirmation: $e',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: BauhausDesign.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
