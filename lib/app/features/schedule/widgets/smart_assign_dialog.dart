// Smart Assign Dialog
// AI-powered employee recommendation dialog with Bauhaus styling
//
// @file lib/app/features/schedule/widgets/smart_assign_dialog.dart

import 'package:carenest/app/features/schedule/models/recommendation_model.dart';
import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Dialog showing AI-powered employee recommendations
class SmartAssignDialog extends ConsumerStatefulWidget {
  final String organizationId;
  final ShiftModel shift;
  final Function(String employeeEmail) onAssigned;

  const SmartAssignDialog({
    super.key,
    required this.organizationId,
    required this.shift,
    required this.onAssigned,
  });

  @override
  ConsumerState<SmartAssignDialog> createState() => _SmartAssignDialogState();
}

class _SmartAssignDialogState extends ConsumerState<SmartAssignDialog> {
  late final ApiMethod _api;

  List<RecommendationModel> _recommendations = [];
  bool _isLoading = true;
  String? _error;
  String? _selectedEmployeeEmail;
  bool _isAssigning = false;

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _api.getScheduleRecommendations(
        organizationId: widget.organizationId,
        clientEmail: widget.shift.clientEmail,
        startTime: widget.shift.startTime,
        endTime: widget.shift.endTime,
        latitude: widget.shift.location?.latitude,
        longitude: widget.shift.location?.longitude,
      );

      if (response['success'] == true) {
        final recsData = response['recommendations'] as List<dynamic>? ?? [];
        setState(() {
          _recommendations = recsData
              .map(
                (e) => RecommendationModel.fromJson(e as Map<String, dynamic>),
              )
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error =
              response['error']?.toString() ??
              AppLocalizations.of(context)!.failedToLoadRecommendations;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = AppLocalizations.of(
          context,
        )!.errorLoadingRecommendations(e.toString());
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 600),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          boxShadow: [BauhausDesign.shadowHard],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Flexible(
              child: _isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(BauhausDesign.space8),
                        child: CircularProgressIndicator(
                          color: BauhausDesign.primary,
                        ),
                      ),
                    )
                  : _error != null
                  ? _buildErrorState()
                  : _recommendations.isEmpty
                  ? _buildEmptyState()
                  : _buildRecommendationsList(),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.accent, width: 1.5),
              boxShadow: const [BauhausDesign.shadowHardXs],
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: BauhausDesign.accent,
              size: 24,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.smartAssign,
                  style: BauhausDesign.getTextTheme(context).titleLarge,
                ),
                Text(
                  'AI-powered employee recommendations',
                  style: BauhausDesign.getTextTheme(context).bodySmall,
                ),
              ],
            ),
          ),
          BauhausIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icons.close,
            variant: BauhausActionVariant.ghost,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(color: BauhausDesign.error),
            ),
            child: const Icon(
              Icons.error_outline,
              color: BauhausDesign.error,
              size: 32,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            _error ?? AppLocalizations.of(context)!.unknownError,
            textAlign: TextAlign.center,
            style: BauhausDesign.getTextTheme(context).bodyLarge,
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausActionButton(
            onPressed: _loadRecommendations,
            icon: Icons.refresh,
            text: AppLocalizations.of(context)!.retryButton,
            variant: BauhausActionVariant.primary,
            isSmall: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(color: BauhausDesign.secondary),
            ),
            child: const Icon(
              Icons.people_outline,
              color: BauhausDesign.secondary,
              size: 32,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            AppLocalizations.of(context)!.noAvailableEmployees,
            style: BauhausDesign.getTextTheme(context).titleMedium,
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            AppLocalizations.of(context)!.allEmployeesConflict,
            textAlign: TextAlign.center,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      shrinkWrap: true,
      itemCount: _recommendations.length,
      itemBuilder: (context, index) {
        final rec = _recommendations[index];
        final isSelected = _selectedEmployeeEmail == rec.employeeEmail;

        return Padding(
          padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
          child: _buildRecommendationCard(rec, isSelected, index),
        );
      },
    );
  }

  Widget _buildRecommendationCard(
    RecommendationModel rec,
    bool isSelected,
    int rank,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedEmployeeEmail = rec.employeeEmail;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? BauhausDesign.primary.withValues(alpha: 0.05)
              : BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(
            color: isSelected ? BauhausDesign.primary : BauhausDesign.neutral,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [BauhausDesign.shadowHardSm] : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          child: Row(
            children: [
              // Rank badge
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: rank == 0
                      ? BauhausDesign.accent
                      : rank == 1
                      ? BauhausDesign.neutral.withValues(alpha: 0.3)
                      : BauhausDesign.backgroundLight,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: rank == 0
                        ? BauhausDesign.neutral
                        : BauhausDesign.neutral.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '#${rank + 1}',
                    style: BauhausDesign.getTextTheme(context).labelSmall
                        ?.copyWith(
                          color: rank == 0
                              ? BauhausDesign.textDark
                              : BauhausDesign.neutral,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),

              const SizedBox(width: BauhausDesign.space3),

              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getScoreColor(rec.matchScore).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: _getScoreColor(rec.matchScore),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    rec.initials,
                    style: BauhausDesign.getTextTheme(context).titleMedium
                        ?.copyWith(color: _getScoreColor(rec.matchScore)),
                  ),
                ),
              ),

              const SizedBox(width: BauhausDesign.space3),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rec.displayName,
                      style: BauhausDesign.getTextTheme(context).titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (rec.distanceKm != null) ...[
                          Icon(
                            Icons.place,
                            size: 12,
                            color: BauhausDesign.neutral.withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            rec.formattedDistance,
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).bodySmall,
                          ),
                          const SizedBox(width: BauhausDesign.space2),
                        ],
                        if (rec.skills.isNotEmpty)
                          Flexible(
                            child: Text(
                              rec.skills.take(2).join(', '),
                              style: BauhausDesign.getTextTheme(
                                context,
                              ).bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                    if (rec.reasoning != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: BauhausDesign.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 10,
                              color: BauhausDesign.accent,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                rec.reasoning!,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                      color: BauhausDesign.textDark,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: BauhausDesign.space2),

              // Score
              _buildScoreWidget(rec.aiScore ?? rec.matchScore),

              if (isSelected)
                const Padding(
                  padding: EdgeInsets.only(left: BauhausDesign.space2),
                  child: Icon(
                    Icons.check_circle,
                    color: BauhausDesign.primary,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreWidget(int score) {
    final color = _getScoreColor(score);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$score%',
          style: BauhausDesign.getTextTheme(
            context,
          ).titleMedium?.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 50,
          height: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: score / 100,
              backgroundColor: BauhausDesign.neutral.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return BauhausDesign.success;
    if (score >= 60) return BauhausDesign.secondary;
    if (score >= 40) return BauhausDesign.accent;
    return BauhausDesign.error;
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.backgroundLight,
        border: Border(top: BorderSide(color: BauhausDesign.neutral, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: BauhausActionButton(
              onPressed: () => Navigator.of(context).pop(),
              text: AppLocalizations.of(context)!.cancelButton,
              variant: BauhausActionVariant.secondary,
              isOutlined: true,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: BauhausActionButton(
              text: _isAssigning
                  ? AppLocalizations.of(context)!.assigning
                  : AppLocalizations.of(context)!.assignButton,
              onPressed: _selectedEmployeeEmail != null && !_isAssigning
                  ? () {
                      setState(() => _isAssigning = true);
                      widget.onAssigned(_selectedEmployeeEmail!);
                    }
                  : null,
              icon: Icons.check,
              variant: BauhausActionVariant.primary,
            ),
          ),
        ],
      ),
    );
  }
}
