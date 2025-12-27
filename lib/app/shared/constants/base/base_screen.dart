import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseScreen extends ConsumerWidget {
  const BaseScreen({super.key});

  Widget phoneView(BuildContext context, WidgetRef ref);

  Widget tabletView(BuildContext context, WidgetRef ref);

  Widget desktopView(BuildContext context, WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return phoneView(context, ref);
        } else if (constraints.maxWidth < 1200) {
          return tabletView(context, ref);
        } else {
          return desktopView(context, ref);
        }
      },
    );
  }
}
