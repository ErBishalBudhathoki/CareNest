import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:carenest/app/features/training_compliance/models/training_module.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingModulesView extends ConsumerStatefulWidget {
  const TrainingModulesView({super.key});

  @override
  ConsumerState<TrainingModulesView> createState() =>
      _TrainingModulesViewState();
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
        title: Text(
          AppLocalizations.of(context)!.trainingModulesTitle,
          style: BauhausDesign.getTextTheme(context).headlineLarge,
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary),
            )
          : state.modules.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.noTrainingModulesMessage,
                style: BauhausDesign.getTextTheme(context).bodyLarge,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              itemCount: state.modules.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: BauhausDesign.space3),
              itemBuilder: (context, index) {
                final module = state.modules[index];
                return _buildModuleCard(context, module);
              },
            ),
    );
  }

  Widget _buildModuleCard(BuildContext context, TrainingModule module) {
    final isCompleted =
        module.userProgress?.status.toLowerCase() == 'completed';
    final progress = module.userProgress?.progressPercentage ?? 0;

    return BauhausCard(
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
                const Icon(
                  Icons.check_circle,
                  color: BauhausDesign.success,
                  size: 24,
                ),
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
              Icon(
                Icons.timer,
                size: 16,
                color: BauhausDesign.textDark.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 4),
              Text(
                '${module.durationMinutes} min',
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
              const Spacer(),
              if (module.userProgress != null && !isCompleted)
                Text(
                  '$progress% Completed',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelLarge?.copyWith(color: BauhausDesign.primary),
                ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          SizedBox(
            width: double.infinity,
            child: BauhausButton(
              text: isCompleted
                  ? AppLocalizations.of(context)!.reviewButton
                  : (module.userProgress != null
                        ? AppLocalizations.of(context)!.continueButton
                        : AppLocalizations.of(context)!.startButton),
              backgroundColor: isCompleted
                  ? BauhausDesign.secondary
                  : BauhausDesign.primary,
              onPressed: () {
                // Navigate to detail/player view
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrainingDetailView(module: module),
                  ),
                );
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
        title: Text(
          module.title,
          style: BauhausDesign.getTextTheme(context).headlineLarge,
        ),
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
                color: BauhausDesign.backgroundLight,
                border: Border.all(color: BauhausDesign.neutral),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: Center(
                child: Icon(
                  module.contentType == AppLocalizations.of(context)!.videoType
                      ? Icons.play_circle_fill
                      : Icons.article,
                  size: 64,
                  color: BauhausDesign.textDark.withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              AppLocalizations.of(context)!.contentLabel(module.contentType),
              style: BauhausDesign.getTextTheme(context).headlineLarge,
            ),
            if (module.contentText != null) ...[
              const SizedBox(height: BauhausDesign.space2),
              Text(
                module.contentText!,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ],
            if (module.contentUrl != null) ...[
              const SizedBox(height: BauhausDesign.space2),
              GestureDetector(
                onTap: () async {
                  final uri = Uri.tryParse(module.contentUrl!);
                  if (uri != null) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.linkLabel(module.contentUrl!),
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(
                        color: BauhausDesign.secondary,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ],

            const SizedBox(height: BauhausDesign.space6),
            SizedBox(
              width: double.infinity,
              child: BauhausButton(
                text: AppLocalizations.of(context)!.markAsCompletedButton,
                onPressed: () {
                  ref
                      .read(trainingViewModelProvider.notifier)
                      .updateProgress(module.id!, 'completed', 100);
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
