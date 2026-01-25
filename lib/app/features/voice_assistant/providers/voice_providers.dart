
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/voice_repository.dart';
import '../viewmodels/voice_viewmodel.dart';

final voiceViewModelProvider = ChangeNotifierProvider<VoiceViewModel>((ref) {
  final repository = ref.watch(voiceRepositoryProvider);
  return VoiceViewModel(repository);
});
