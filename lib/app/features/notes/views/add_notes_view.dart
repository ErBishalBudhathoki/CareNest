// create a UI to add notes with a button to save the notes, editable text view to edit notes and a button with a mic icon

import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/app/shared/widgets/flushbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class AddNotesView extends StatefulWidget {
  final String userEmail;
  final String clientEmail;
  final Map<String, dynamic>? clientDetails;
  const AddNotesView(
      {super.key,
      required this.userEmail,
      required this.clientEmail,
      this.clientDetails});

  @override
  _AddNotesViewState createState() => _AddNotesViewState();
}

class _AddNotesViewState extends State<AddNotesView> {
  late final TextEditingController _notesController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'add_notes_scaffold_key');
  FlushBarWidget flushBarWidget = FlushBarWidget();
  ApiMethod apiMethod = ApiMethod();

  late stt.SpeechToText _speechToText;
  bool _speechEnabled = false;
  late SharedPreferences _prefs;
  String accumulatedText = '';
  bool _isInitialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
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
        flushBarWidget
            .flushBar(
              title: 'Error',
              message: 'Failed to initialize speech recognition',
              backgroundColor: Colors.red,
              context: context,
            )
            .show(context);
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
          flushBarWidget
              .flushBar(
                title: 'Error',
                message:
                    'Microphone permission is required for speech recognition',
                backgroundColor: Colors.red,
                context: context,
              )
              .show(context);
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
    return Scaffold(
      key: _scaffoldKey, // key for flushbar
      appBar: AppBar(
        title: const Text(
          'Add Notes',
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: AppColors.colorWhite,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.colorBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.colorPrimary,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: TextField(
                    maxLines: null,
                    controller: _notesController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Add notes',
                      hintStyle: TextStyle(
                        color: AppColors.colorGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ButtonWidget(
              buttonText: _isSaving ? 'Saving...' : 'Save',
              buttonColor: AppColors.colorPrimary,
              textColor: Colors.white,
              isLoading: _isSaving,
              onPressed: _saveNotes,
            ),
            // button with mic icon
            const SizedBox(
              height: 20.0,
            ),
            Text(
              !_isInitialized
                  ? 'Initializing...'
                  : _speechToText.isListening
                      ? accumulatedText
                      : _speechEnabled
                          ? 'Tap to start listening...'
                          : 'Speech not available',
              style: TextStyle(
                color: !_isInitialized || !_speechEnabled
                    ? Colors.grey
                    : Colors.black,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                onPressed: !_isInitialized || !_speechEnabled || _isSaving
                    ? null
                    : _toggleSpeech,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.colorPrimary,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Icon(
                  _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                  color: (!_isInitialized || !_speechEnabled || _isSaving)
                      ? Colors.grey
                      : AppColors.colorWhite,
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

  void _saveNotes() async {
    if (_notesController.text.trim().isEmpty) {
      if (!mounted) return;
      flushBarWidget
          .flushBar(
            title: 'Error',
            message: 'Please enter some notes before saving',
            backgroundColor: Colors.red,
            context: context,
          )
          .show(context);
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

      final flushbar = flushBarWidget.flushBar(
        title: response.title,
        message: response.message,
        backgroundColor: response.backgroundColor,
        context: context,
        // duration: const Duration(seconds: 2),
      );

      // Await the flushbar and then pop if successful
      if (response.success) {
        await flushbar.show(context);
        // Ensure the widget is still mounted before popping
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      } else {
        // For errors, just show the flushbar without waiting
        flushbar.show(context);
      }
    } catch (error) {
      if (!mounted) return;
      flushBarWidget
          .flushBar(
            title: 'Error',
            message: 'An error occurred while saving notes',
            backgroundColor: Colors.red,
            context: context,
          )
          .show(context);
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
