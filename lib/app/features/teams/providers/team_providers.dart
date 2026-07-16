import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/team_viewmodel.dart';

final teamViewModelProvider = NotifierProvider<TeamViewModel, TeamState>(
  TeamViewModel.new,
);
