import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/client/views/client_list_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_list_view.dart';
import 'package:carenest/app/features/notifications/views/notification_list_view.dart';
import 'package:carenest/app/features/schedule/views/schedule_dashboard_screen.dart';
import 'package:carenest/app/features/voice_assistant/models/voice_models.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../providers/voice_providers.dart';

class VoiceAssistantView extends ConsumerStatefulWidget {
  const VoiceAssistantView({super.key});

  @override
  ConsumerState<VoiceAssistantView> createState() => _VoiceAssistantViewState();
}

class _VoiceAssistantViewState extends ConsumerState<VoiceAssistantView> {
  final TextEditingController _controller = TextEditingController();
  final SharedPreferencesUtils _prefs = SharedPreferencesUtils();
  late final stt.SpeechToText _speechToText;

  bool _speechEnabled = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
    _initializeVoiceAssistant();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(voiceViewModelProvider).loadHistory();
    });
  }

  Future<void> _initializeVoiceAssistant() async {
    try {
      await _prefs.init();
      final isAvailable = await _speechToText.initialize();
      if (!mounted) return;
      setState(() {
        _speechEnabled = isAvailable;
        _isInitialized = true;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _speechEnabled = false;
        _isInitialized = true;
      });
      _showSnackBar(
        'Failed to initialize speech recognition.',
        isError: true,
      );
    }
  }

  Future<bool> _ensureMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) return true;
    status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> _toggleSpeech() async {
    if (!_isInitialized || !_speechEnabled) {
      _showSnackBar('Speech recognition is not available on this device.',
          isError: true);
      return;
    }

    if (_speechToText.isListening) {
      await _speechToText.stop();
      if (mounted) setState(() {});
      return;
    }

    final hasPermission = await _ensureMicrophonePermission();
    if (!hasPermission) {
      _showSnackBar(
        'Microphone permission is required for voice commands.',
        isError: true,
      );
      return;
    }

    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenMode: stt.ListenMode.confirmation,
    );

    if (mounted) setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;

    setState(() {
      _controller.text = result.recognizedWords;
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    });
  }

  Future<void> _processCommand(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final command = await ref.read(voiceViewModelProvider).processCommand(
      trimmed,
      context: const {
        'sourceScreen': 'voice_assistant',
        'assistantScope': 'app_only',
      },
    );

    _controller.clear();

    if (!mounted) return;

    if (command == null) {
      final error = ref.read(voiceViewModelProvider).errorMessage;
      if (error != null && error.isNotEmpty) {
        _showSnackBar(error, isError: true);
      }
      return;
    }

    if (command.actionType == 'navigate' && command.canOpenRoute) {
      await _openSuggestedRoute(command);
      return;
    }

    if (command.errorMessage != null && command.errorMessage!.isNotEmpty) {
      _showSnackBar(command.errorMessage!, isError: true);
    }
  }

  Future<void> _openSuggestedRoute(VoiceCommand command) async {
    final suggestedRoute = command.suggestedRoute;
    if (suggestedRoute == null || suggestedRoute.isEmpty) return;

    await _prefs.init();
    final organizationId = _prefs.getOrganizationId() ?? '';
    final userEmail = await _prefs.getUserEmailFromSharedPreferences() ?? '';

    Widget? destination;
    switch (suggestedRoute) {
      case 'client_list':
        destination = const ClientListView();
        break;
      case 'invoice_list':
        if (organizationId.isEmpty || userEmail.isEmpty) {
          _showSnackBar('User session data is missing for invoices.',
              isError: true);
          return;
        }
        destination = InvoiceListView(
          organizationId: organizationId,
          userEmail: userEmail,
        );
        break;
      case 'schedule_dashboard':
        if (organizationId.isEmpty) {
          _showSnackBar('Organization context is required for schedule.',
              isError: true);
          return;
        }
        destination = ScheduleDashboardScreen(
          organizationId: organizationId,
          userEmail: userEmail.isEmpty ? null : userEmail,
          isAdmin: true,
        );
        break;
      case 'notification_center':
        destination = const NotificationListView();
        break;
      case 'admin_dashboard':
        if (userEmail.isEmpty) {
          _showSnackBar('User session data is missing for dashboard.',
              isError: true);
          return;
        }
        destination = AdminDashboardView(
          email: userEmail,
          organizationId: organizationId.isEmpty ? null : organizationId,
        );
        break;
      default:
        return;
    }

    if (!mounted || destination == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => destination!),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
      ),
    );
  }

  @override
  void dispose() {
    _speechToText.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(voiceViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        title: const Text('Voice Assistant'),
        backgroundColor: BauhausDesign.surfaceLight,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          _buildIntroCard(),
          if (viewModel.errorMessage != null &&
              viewModel.errorMessage!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildErrorBanner(viewModel.errorMessage!),
            ),
          Expanded(
            child: viewModel.history.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: viewModel.history.length,
                    itemBuilder: (context, index) =>
                        _buildCommandCard(viewModel.history[index]),
                  ),
          ),
          if (viewModel.isProcessing)
            const LinearProgressIndicator(minHeight: 3),
          _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildIntroCard() {
    const capabilities = [
      'Dashboard summary',
      'Clients',
      'Schedule',
      'Invoices',
      'Notifications',
      'Open screens',
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App-scoped assistant',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'This assistant is limited to in-app tasks only. Try commands like "show today summary", "find client John", "show overdue invoices", or "open schedule".',
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: capabilities
                .map(
                  (capability) => Chip(
                    label: Text(capability),
                    backgroundColor: BauhausDesign.surfaceLight,
                    side: const BorderSide(color: BauhausDesign.neutral),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(String message) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BauhausDesign.error.withOpacity(0.08),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.error.withOpacity(0.3)),
      ),
      child: Text(
        message,
        style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              color: BauhausDesign.error,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'No commands yet. Ask about clients, schedule, invoices, notifications, or app navigation.',
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    final isListening = _speechToText.isListening;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border(
            top: BorderSide(color: BauhausDesign.neutral),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Ask about this app...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: _processCommand,
              ),
            ),
            const SizedBox(width: 12),
            FloatingActionButton.small(
              heroTag: 'voice-assistant-mic',
              onPressed: _toggleSpeech,
              backgroundColor: isListening
                  ? BauhausDesign.error
                  : (_speechEnabled
                      ? BauhausDesign.primary
                      : BauhausDesign.neutral),
              foregroundColor: BauhausDesign.surfaceWhite,
              child: Icon(isListening ? Icons.mic : Icons.mic_none),
            ),
            const SizedBox(width: 8),
            FloatingActionButton.small(
              heroTag: 'voice-assistant-send',
              onPressed: () => _processCommand(_controller.text),
              backgroundColor: BauhausDesign.secondary,
              foregroundColor: BauhausDesign.surfaceWhite,
              child: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommandCard(VoiceCommand command) {
    final preview = _buildResultPreview(command);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: BauhausDesign.surfaceWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        side: const BorderSide(color: BauhausDesign.neutral),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"${command.commandText}"',
              style: BauhausDesign.getTextTheme(context).titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildStatusChip(
                  label: command.detectedIntent,
                  backgroundColor: BauhausDesign.primary.withOpacity(0.08),
                  foregroundColor: BauhausDesign.primary,
                ),
                _buildStatusChip(
                  label: command.executed ? 'Executed' : 'Needs attention',
                  backgroundColor: command.executed
                      ? BauhausDesign.success.withOpacity(0.08)
                      : BauhausDesign.warning.withOpacity(0.08),
                  foregroundColor: command.executed
                      ? BauhausDesign.success
                      : BauhausDesign.warning,
                ),
                if (command.actionType.isNotEmpty)
                  _buildStatusChip(
                    label: command.actionType,
                    backgroundColor: BauhausDesign.surfaceLight,
                    foregroundColor: BauhausDesign.textDark,
                  ),
              ],
            ),
            if (command.responseText.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                command.responseText,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ],
            if (preview != null) ...[
              const SizedBox(height: 12),
              preview,
            ],
            if (command.suggestions.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: command.suggestions
                    .map(
                      (suggestion) => ActionChip(
                        label: Text(suggestion),
                        onPressed: () {
                          _controller.text = suggestion;
                          _controller.selection = TextSelection.collapsed(
                            offset: _controller.text.length,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
            if (command.canOpenRoute) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: () => _openSuggestedRoute(command),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open in app'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip({
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return Chip(
      label: Text(label),
      backgroundColor: backgroundColor,
      labelStyle: TextStyle(
        color: foregroundColor,
        fontWeight: FontWeight.w700,
      ),
      side: BorderSide(color: foregroundColor.withOpacity(0.15)),
    );
  }

  Widget? _buildResultPreview(VoiceCommand command) {
    final data = command.resultData;
    if (data == null || data.isEmpty) return null;

    switch (command.detectedIntent) {
      case 'capabilities_help':
        final capabilities =
            (data['capabilities'] as List<dynamic>? ?? const [])
                .map((item) => item.toString())
                .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: capabilities
              .map(
                (capability) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('• $capability'),
                ),
              )
              .toList(),
        );
      case 'dashboard_summary':
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildMetricTile(
              'Appointments',
              '${data['appointmentsToday'] ?? 0}',
            ),
            _buildMetricTile(
              'Clients',
              '${data['activeClients'] ?? 0}',
            ),
            _buildMetricTile(
              'Unread',
              '${data['unreadNotifications'] ?? 0}',
            ),
          ],
        );
      case 'client_lookup':
        return _buildPreviewList(
          (data['clients'] as List<dynamic>? ?? const [])
              .map(
                (item) => _renderClientPreview(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList(),
        );
      case 'schedule_overview':
        return _buildPreviewList(
          (data['items'] as List<dynamic>? ?? const [])
              .map(
                (item) => _renderSchedulePreview(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList(),
        );
      case 'invoice_summary':
        return _buildPreviewList(
          (data['invoices'] as List<dynamic>? ?? const [])
              .map(
                (item) => _renderInvoicePreview(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList(),
        );
      case 'notification_summary':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unread: ${data['unreadCount'] ?? 0}',
              style: BauhausDesign.getTextTheme(context).titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            _buildPreviewList(
              (data['notifications'] as List<dynamic>? ?? const [])
                  .map(
                    (item) => _renderNotificationPreview(
                      Map<String, dynamic>.from(item as Map),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      case 'mark_notifications_read':
        return Text(
          'Marked: ${data['markedCount'] ?? 0}',
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        );
      default:
        return null;
    }
  }

  Widget _buildMetricTile(String label, String value) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewList(List<Widget> children) {
    if (children.isEmpty) {
      return Text(
        'No matching app data to preview.',
        style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              color: BauhausDesign.textMuted,
            ),
      );
    }

    return Column(
      children: children
          .map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: child,
            ),
          )
          .toList(),
    );
  }

  Widget _renderClientPreview(Map<String, dynamic> client) {
    return _previewTile(
      title: client['name']?.toString() ?? 'Unknown client',
      subtitle: [
        client['email']?.toString(),
        client['phone']?.toString(),
      ].whereType<String>().where((value) => value.isNotEmpty).join(' • '),
    );
  }

  Widget _renderSchedulePreview(Map<String, dynamic> item) {
    final date = item['date']?.toString() ?? '';
    final start = item['startTime']?.toString() ?? '';
    final end = item['endTime']?.toString() ?? '';
    final client = item['clientName']?.toString() ?? 'Unknown client';

    return _previewTile(
      title: client,
      subtitle: '$date • $start - $end',
    );
  }

  Widget _renderInvoicePreview(Map<String, dynamic> invoice) {
    final invoiceNumber = invoice['invoiceNumber']?.toString() ?? 'Invoice';
    final clientName = invoice['clientName']?.toString() ?? 'Unknown client';
    final status = invoice['paymentStatus']?.toString() ?? 'unknown';
    final total = invoice['totalAmount'];

    return _previewTile(
      title: invoiceNumber,
      subtitle: '$clientName • $status • \$${total ?? 0}',
    );
  }

  Widget _renderNotificationPreview(Map<String, dynamic> notification) {
    final title = notification['title']?.toString() ?? 'Notification';
    final status = notification['status']?.toString() ?? 'unknown';
    final body = notification['body']?.toString() ?? '';

    return _previewTile(
      title: '$title • $status',
      subtitle: body,
    );
  }

  Widget _previewTile({
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textMuted,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
