
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/ai_repository.dart';
import '../viewmodels/ai_viewmodel.dart';

final aiViewModelProvider = ChangeNotifierProvider<AiViewModel>((ref) {
  final repository = ref.watch(aiRepositoryProvider);
  return AiViewModel(repository);
});
