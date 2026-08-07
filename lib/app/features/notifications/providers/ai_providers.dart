import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/ai_viewmodel.dart';

final aiViewModelProvider = NotifierProvider<AiViewModel, AiState>(
  AiViewModel.new,
);
