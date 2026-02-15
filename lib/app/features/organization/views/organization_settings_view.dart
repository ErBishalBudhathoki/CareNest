import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/organization/views/organization_settings_view_redesigned.dart';

class OrganizationSettingsView extends ConsumerWidget {
  const OrganizationSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const OrganizationSettingsRedesigned();
  }
}
