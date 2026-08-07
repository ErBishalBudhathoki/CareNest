import 'package:flutter/material.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';

class OnboardingSuccessView extends StatelessWidget {
  final String status;
  final VoidCallback? onReviewPressed;

  const OnboardingSuccessView({
    super.key,
    required this.status,
    this.onReviewPressed,
  });

  @override
  Widget build(BuildContext context) {
    final data = _statusData();
    final theme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.color.withOpacity(0.08),
                  border: Border.all(color: data.color, width: 3),
                ),
                child: Icon(data.icon, size: 40, color: data.color),
              ),
              const SizedBox(height: 32),
              Text(
                data.title,
                style: theme.displaySmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                data.message,
                style: theme.bodyLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                  height: 1.5,
                ),
              ),
              if (data.steps != null) ...[
                const SizedBox(height: 32),
                ...data.steps!.map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 8),
                          color: data.color,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            s,
                            style: theme.bodyMedium?.copyWith(
                              color: BauhausDesign.textDark.withOpacity(0.7),
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 40),
              if (status == 'rejected')
                ButtonWidget(
                  buttonText: 'Review Submission',
                  buttonColor: BauhausDesign.error,
                  onPressed: onReviewPressed,
                )
              else
                ButtonWidget(
                  buttonText: 'Back to Home',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  _StatusData _statusData() {
    switch (status) {
      case 'completed':
        return _StatusData(
          title: 'Onboarding\nComplete!',
          message:
              'Everything has been approved. '
              'Welcome to the team — you\'re ready to start.',
          icon: Icons.check,
          color: BauhausDesign.success,
        );
      case 'submitted':
      case 'review_pending':
        return _StatusData(
          title: 'Submitted\nfor Review',
          message:
              'Your details and documents have been submitted. '
              'Our team will review them and get back to you '
              'within 1–2 business days.',
          icon: Icons.schedule,
          color: BauhausDesign.warning,
          steps: const [
            'You\'ll receive a notification when review begins',
            'If anything needs updating, we\'ll let you know',
            'Once approved, your profile goes live immediately',
          ],
        );
      case 'rejected':
        return _StatusData(
          title: 'Action\nRequired',
          message:
              'Some of your details or documents need attention. '
              'Review the feedback and resubmit.',
          icon: Icons.priority_high,
          color: BauhausDesign.error,
        );
      default:
        return _StatusData(
          title: 'Processing',
          message: 'Your onboarding status is being updated.',
          icon: Icons.info_outline,
          color: BauhausDesign.secondary,
        );
    }
  }
}

class _StatusData {
  final String title;
  final String message;
  final IconData icon;
  final Color color;
  final List<String>? steps;

  const _StatusData({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
    this.steps,
  });
}
