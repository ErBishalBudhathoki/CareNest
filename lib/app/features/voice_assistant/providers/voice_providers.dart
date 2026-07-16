
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/voice_viewmodel.dart';

final voiceViewModelProvider = NotifierProvider<VoiceViewModel, VoiceState>(VoiceViewModel.new);
