import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';

/// A Constructivist-inspired stats grid.
/// Displays key metrics in massive, asymmetrical color blocks.
class MondrianGrid extends StatelessWidget {
  final String totalAmount;
  final String pendingAmount;
  final String approvedAmount;

  const MondrianGrid({
    super.key,
    required this.totalAmount,
    required this.pendingAmount,
    required this.approvedAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Row: Massive Total (Focus)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: BauhausDesign.primary,
            border: Border.all(color: BauhausDesign.neutral, width: 3),
            boxShadow: const [
              BoxShadow(
                color: BauhausDesign.neutral,
                offset: Offset(8, 8),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL SPEND',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      color: BauhausDesign.surfaceLight,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                totalAmount,
                style:
                    BauhausDesign.getTextTheme(context).displayLarge?.copyWith(
                          color: BauhausDesign.surfaceLight,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
              ),
            ],
          ),
        ),
        const SizedBox(height: BauhausDesign.space6),
        // Bottom Row: Split Pending/Approved
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pending (Accent/Yellow)
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.accent,
                  border: Border.all(color: BauhausDesign.neutral, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: BauhausDesign.neutral,
                      offset: Offset(6, 6),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.pending_actions,
                        size: 32, color: BauhausDesign.neutral),
                    const SizedBox(height: BauhausDesign.space4),
                    Text(
                      pendingAmount,
                      style: BauhausDesign.getTextTheme(context)
                          .headlineMedium
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'PENDING',
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
            // Approved (Secondary/Blue)
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary,
                  border: Border.all(color: BauhausDesign.neutral, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: BauhausDesign.neutral,
                      offset: Offset(6, 6),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 32, color: BauhausDesign.surfaceLight),
                    const SizedBox(height: BauhausDesign.space4),
                    Text(
                      approvedAmount,
                      style: BauhausDesign.getTextTheme(context)
                          .headlineMedium
                          ?.copyWith(
                            color: BauhausDesign.surfaceLight,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'APPROVED',
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: BauhausDesign.surfaceLight,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// A horizontal, high-contrast data strip.
/// Looks like a punched tape or ticket.
class DataStrip extends StatelessWidget {
  final String title;
  final String subtitle;
  final String rightValue;
  final String? status;
  final VoidCallback onTap;

  const DataStrip({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rightValue,
    this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: BauhausDesign.space2),
        width: double.infinity,
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border(
            top: BorderSide(color: BauhausDesign.neutral, width: 2),
            bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
            left: BorderSide(
                color: BauhausDesign.neutral, width: 6), // Thick left border
            right: BorderSide(color: BauhausDesign.neutral, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4, vertical: BauhausDesign.space4),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.neutral,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rightValue,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (status != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      color: BauhausDesign.neutral,
                      child: Text(
                        status!.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceLight,
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    )
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Startling block selector replacing standard tabs.
class BlockTabSelector extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const BlockTabSelector({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? BauhausDesign.neutral
                    : BauhausDesign.surfaceLight,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: isSelected
                    ? [] // No shadow when pressed "down"
                    : [
                        const BoxShadow(
                            color: BauhausDesign.neutral, offset: Offset(4, 4))
                      ],
              ),
              transform: isSelected
                  ? Matrix4.translationValues(2, 2, 0) // Press effect
                  : Matrix4.identity(),
              child: Text(
                tabs[index].toUpperCase(),
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      color: isSelected
                          ? BauhausDesign.surfaceLight
                          : BauhausDesign.textDark,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
