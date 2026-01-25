
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/voice_providers.dart';

class VoiceAssistantView extends ConsumerStatefulWidget {
  const VoiceAssistantView({super.key});

  @override
  ConsumerState<VoiceAssistantView> createState() => _VoiceAssistantViewState();
}

class _VoiceAssistantViewState extends ConsumerState<VoiceAssistantView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(voiceViewModelProvider).loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(voiceViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Voice Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Show newest at bottom (simulated chat) or top if strict history
              itemCount: viewModel.history.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final command = viewModel.history[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"${command.commandText}"',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Chip(
                              label: Text(command.detectedIntent),
                              backgroundColor: Colors.purple.withOpacity(0.1),
                            ),
                            const Spacer(),
                            Text(
                              command.executed ? 'Executed' : 'Failed',
                              style: TextStyle(
                                color: command.executed ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (command.parameters.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Params: ${command.parameters}',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (viewModel.isProcessing)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a command or tap mic...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => _processCommand(value),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  onPressed: () {
                    // Simulate voice input for now
                    if (_controller.text.isNotEmpty) {
                      _processCommand(_controller.text);
                    } else {
                      // Demo mode: cycle through examples
                      const examples = [
                        "Reschedule my meeting with John to 3 PM",
                        "Snooze all Slack messages for 2 hours",
                        "Broadcast emergency to the team",
                      ];
                      final random = examples[DateTime.now().second % examples.length];
                      _controller.text = random;
                    }
                  },
                  child: const Icon(Icons.mic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _processCommand(String text) {
    if (text.isEmpty) return;
    ref.read(voiceViewModelProvider).processCommand(text);
    _controller.clear();
  }
}
