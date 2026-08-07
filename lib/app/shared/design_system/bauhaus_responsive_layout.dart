import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

/// Responsive Layout Helper
class BauhausResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final double mobileBreakpoint;
  final double tabletBreakpoint;

  const BauhausResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.mobileBreakpoint =
        768, // BauhausDesign doesn't have breakpoints yet, using standard
    this.tabletBreakpoint = 1024,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletBreakpoint && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= mobileBreakpoint && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// Responsive Grid
class BauhausResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double childAspectRatio;

  const BauhausResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = BauhausDesign.space4,
    this.runSpacing = BauhausDesign.space4,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns;
        if (constraints.maxWidth >= 1024) {
          columns = desktopColumns;
        } else if (constraints.maxWidth >= 768) {
          columns = tabletColumns;
        } else {
          columns = mobileColumns;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          mainAxisSpacing: runSpacing,
          childAspectRatio: childAspectRatio,
          children: children,
        );
      },
    );
  }
}
