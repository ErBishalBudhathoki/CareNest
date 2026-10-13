import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Renders a progress-note template as a sectioned form and returns the
/// collected answers keyed by section key (Phase 2).
///
/// Supported section types: text, longText, select, checkbox, number, voice.
/// The widget is intentionally self-contained so it can be embedded in the
/// existing notes screen without changing the free-text flow.
class StructuredNoteComposer extends StatefulWidget {
  const StructuredNoteComposer({
    super.key,
    required this.template,
    required this.onSubmit,
    this.isSubmitting = false,
  });

  /// Template document: `{ name, sections: [{ key, label, type, required, options }] }`.
  final Map<String, dynamic> template;

  /// Called with the collected `{ sectionKey: value }` map.
  final Future<void> Function(Map<String, dynamic> data) onSubmit;

  final bool isSubmitting;

  @override
  State<StructuredNoteComposer> createState() => _StructuredNoteComposerState();
}

class _StructuredNoteComposerState extends State<StructuredNoteComposer> {
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, dynamic> _values = {};
  final Map<String, String?> _errors = {};

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _speechAvailable = false;
  String? _listeningKey;

  List<Map<String, dynamic>> get _sections {
    final raw = widget.template['sections'];
    if (raw is! List) return const [];
    final sections = raw.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
    sections.sort((a, b) => ((a['order'] ?? 0) as num).compareTo((b['order'] ?? 0) as num));
    return sections;
  }

  @override
  void initState() {
    super.initState();
    for (final section in _sections) {
      final key = section['key']?.toString() ?? '';
      if (key.isEmpty) continue;
      final type = (section['type'] ?? 'text').toString();
      if (type == 'checkbox') {
        _values[key] = false;
      } else if (type == 'select') {
        _values[key] = null;
      } else {
        _textControllers[key] = TextEditingController();
      }
    }
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    try {
      final available = await _speech.initialize();
      if (mounted) setState(() => _speechAvailable = available);
    } catch (_) {
      // Speech is an optional enhancement; ignore failures.
    }
  }

  @override
  void dispose() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    _speech.stop();
    super.dispose();
  }

  void _onSpeechResult(String key, SpeechRecognitionResult result) {
    if (result.finalResult && mounted) {
      final controller = _textControllers[key];
      if (controller != null) {
        final separator = controller.text.isEmpty ? '' : ' ';
        controller.text = '${controller.text}$separator${result.recognizedWords}';
      }
    }
  }

  Future<void> _toggleSpeech(String key) async {
    if (_speech.isListening) {
      await _speech.stop();
      if (mounted) setState(() => _listeningKey = null);
      return;
    }
    final status = await Permission.microphone.request();
    if (!status.isGranted) return;
    if (mounted) setState(() => _listeningKey = key);
    await _speech.listen(onResult: (r) => _onSpeechResult(key, r));
  }

  Map<String, dynamic> _collect() {
    final data = <String, dynamic>{};
    for (final section in _sections) {
      final key = section['key']?.toString() ?? '';
      if (key.isEmpty) continue;
      final type = (section['type'] ?? 'text').toString();
      if (type == 'checkbox') {
        data[key] = _values[key] == true;
      } else if (type == 'select') {
        data[key] = _values[key];
      } else if (type == 'number') {
        data[key] = num.tryParse(_textControllers[key]?.text.trim() ?? '');
      } else {
        data[key] = _textControllers[key]?.text.trim() ?? '';
      }
    }
    return data;
  }

  bool _validate() {
    final errors = <String, String?>{};
    for (final section in _sections) {
      if (section['required'] != true) continue;
      final key = section['key']?.toString() ?? '';
      final type = (section['type'] ?? 'text').toString();
      final value = type == 'checkbox'
          ? _values[key]
          : type == 'select'
          ? _values[key]
          : _textControllers[key]?.text.trim();
      final empty = value == null ||
          (value is String && value.isEmpty) ||
          (type == 'checkbox' && value != true);
      if (empty) errors[key] = 'This field is required';
    }
    setState(() => _errors
      ..clear()
      ..addAll(errors));
    return errors.isEmpty;
  }

  Future<void> _submit() async {
    if (!_validate()) return;
    await widget.onSubmit(_collect());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = _sections;

    if (sections.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'This template has no sections.',
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final section in sections) _buildSection(context, section),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: widget.isSubmitting ? null : _submit,
          child: widget.isSubmitting
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save note'),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, Map<String, dynamic> section) {
    final theme = Theme.of(context);
    final key = section['key']?.toString() ?? '';
    final label = section['label']?.toString() ?? key;
    final type = (section['type'] ?? 'text').toString();
    final required = section['required'] == true;
    final error = _errors[key];

    Widget field;
    switch (type) {
      case 'checkbox':
        field = CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: _values[key] == true,
          title: Text(label),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (v) => setState(() => _values[key] = v ?? false),
        );
        break;
      case 'select':
        final options = (section['options'] as List?)?.map((e) => e.toString()).toList() ?? [];
        field = DropdownButtonFormField<String>(
          initialValue: _values[key] as String?,
          decoration: InputDecoration(
            labelText: required ? '$label *' : label,
            border: const OutlineInputBorder(),
            errorText: error,
          ),
          items: options
              .map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList(),
          onChanged: (v) => setState(() => _values[key] = v),
        );
        break;
      case 'number':
        field = TextField(
          controller: _textControllers[key],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
          decoration: InputDecoration(
            labelText: required ? '$label *' : label,
            border: const OutlineInputBorder(),
            errorText: error,
          ),
        );
        break;
      case 'longText':
      case 'voice':
      case 'text':
      default:
        final multiline = type != 'text';
        field = TextField(
          controller: _textControllers[key],
          maxLines: multiline ? 4 : 1,
          minLines: multiline ? 3 : 1,
          decoration: InputDecoration(
            labelText: required ? '$label *' : label,
            border: const OutlineInputBorder(),
            errorText: error,
            suffixIcon: (type == 'voice' || type == 'longText') && _speechAvailable
                ? IconButton(
                    tooltip: 'Dictate',
                    icon: Icon(
                      _listeningKey == key ? Icons.mic : Icons.mic_none,
                      color: _listeningKey == key ? theme.colorScheme.primary : null,
                    ),
                    onPressed: () => _toggleSpeech(key),
                  )
                : null,
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          field,
          if (section['helpText'] != null &&
              section['helpText'].toString().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(
                section['helpText'].toString(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
