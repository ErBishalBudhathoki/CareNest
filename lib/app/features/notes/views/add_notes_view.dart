// create a UI to add notes with a button to save the notes, editable text view to edit notes and a button with a mic icon

import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../shared/constants/bauhaus_design.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class AddNotesView extends ConsumerStatefulWidget {
  final String userEmail;
  final String clientEmail;
  final Map<String, dynamic>? clientDetails;
  const AddNotesView(
      {super.key,
      required this.userEmail,
      required this.clientEmail,
      this.clientDetails});

  @override
  ConsumerState<AddNotesView> createState() => _AddNotesViewState();
}

class _AddNotesViewState extends ConsumerState<AddNotesView> {
  late final TextEditingController _notesController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'add_notes_scaffold_key');
  late final ApiMethod apiMethod;

  late stt.SpeechToText _speechToText;
  bool _speechEnabled = false;
  late SharedPreferences _prefs;
  String accumulatedText = '';
  bool _isInitialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    apiMethod = ref.read(app_providers.apiMethodProvider);
    _speechToText = stt.SpeechToText();
    _initializeServices();
    _notesController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> _initializeServices() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final isAvailable = await _speechToText.initialize();
      if (mounted) {
        setState(() {
          _speechEnabled = isAvailable;
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Failed to initialize speech recognition', isError: true);
      }
    }
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  Future<void> _toggleSpeech() async {
    if (!_speechToText.isListening) {
      final hasPermission = await microphonePermission();
      if (hasPermission) {
        await _speechToText.listen(onResult: _onSpeechResult);
      } else {
        if (mounted) {
          _showSnackBar(
              'Microphone permission is required for speech recognition',
              isError: true);
        }
      }
    } else {
      accumulatedText = '';
      await _speechToText.stop();
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult && mounted) {
      setState(() {
        accumulatedText += '${result.recognizedWords} ';
        _notesController.text = accumulatedText;
      });
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? BauhausDesign.textLight : BauhausDesign.textDark;
    final hintColor =
        isDark ? BauhausDesign.textLight.withOpacity(0.4) : BauhausDesign.textMuted;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        title: Text(
          'Add Notes',
          style: BauhausDesign.getTextTheme(context).headlineMedium,
        ),
        elevation: 0.0,
        backgroundColor: BauhausDesign.surfaceLight,
        centerTitle: true,
        leading: BauhausIconButton(
          icon: Icons.arrow_back_ios_new,
          onPressed: () {
            Navigator.pop(context);
          },
          variant: BauhausActionVariant.ghost,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: BauhausDesign.neutral,
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          children: [
            Expanded(
              child: BauhausCard(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: TextField(
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  controller: _notesController,
                  style: BauhausDesign.getTextTheme(context)
                      .bodyMedium
                      ?.copyWith(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Add notes...',
                    hintStyle: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: hintColor,
                        ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space6),
            BauhausActionButton(
              text: _isSaving ? 'Saving...' : 'Save',
              isLoading: _isSaving,
              onPressed: _saveNotes,
              isFullWidth: true,
            ),
            // button with mic icon
            const SizedBox(height: BauhausDesign.space6),
            Text(
              !_isInitialized
                  ? 'Initializing...'
                  : _speechToText.isListening
                      ? accumulatedText.isEmpty
                          ? 'Listening...'
                          : accumulatedText
                      : _speechEnabled
                          ? 'Tap to start listening'
                          : 'Speech not available',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: (!_isInitialized || !_speechEnabled)
                        ? BauhausDesign.textMuted
                        : BauhausDesign.textDark,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: BauhausDesign.space2),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: InkWell(
                onTap: !_isInitialized || !_speechEnabled || _isSaving
                    ? null
                    : _toggleSpeech,
                child: Container(
                  decoration: BoxDecoration(
                    color: (!_isInitialized || !_speechEnabled || _isSaving)
                        ? BauhausDesign.neutral.withOpacity(0.3)
                        : BauhausDesign.primary,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                    boxShadow: const [BauhausDesign.shadowHard],
                  ),
                  child: Center(
                    child: Icon(
                      _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                      color: (!_isInitialized || !_speechEnabled || _isSaving)
                          ? BauhausDesign.textMuted
                          : BauhausDesign.surfaceWhite,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> microphonePermission() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      return true;
    } else {
      status = await Permission.microphone.request();
      return status.isGranted;
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.surfaceWhite,
              ),
        ),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
      ),
    );
  }

  void _saveNotes() async {
    if (_notesController.text.trim().isEmpty) {
      _showSnackBar('Please enter some notes before saving', isError: true);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final response = await apiMethod.uploadNotes(
        widget.userEmail,
        widget.clientEmail,
        _notesController.text.trim(),
      );

      if (!mounted) return;

      if (response.success) {
        _showSnackBar(response.message); // Success
        await Future.delayed(const Duration(seconds: 1)); // Wait for snackbar
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      } else {
        _showSnackBar(response.message, isError: true);
      }
    } catch (error) {
      _showSnackBar('An error occurred while saving notes', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
