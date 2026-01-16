// Smart Assign Dialog
// AI-powered employee recommendation dialog with Bauhaus styling
//
// @file lib/app/features/schedule/widgets/smart_assign_dialog.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/app/features/schedule/models/recommendation_model.dart';

/// Dialog showing AI-powered employee recommendations
class SmartAssignDialog extends StatefulWidget {
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
  State<SmartAssignDialog> createState() => _SmartAssignDialogState();
}

class _SmartAssignDialogState extends State<SmartAssignDialog> {
  final ApiMethod _api = ApiMethod();
  
  List<RecommendationModel> _recommendations = [];
  bool _isLoading = true;
  String? _error;
  String? _selectedEmployeeEmail;
  bool _isAssigning = false;

  @override
  void initState() {
    super.initState();
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
              .map((e) => RecommendationModel.fromJson(e as Map<String, dynamic>))
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = response['error']?.toString() ?? 'Failed to load recommendations';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error loading recommendations: $e';
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
                        child: CircularProgressIndicator(color: BauhausDesign.primary),
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
              color: BauhausDesign.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.accent, width: 1.5),
              boxShadow: [BauhausDesign.shadowHardXs],
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
                  'Smart Assign',
                  style: GoogleFonts.oswald(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
                Text(
                  'AI-powered employee recommendations',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: BauhausDesign.neutral,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: BauhausDesign.neutral),
            style: IconButton.styleFrom(
              backgroundColor: BauhausDesign.backgroundLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                side: const BorderSide(color: BauhausDesign.neutral),
              ),
            ),
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
              color: BauhausDesign.error.withOpacity(0.1),
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
            _error ?? 'Unknown error',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: BauhausDesign.textDark,
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          TextButton.icon(
            onPressed: _loadRecommendations,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: TextButton.styleFrom(foregroundColor: BauhausDesign.primary),
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
              color: BauhausDesign.secondary.withOpacity(0.1),
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
            'No Available Employees',
            style: GoogleFonts.oswald(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: BauhausDesign.textDark,
            ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            'All employees have conflicts during this time slot',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: BauhausDesign.neutral,
            ),
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

  Widget _buildRecommendationCard(RecommendationModel rec, bool isSelected, int rank) {
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
              ? BauhausDesign.primary.withOpacity(0.05)
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
                          ? BauhausDesign.neutral.withOpacity(0.3)
                          : BauhausDesign.backgroundLight,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: rank == 0 ? BauhausDesign.neutral : BauhausDesign.neutral.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '#${rank + 1}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: rank == 0 ? BauhausDesign.textDark : BauhausDesign.neutral,
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
                  color: _getScoreColor(rec.matchScore).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: _getScoreColor(rec.matchScore), width: 1.5),
                ),
                child: Center(
                  child: Text(
                    rec.initials,
                    style: GoogleFonts.oswald(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _getScoreColor(rec.matchScore),
                    ),
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
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: BauhausDesign.textDark,
                      ),
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
                            color: BauhausDesign.neutral.withOpacity(0.7),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            rec.formattedDistance,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: BauhausDesign.neutral,
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space2),
                        ],
                        if (rec.skills.isNotEmpty)
                          Flexible(
                            child: Text(
                              rec.skills.take(2).join(', '),
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: BauhausDesign.neutral,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: BauhausDesign.space2),
              
              // Score
              _buildScoreWidget(rec.matchScore),
              
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
          style: GoogleFonts.oswald(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 50,
          height: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: score / 100,
              backgroundColor: BauhausDesign.neutral.withOpacity(0.2),
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
        border: Border(
          top: BorderSide(color: BauhausDesign.neutral, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: BauhausDesign.secondaryButtonStyle,
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.secondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: BauhausButton(
              text: _isAssigning ? 'Assigning...' : 'Assign',
              onPressed: _selectedEmployeeEmail != null && !_isAssigning
                  ? () {
                      setState(() => _isAssigning = true);
                      widget.onAssigned(_selectedEmployeeEmail!);
                    }
                  : null,
              icon: Icons.check,
            ),
          ),
        ],
      ),
    );
  }
}
