import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../providers/onboarding_providers.dart';
import 'widgets/personal_details_form.dart';
import 'widgets/tax_super_form.dart';
import 'widgets/bank_details_form.dart';
import 'widgets/onboarding_success_view.dart';
import 'document_upload_view.dart';

class OnboardingStepperView extends ConsumerStatefulWidget {
  const OnboardingStepperView({super.key});

  @override
  ConsumerState<OnboardingStepperView> createState() => _OnboardingStepperViewState();
}

class _OnboardingStepperViewState extends ConsumerState<OnboardingStepperView> {
  bool _isReviewing = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingViewModelProvider);
    final record = state.record;

    if (state.isLoading && record == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (record == null) {
      return const Scaffold(body: Center(child: Text('Failed to load onboarding status')));
    }

    // Check for completion/submission status
    // If rejected, show success view unless reviewing
    if (!_isReviewing && ['submitted', 'review_pending', 'completed', 'rejected'].contains(record.status)) {
      return OnboardingSuccessView(
        status: record.status,
        onReviewPressed: () {
          setState(() {
            _isReviewing = true;
          });
        },
      );
    }

    int currentStep = record.currentStep - 1; // 0-indexed for Stepper
    if (currentStep < 0) currentStep = 0;
    // Ensure we don't exceed step count (indices 0, 1, 2, 3)
    if (currentStep > 3) currentStep = 3;

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceWhite,
      appBar: AppBar(
        title: Text(
          'Onboarding',
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: BauhausDesign.primary,
                secondary: BauhausDesign.primary,
              ),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepTapped: (index) {
            // Logic to allow jumping back but not forward if not completed?
          },
          controlsBuilder: (context, details) {
            // We will handle navigation inside the step content usually, or hide default controls
            return const SizedBox.shrink();
          },
          steps: [
            Step(
              title: const Text('Personal'),
              content: PersonalDetailsForm(
                initialStatus: record.steps.personalDetails.status,
                onComplete: () => _updateStep(2),
              ),
              isActive: currentStep >= 0,
              state: _getStepState(record.steps.personalDetails.status),
            ),
            Step(
              title: const Text('Bank'),
              content: BankDetailsForm(
                status: record.steps.bankDetails.status,
                bankName: record.steps.bankDetails.bankName,
                accountName: record.steps.bankDetails.accountName,
                bsb: record.steps.bankDetails.bsb,
                accountNumber: record.steps.bankDetails.accountNumber,
                onComplete: () => _updateStep(3),
              ),
              isActive: currentStep >= 1,
              state: _getStepState(record.steps.bankDetails.status),
            ),
            Step(
              title: const Text('Tax & Super'),
              content: TaxSuperForm(
                taxStatus: record.steps.taxDetails.status,
                superStatus: record.steps.superannuation.status,
                onComplete: () => _updateStep(4),
              ),
              isActive: currentStep >= 2,
              state: _getStepState(record.steps.taxDetails.status),
            ),
            Step(
              title: const Text('Documents'),
              content: DocumentUploadView(
                onComplete: () => _submitOnboarding(context),
              ),
              isActive: currentStep >= 3,
              state: _getStepState(record.steps.documents.status),
            ),
          ],
        ),
      ),
    );
  }

  StepState _getStepState(String status) {
    if (status == 'completed') return StepState.complete;
    if (status == 'pending') return StepState.indexed;
    return StepState.editing;
  }

  void _updateStep(int nextStep) {
     // Logic to update local state or call API to advance step
     // For now we just refresh status which should reflect new step if backend updated it
     ref.read(onboardingViewModelProvider.notifier).loadStatus();
  }

  void _submitOnboarding(BuildContext context) async {
    await ref.read(onboardingViewModelProvider.notifier).submitOnboarding();
    
    if (context.mounted) {
       final state = ref.read(onboardingViewModelProvider);
       if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.error}'), 
              backgroundColor: BauhausDesign.error
            )
          );
       } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Onboarding Submitted!'),
              backgroundColor: BauhausDesign.success,
            )
          );
       }
    }
  }
}
