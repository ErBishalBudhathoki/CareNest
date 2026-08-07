import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';

import '../providers/onboarding_providers.dart';
import 'document_upload_view.dart';
import 'widgets/bank_details_form.dart';
import 'widgets/onboarding_success_view.dart';
import 'widgets/personal_details_form.dart';
import 'widgets/superannuation_form.dart';
import 'widgets/tax_details_form.dart';

class OnboardingStepperView extends ConsumerStatefulWidget {
  const OnboardingStepperView({super.key});

  @override
  ConsumerState<OnboardingStepperView> createState() =>
      _OnboardingStepperViewState();
}

class _OnboardingStepperViewState extends ConsumerState<OnboardingStepperView> {
  bool _isReviewing = false;
  bool _restartFromBeginning = false;
  bool _didReadRouteArgs = false;
  int? _currentStep;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingViewModelProvider.notifier).loadStatus();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didReadRouteArgs) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _restartFromBeginning =
          arguments?['restartFromBeginning'] as bool? ?? false;
      _didReadRouteArgs = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingViewModelProvider);
    final record = state.record;

    Widget content;

    if (state.isLoading && record == null) {
      content = const Center(
        key: ValueKey('loading'),
        child: CircularProgressIndicator(),
      );
    } else if (record == null) {
      content = const Center(
        key: ValueKey('error'),
        child: Text('Failed to load onboarding status'),
      );
    } else if (!_isReviewing &&
        const {
          'submitted',
          'review_pending',
          'completed',
          'rejected',
        }.contains(record.status)) {
      content = OnboardingSuccessView(
        key: const ValueKey('success'),
        status: record.status,
        onReviewPressed: () {
          setState(() {
            _isReviewing = true;
          });
        },
      );
    } else {
      if (_currentStep == null) {
        _currentStep = _restartFromBeginning ? 0 : _resolveInitialStep(record);
        if (_currentStep! < 0) _currentStep = 0;
        if (_currentStep! > 5) _currentStep = 5;
      }
      int currentStep = _currentStep!;

      final stepConfigs = [
        const _OnboardingStageConfig(
          label: 'Personal details',
          title: 'Tell us about you',
          subtitle:
              'Add your address and emergency contact so CareNest can keep your profile complete and ready for rostering.',
          assetPath: 'assets/ui_assets_svg/onboarding_personal.svg',
          accentColor: Color(0xFFEFF4FF),
        ),
        const _OnboardingStageConfig(
          label: 'Bank details',
          title: 'Set up payroll details',
          subtitle:
              'Add the bank account your wages should be paid into. This only needs to be done once.',
          assetPath: 'assets/ui_assets_svg/onboarding_bank.svg',
          accentColor: Color(0xFFF2F0FF),
        ),
        const _OnboardingStageConfig(
          label: 'Tax details',
          title: 'Add your tax information',
          subtitle:
              'Enter your TFN and choose the tax scale that applies to you for payroll setup.',
          assetPath: 'assets/ui_assets_svg/onboarding_tax.svg',
          accentColor: Color(0xFFEFFBF8),
        ),
        const _OnboardingStageConfig(
          label: 'Superannuation',
          title: 'Add your super fund details',
          subtitle:
              'Enter the super fund information CareNest needs to process your super contributions correctly.',
          assetPath: 'assets/ui_assets_svg/onboarding_super.svg',
          accentColor: Color(0xFFF7F3FF),
        ),
        const _OnboardingStageConfig(
          label: 'Identity documents',
          title: 'Upload identity and verification documents',
          subtitle:
              'Start with your core identity and background-check documents so your profile can be reviewed.',
          assetPath: 'assets/ui_assets_svg/onboarding_identity_docs.svg',
          accentColor: Color(0xFFFFF7ED),
        ),
        const _OnboardingStageConfig(
          label: 'Documents',
          title: 'Upload training and compliance documents',
          subtitle:
              'Finish by uploading the certificates and compliance documents needed before onboarding can be submitted.',
          assetPath: 'assets/ui_assets_svg/onboarding_final_docs.svg',
          accentColor: Color(0xFFF4F8FF),
        ),
      ];
      final config = stepConfigs[currentStep];

      content = _OnboardingStageFrame(
        key: ValueKey(currentStep),
        stepIndex: currentStep,
        totalSteps: stepConfigs.length,
        config: config,
        child: _buildStageBody(currentStep, record, context),
      );
    }

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceWhite,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6FAFF), Color(0xFFF8FAFF)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 360),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0.08, 0),
                  end: Offset.zero,
                ).animate(animation);
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  void _updateStep() {
    if (_restartFromBeginning) {
      _restartFromBeginning = false;
    }

    if (_currentStep != null && _currentStep! < 5) {
      setState(() {
        _currentStep = _currentStep! + 1;
      });
    }

    ref.read(onboardingViewModelProvider.notifier).loadStatus();
  }

  Widget _buildStageBody(
    int currentStep,
    dynamic record,
    BuildContext context,
  ) {
    switch (currentStep) {
      case 0:
        return PersonalDetailsForm(
          initialStatus: record.steps.personalDetails.status,
          onComplete: _updateStep,
        );
      case 1:
        return BankDetailsForm(
          status: record.steps.bankDetails.status,
          bankName: record.steps.bankDetails.bankName,
          accountName: record.steps.bankDetails.accountName,
          bsb: record.steps.bankDetails.bsb,
          accountNumber: record.steps.bankDetails.accountNumber,
          onComplete: _updateStep,
        );
      case 2:
        return TaxDetailsForm(
          taxStatus: record.steps.taxDetails.status,
          tfn: record.steps.taxDetails.tfn,
          taxScale: record.steps.taxDetails.taxScale,
          onComplete: _updateStep,
        );
      case 3:
        return SuperannuationForm(
          superStatus: record.steps.superannuation.status,
          fundName: record.steps.superannuation.fundName,
          memberNumber: record.steps.superannuation.memberNumber,
          usi: record.steps.superannuation.usi,
          onComplete: _updateStep,
        );
      case 4:
        return DocumentUploadView(
          title: 'Identity and background checks',
          description:
              'Upload your proof of identity and the checks we need before you can be cleared to work.',
          documentTypes: const [
            'Passport / ID',
            'Visa Grant (if applicable)',
            'Police Check',
          ],
          optionalDocumentTypes: const {'Visa Grant (if applicable)'},
          buttonText: 'Continue',
          onComplete: _updateStep,
        );
      default:
        return DocumentUploadView(
          title: 'Training and compliance',
          description:
              'Upload the rest of your required certificates and compliance documents to finish onboarding.',
          documentTypes: const [
            'Qualifications / Certifications',
            'WWCC (Working With Children Check)',
            'NDIS Worker Screening',
            'First Aid Certificate',
          ],
          buttonText: 'Finish Onboarding',
          onComplete: () => _submitOnboarding(context),
        );
    }
  }

  void _submitOnboarding(BuildContext context) async {
    await ref.read(onboardingViewModelProvider.notifier).submitOnboarding();

    if (context.mounted) {
      final state = ref.read(onboardingViewModelProvider);
      if (state.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${state.error}'),
            backgroundColor: BauhausDesign.error,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Onboarding Submitted!'),
            backgroundColor: BauhausDesign.success,
          ),
        );
      }
    }
  }

  int _resolveInitialStep(dynamic record) {
    if (record.steps.personalDetails.status != 'completed') return 0;
    if (record.steps.bankDetails.status != 'completed') return 1;
    if (record.steps.taxDetails.status != 'completed') return 2;
    if (record.steps.superannuation.status != 'completed') return 3;

    final uploadedTypes = record.steps.documents.count > 0
        ? ref
              .read(onboardingViewModelProvider)
              .documents
              .map((doc) => doc.type)
              .toSet()
        : <String>{};

    const firstDocumentGroup = {'Passport / ID', 'Police Check'};
    final firstGroupComplete = firstDocumentGroup.every(
      (doc) => uploadedTypes.contains(doc),
    );

    return firstGroupComplete ? 5 : 4;
  }
}

