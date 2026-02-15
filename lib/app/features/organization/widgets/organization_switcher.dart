import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class OrganizationSwitcher extends ConsumerWidget {
  const OrganizationSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgState = ref.watch(organizationProvider);
    final userOrgs = orgState.userOrganizations;
    // We assume currentOrganization has an 'id' field if it's not null,
    // or we check SharedPreferences/State for current ID.
    // Ideally orgState.currentOrganization is populated.
    
    // Fallback if currentOrganization is null (maybe just logged in)
    // We can use a simpler check or just show 'Select Organization'
    final currentOrgName = orgState.currentOrganization?.name ?? 'Select Organization';

    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: BauhausDesign.neutral),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              color: BauhausDesign.primaryRed,
              child: Center(
                child: Text(
                  currentOrgName.isNotEmpty ? currentOrgName[0] : 'O',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              currentOrgName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (context) {
        return [
          ...userOrgs.map((org) {
             // org is a dynamic map from getUserOrganizations
             final name = org['name'] as String;
             final id = org['id'] as String;
             
             return PopupMenuItem<String>(
              value: id,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    color: BauhausDesign.primaryBlue,
                    child: Center(
                      child: Text(
                        name.isNotEmpty ? name[0] : 'O',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(name),
                ],
              ),
            );
          }),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'manage',
            child: Row(
              children: [
                Icon(Icons.settings, size: 18),
                SizedBox(width: 8),
                Text('Manage Organizations'),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 'manage') {
          // Navigate to dashboard
          Navigator.pushNamed(context, '/organization-dashboard');
        } else {
          ref.read(organizationProvider.notifier).switchOrganization(value);
        }
      },
    );
  }
}
