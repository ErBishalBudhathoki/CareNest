import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';

class JobStatusWidget extends ConsumerStatefulWidget {
  final String jobId;
  final VoidCallback? onComplete;

  const JobStatusWidget({
    super.key,
    required this.jobId,
    this.onComplete,
  });

  @override
  ConsumerState<JobStatusWidget> createState() => _JobStatusWidgetState();
}

class _JobStatusWidgetState extends ConsumerState<JobStatusWidget> {
  late final ApiMethod _api;
  Timer? _timer;
  double _progress = 0.0;
  String _status = 'waiting';
  String? _error;
  String? _resultUrl;

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) => _checkStatus());
  }

  Future<void> _checkStatus() async {
    try {
      final response = await _api.get('api/jobs/${widget.jobId}');
      if (response['success'] == true) {
        final data = response['data'];
        final state = data['state'];
        final progress = (data['progress'] ?? 0).toDouble() / 100.0;

        if (mounted) {
          setState(() {
            _status = state;
            _progress = progress;
          });
        }

        if (state == 'completed') {
          _timer?.cancel();
          if (mounted) {
            setState(() {
              _resultUrl = data['result']['downloadUrl'];
              _progress = 1.0;
            });
          }
          widget.onComplete?.call();
        } else if (state == 'failed') {
          _timer?.cancel();
          if (mounted) {
            setState(() {
              _error = data['error'] ?? 'Job failed';
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error polling job status: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: BauhausTheme.red.withOpacity(0.1),
          border: Border.all(color: BauhausTheme.red),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: BauhausTheme.red),
            const SizedBox(width: 8),
            Expanded(child: Text(_error!)),
          ],
        ),
      );
    }

    if (_status == 'completed') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: BauhausTheme.blue.withOpacity(0.1),
          border: Border.all(color: BauhausTheme.blue),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: BauhausTheme.blue),
                const SizedBox(width: 8),
                const Text('Processing Complete'),
              ],
            ),
            if (_resultUrl != null) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Launch URL
                  debugPrint('Downloading: $_resultUrl');
                },
                child: const Text('Download Result'),
              ),
            ]
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BauhausTheme.blockDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Processing... ($_status)', style: BauhausTheme.subHeaderStyle),
              Text('${(_progress * 100).toInt()}%', style: BauhausTheme.bodyStyle),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(BauhausTheme.blue),
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