class _OnboardingStageConfig {
  const _OnboardingStageConfig({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.accentColor,
  });

  final String label;
  final String title;
  final String subtitle;
  final String assetPath;
  final Color accentColor;
}

class _OnboardingStageFrame extends StatelessWidget {
  const _OnboardingStageFrame({
    super.key,
    required this.stepIndex,
    required this.totalSteps,
    required this.config,
    required this.child,
  });

  final int stepIndex;
  final int totalSteps;
  final _OnboardingStageConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = BauhausDesign.getTextTheme(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final heroHeight = constraints.maxHeight < 740 ? 108.0 : 140.0;

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4FF),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      config.label,
                      style: theme.bodySmall?.copyWith(
                        color: BauhausDesign.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${stepIndex + 1} / $totalSteps',
                    style: theme.bodySmall?.copyWith(
                      color: BauhausDesign.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: (stepIndex + 1) / totalSteps,
                  minHeight: 7,
                  backgroundColor: const Color(0xFFE6EBF7),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    BauhausDesign.primary,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                height: heroHeight,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: config.accentColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SvgPicture.asset(config.assetPath, fit: BoxFit.contain),
              ),
              const SizedBox(height: 18),
              Text(
                config.title,
                style: theme.headlineSmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                config.subtitle,
                style: theme.bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: _StageBodyViewport(
                  scrollable: stepIndex != totalSteps - 1,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StageBodyViewport extends StatelessWidget {
  const _StageBodyViewport({required this.scrollable, required this.child});

  final bool scrollable;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!scrollable) {
      return child;
    }

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 12),
      child: child,
    );
  }
}
