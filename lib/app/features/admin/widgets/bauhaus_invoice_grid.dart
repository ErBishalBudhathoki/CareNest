import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';

/// A bold, colorful action block following Bauhaus design principles.
/// Used for creating visually striking action tiles with full-color backgrounds.
class BauhausActionBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;
  final double? height;

  const BauhausActionBlock({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(
              color: BauhausDesign.neutral,
              width: 2.5,
            ),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceLight,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: 2,
                  ),
                  boxShadow: const [BauhausDesign.shadowHardSm],
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: BauhausDesign.textDark,
                ),
              ),
              const Spacer(),
              // Title
              Text(
                title.toUpperCase(),
                style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: textColor,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                subtitle,
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: textColor.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A wide action block that spans full width - for prominent actions.
class BauhausWideActionBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const BauhausWideActionBlock({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(
              color: BauhausDesign.neutral,
              width: 2.5,
            ),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space4,
            vertical: BauhausDesign.space4,
          ),
          child: Row(
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceLight,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: 2,
                  ),
                  boxShadow: const [BauhausDesign.shadowHardSm],
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: BauhausDesign.textDark,
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: textColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                        color: textColor.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow indicator
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                  border: Border.all(
                    color: textColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 20,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A Mondrian-style grid for Invoice Management actions.
/// First row: 2 columns, remaining rows: full width.
class BauhausInvoiceGrid extends StatelessWidget {
  final VoidCallback onGenerateInvoice;
  final VoidCallback onEmployeeInvoice;
  final VoidCallback onAllInvoices;
  final VoidCallback onEnhancedInvoice;
  final VoidCallback onInvoiceList;

  const BauhausInvoiceGrid({
    super.key,
    required this.onGenerateInvoice,
    required this.onEmployeeInvoice,
    required this.onAllInvoices,
    required this.onEnhancedInvoice,
    required this.onInvoiceList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space3,
            vertical: BauhausDesign.space2,
          ),
          decoration: BoxDecoration(
            color: BauhausDesign.neutral,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
          ),
          child: Text(
            'INVOICE MANAGEMENT',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: BauhausDesign.textLight,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: BauhausDesign.space4),

        // First Row: 2 Column Grid
        Row(
          children: [
            Expanded(
              child: BauhausActionBlock(
                icon: Icons.receipt_long_rounded,
                title: 'Generate',
                subtitle: 'Create new invoice for clients',
                backgroundColor: BauhausDesign.primary,
                textColor: BauhausDesign.textDark,
                onTap: onGenerateInvoice,
                height: 160,
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: BauhausActionBlock(
                icon: Icons.folder_copy_rounded,
                title: 'All Invoices',
                subtitle: 'Auto-generate for all users',
                backgroundColor: BauhausDesign.secondary,
                textColor: BauhausDesign.textLight,
                onTap: onAllInvoices,
                height: 160,
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space3),

        // Second Row: Full Width - Enhanced Invoice
        BauhausWideActionBlock(
          icon: Icons.payments_rounded,
          title: 'Employee Invoice',
          subtitle: 'Generate pay-rate invoices for employees',
          backgroundColor: BauhausDesign.primary,
          textColor: BauhausDesign.textDark,
          onTap: onEmployeeInvoice,
        ),
        const SizedBox(height: BauhausDesign.space3),

        // Third Row: Full Width - Enhanced Invoice
        BauhausWideActionBlock(
          icon: Icons.auto_awesome_rounded,
          title: 'Enhanced Invoice',
          subtitle: 'Generate invoices with pricing integration',
          backgroundColor: BauhausDesign.accent,
          textColor: BauhausDesign.textDark,
          onTap: onEnhancedInvoice,
        ),
        const SizedBox(height: BauhausDesign.space3),

        // Fourth Row: Full Width - Invoice List
        BauhausWideActionBlock(
          icon: Icons.list_alt_rounded,
          title: 'Invoice List',
          subtitle: 'View and manage generated invoices',
          backgroundColor: BauhausDesign.success,
          textColor: BauhausDesign.textDark,
          onTap: onInvoiceList,
        ),
      ],
    );
  }
}
