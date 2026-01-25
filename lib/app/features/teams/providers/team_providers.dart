
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/team_repository.dart';
import '../viewmodels/team_viewmodel.dart';

final teamViewModelProvider = ChangeNotifierProvider<TeamViewModel>((ref) {
  final repository = ref.watch(teamRepositoryProvider);
  return TeamViewModel(repository);
});
