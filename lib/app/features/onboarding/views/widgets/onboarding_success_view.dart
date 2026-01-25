import 'package:flutter/material.dart';
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
    String title;
    String message;
    IconData icon;
    Color color;

    switch (status) {
      case 'completed':
        title = 'Onboarding Complete!';
        message = 'You have successfully completed the onboarding process. Welcome to the team!';
        icon = Icons.check_circle_outline;
        color = Colors.green;
        break;
      case 'submitted':
      case 'review_pending':
        title = 'Submitted for Review';
        message = 'Your details have been submitted and are currently under review. We will notify you once approved.';
        icon = Icons.hourglass_top;
        color = Colors.orange;
        break;
      case 'rejected':
        title = 'Action Required';
        message = 'Some details or documents were rejected. Please review your submission.';
        icon = Icons.error_outline;
        color = BauhausDesign.error;
        break;
      default:
        title = 'Processing';
        message = 'Your onboarding status is being updated.';
        icon = Icons.info_outline;
        color = BauhausDesign.secondary;
    }

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceWhite,
      body: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(icon, size: 80, color: color),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              title,
              style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              message,
              style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                    color: BauhausDesign.textDark.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (status == 'rejected')
                      ButtonWidget(
                        buttonText: 'Review Submission',
                        onPressed: onReviewPressed ?? () {},
                      )
                    else
              ButtonWidget(
                buttonText: 'Back to Home',
                onPressed: () {
                  Navigator.of(context).pop(); // Go back to main app
                },
              ),
          ],
        ),
      ),
    );
  }
}
