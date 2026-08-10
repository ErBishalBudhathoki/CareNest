import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final adminFeedbackFeedProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
      final api = ref.read(apiMethodProvider);
      final response = await api.getFeedbackFeed(limit: 50);
      if (response['success'] == true && response['data'] is List) {
        final rawList = response['data'] as List;
        return rawList
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }

      final message = response['message']?.toString().trim();
      throw Exception(
        message?.isNotEmpty == true
            ? message
            : 'Failed to load client feedback',
      );
    });

class AdminFeedbackFeedView extends ConsumerWidget {
  const AdminFeedbackFeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(adminFeedbackFeedProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        title: Text(
          'Client Feedback',
          style: GoogleFonts.oswald(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
            letterSpacing: 1.1,
          ),
        ),
        foregroundColor: BauhausDesign.textDark,
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(adminFeedbackFeedProvider),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: feedbackState.when(
        loading: () => const Center(child: BauhausLoadingState()),
        error: (error, _) => Center(
          child: BauhausErrorState(
            title: 'Unable to Load Feedback',
            message: error.toString(),
            onRetry: () => ref.invalidate(adminFeedbackFeedProvider),
          ),
        ),
        data: (feedbacks) {
          if (feedbacks.isEmpty) {
            return const Center(
              child: BauhausEmptyState(
                title: 'No Feedback Yet',
                message: 'Client feedback will appear here once submitted.',
              ),
            );
          }

          return RefreshIndicator(
            color: BauhausDesign.primary,
            backgroundColor: BauhausDesign.surfaceWhite,
            onRefresh: () async {
              ref.invalidate(adminFeedbackFeedProvider);
              await ref.read(adminFeedbackFeedProvider.future);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              itemCount: feedbacks.length + 1,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: BauhausDesign.space4),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const BauhausSectionHeader(
                    title: 'LATEST FEEDBACK',
                    subtitle: 'Service ratings and client comments',
                  );
                }

                final feedback = feedbacks[index - 1];
                return _FeedbackCard(data: feedback);
              },
            ),
          );
        },
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _FeedbackCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final serviceName = (data['serviceName'] ?? 'Service').toString();
    final workerName = (data['workerName'] ?? 'Unknown Worker').toString();
    final clientName = (data['clientName'] ?? 'Client').toString();
    final rating = _asInt(data['rating']);
    final comments = (data['comments'] ?? '').toString().trim();
    final submittedAt = _formatDate(data['submittedAt']);

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.rate_review_outlined,
                  color: BauhausDesign.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).labelLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      'Client: $clientName',
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                    ),
                  ],
                ),
              ),
              _RatingPill(rating: rating),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            'Worker: $workerName',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
          ),
          const SizedBox(height: BauhausDesign.space2),
          if (comments.isNotEmpty)
            Text(
              comments,
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            )
          else
            Text(
              'No additional comments provided.',
              style: BauhausDesign.getTextTheme(
                context,
              ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
            ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            submittedAt,
            style: BauhausDesign.getTextTheme(
              context,
            ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
          ),
        ],
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  final int rating;

  const _RatingPill({required this.rating});

  @override
  Widget build(BuildContext context) {
    final safeRating = rating.clamp(0, 5);
    final color = safeRating >= 4
        ? BauhausDesign.success
        : safeRating >= 3
        ? BauhausDesign.warning
        : BauhausDesign.error;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 14, color: BauhausDesign.surfaceWhite),
          const SizedBox(width: BauhausDesign.space1),
          Text(
            safeRating.toString(),
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.surfaceWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is double) return value.round();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

String _formatDate(dynamic value) {
  final raw = value?.toString();
  if (raw == null || raw.trim().isEmpty) return 'Submitted date unknown';
  final parsed = DateTime.tryParse(raw);
  if (parsed == null) return raw;
  return DateFormat('dd MMM yyyy, h:mm a').format(parsed.toLocal());
}
