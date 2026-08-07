import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/services/crashlytics/crashlytics_service.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/feedback/models/user_feedback.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:carenest/config/environment.dart';
import 'dart:io';

/// In-app feedback form for users to submit issues.
/// Attaches device context and sends to Crashlytics.
class FeedbackFormView extends StatefulWidget {
  final String? userEmail;
  final String? initialTitle;
  final String? initialDescription;

  const FeedbackFormView({
    super.key,
    this.userEmail,
    this.initialTitle,
    this.initialDescription,
  });

  @override
  State<FeedbackFormView> createState() => _FeedbackFormViewState();
}

class _FeedbackFormViewState extends State<FeedbackFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _descriptionController.text = widget.initialDescription ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    final info = <String, String>{
      'appVersion': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
    };

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      info['platform'] = 'Android';
      info['device'] = '${android.manufacturer} ${android.model}';
      info['osVersion'] = 'Android ${android.version.release}';
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      info['platform'] = 'iOS';
      info['device'] = ios.utsname.machine;
      info['osVersion'] = '${ios.systemName} ${ios.systemVersion}';
    }

    return info;
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final deviceInfo = await _getDeviceInfo();
      final crashlytics = CrashlyticsService.instance;

      // Log the user feedback as a custom log
      crashlytics.log('=== USER FEEDBACK SUBMITTED ===');
      crashlytics.log('Title: ${_titleController.text}');
      crashlytics.log('Description: ${_descriptionController.text}');
      crashlytics.log('User: ${widget.userEmail ?? 'Unknown'}');

      // Add device context
      for (final entry in deviceInfo.entries) {
        await crashlytics.setCustomKey('feedback_${entry.key}', entry.value);
      }
      await crashlytics.setCustomKey('feedback_title', _titleController.text);
      await crashlytics.setCustomKey(
        'feedback_timestamp',
        DateTime.now().toIso8601String(),
      );

      // Record as non-fatal error so it appears in Crashlytics dashboard
      await crashlytics.recordError(
        UserFeedback('User Feedback: ${_titleController.text}'),
        StackTrace.current,
        reason: _descriptionController.text,
        fatal: false,
      );

      setState(() {
        _isSubmitting = false;
        _submitted = true;
      });
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.feedbackError ??
                  'Failed to submit feedback. Please try again.',
            ),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          l10n?.feedbackTitle ?? 'Submit Feedback',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            color: BauhausDesign.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: BauhausDesign.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1.5),
        ),
      ),
      body: _submitted ? _buildSuccessState(l10n) : _buildForm(l10n),
    );
  }

  Widget _buildSuccessState(AppLocalizations? l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space5),
              decoration: BoxDecoration(
                color: BauhausDesign.success.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: BauhausDesign.success, width: 2),
              ),
              child: Icon(
                Icons.check_rounded,
                size: 64,
                color: BauhausDesign.success,
              ),
            ),
            const SizedBox(height: BauhausDesign.space5),
            Text(
              l10n?.feedbackSuccess ?? 'Thank you for your feedback!',
              style: BauhausDesign.getTextTheme(context).headlineSmall
                  ?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              l10n?.feedbackSuccessMessage ??
                  'Your feedback helps us improve CareNest.',
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyLarge?.copyWith(color: BauhausDesign.textMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space6),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.primary,
                  foregroundColor: BauhausDesign.surfaceWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    side: BorderSide(color: BauhausDesign.neutral, width: 2),
                  ),
                ),
                child: Text(
                  l10n?.closeButton ?? 'Close',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(AppLocalizations? l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space5),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.feedbackSubtitle ??
                  'Describe the issue or share your suggestions',
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyLarge?.copyWith(color: BauhausDesign.textMuted),
            ),
            const SizedBox(height: BauhausDesign.space5),

            // Title Field
            Text(
              l10n?.feedbackTitleLabel ?? 'Issue Title',
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText:
                    l10n?.feedbackTitleHint ?? 'Brief summary of the issue',
                filled: true,
                fillColor: BauhausDesign.surfaceWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  borderSide: BorderSide(
                    color: BauhausDesign.neutral,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  borderSide: BorderSide(
                    color: BauhausDesign.neutral,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  borderSide: BorderSide(
                    color: BauhausDesign.primary,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n?.feedbackTitleRequired ?? 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: BauhausDesign.space5),

            // Description Field
            Text(
              l10n?.feedbackDescriptionLabel ?? 'Description',
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            TextFormField(
              controller: _descriptionController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText:
                    l10n?.feedbackDescriptionHint ??
                    'What happened? What did you expect to happen?',
                filled: true,
                fillColor: BauhausDesign.surfaceWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  borderSide: BorderSide(
                    color: BauhausDesign.neutral,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  borderSide: BorderSide(
                    color: BauhausDesign.neutral,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  borderSide: BorderSide(
                    color: BauhausDesign.primary,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n?.feedbackDescriptionRequired ??
                      'Please describe the issue';
                }
                return null;
              },
            ),
            const SizedBox(height: BauhausDesign.space4),

            // Info note
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.accent),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: BauhausDesign.accent,
                    size: 20,
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: Text(
                      l10n?.feedbackInfoNote ??
                          'Device info will be included to help us debug.',
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodySmall?.copyWith(color: BauhausDesign.accent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space6),

            // TEST CRASH BUTTON (DEVELOPMENT FLAVOR ONLY)
            if (AppConfig.appFlavor == Flavor.development) ...[
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () =>
                      CrashlyticsService.instance.forceCrashForTesting(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BauhausDesign.error,
                    foregroundColor: BauhausDesign.surfaceWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusMd,
                      ),
                    ),
                  ),
                  child: const Text(
                    'FORCE TEST CRASH (DEV)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
            ],

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.primary,
                  foregroundColor: BauhausDesign.surfaceWhite,
                  disabledBackgroundColor: BauhausDesign.neutral,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    side: BorderSide(color: BauhausDesign.neutral, width: 2),
                  ),
                ),
                child: _isSubmitting
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            BauhausDesign.surfaceWhite,
                          ),
                        ),
                      )
                    : Text(
                        l10n?.feedbackSubmit ?? 'Submit Feedback',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
