import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:carenest/app/features/training_compliance/models/training_module.dart';

class TrainingModulesView extends ConsumerStatefulWidget {
  const TrainingModulesView({super.key});

  @override
  ConsumerState<TrainingModulesView> createState() => _TrainingModulesViewState();
}

class _TrainingModulesViewState extends ConsumerState<TrainingModulesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trainingViewModelProvider.notifier).loadModules();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(trainingViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text('Training Modules', style: BauhausDesign.getTextTheme(context).headlineLarge),
        backgroundColor: BauhausDesign.surfaceLight,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator(color: BauhausDesign.primary))
          : state.modules.isEmpty
              ? Center(
                  child: Text(
                    'No training modules available.',
                    style: BauhausDesign.getTextTheme(context).bodyLarge,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: state.modules.length,
                  separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space3),
                  itemBuilder: (context, index) {
                    final module = state.modules[index];
                    return _buildModuleCard(context, module);
                  },
                ),
    );
  }

  Widget _buildModuleCard(BuildContext context, TrainingModule module) {
    final isCompleted = module.userProgress?.status == 'Completed';
    final progress = module.userProgress?.progressPercentage ?? 0;

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BauhausDesign.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  module.title,
                  style: BauhausDesign.getTextTheme(context).headlineLarge,
                ),
              ),
              if (isCompleted)
                const Icon(Icons.check_circle, color: BauhausDesign.success, size: 24),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            module.description,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Icon(Icons.timer, size: 16, color: BauhausDesign.textDark.withOpacity(0.7)),
              const SizedBox(width: 4),
              Text(
                '${module.durationMinutes} min',
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
              const Spacer(),
              if (module.userProgress != null && !isCompleted)
                Text(
                  '$progress% Completed',
                  style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(color: BauhausDesign.primary),
                ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          SizedBox(
            width: double.infinity,
            child: BauhausButton(
              text: isCompleted ? 'Review' : (module.userProgress != null ? 'Continue' : 'Start'),
              backgroundColor: isCompleted ? BauhausDesign.secondary : BauhausDesign.primary,
              onPressed: () {
                // Navigate to detail/player view
                Navigator.push(context, MaterialPageRoute(builder: (_) => TrainingDetailView(module: module)));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TrainingDetailView extends ConsumerWidget {
  final TrainingModule module;

  const TrainingDetailView({super.key, required this.module});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(module.title, style: BauhausDesign.getTextTheme(context).headlineLarge),
        backgroundColor: BauhausDesign.surfaceLight,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              module.description,
              style: BauhausDesign.getTextTheme(context).bodyLarge,
            ),
            const SizedBox(height: BauhausDesign.space4),
            // Placeholder for content player (Video/Text)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral),
              ),
              child: Center(
                child: Icon(
                  module.contentType == 'Video' ? Icons.play_circle_fill : Icons.article,
                  size: 64,
                  color: BauhausDesign.textDark.withOpacity(0.5),
                ),
              ),
            ),
             const SizedBox(height: BauhausDesign.space4),
             Text('Content: ${module.contentType}', style: BauhausDesign.getTextTheme(context).headlineLarge),
             if (module.contentText != null) ...[
               const SizedBox(height: BauhausDesign.space2),
               Text(module.contentText!, style: BauhausDesign.getTextTheme(context).bodyMedium),
             ],
             if (module.contentUrl != null) ...[
               const SizedBox(height: BauhausDesign.space2),
               Text('Link: ${module.contentUrl}', style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(color: Colors.blue)),
             ],

            const SizedBox(height: BauhausDesign.space6),
            SizedBox(
              width: double.infinity,
              child: BauhausButton(
                text: 'Mark as Completed',
                onPressed: () {
                  ref.read(trainingViewModelProvider.notifier).updateProgress(module.id!, 'Completed', 100);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
