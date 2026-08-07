import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/organization/widgets/organization_card.dart';
import 'package:carenest/app/features/analytics/widgets/bauhaus_container.dart';

class OrganizationDashboardView extends ConsumerStatefulWidget {
  const OrganizationDashboardView({super.key});

  @override
  ConsumerState<OrganizationDashboardView> createState() =>
      _OrganizationDashboardViewState();
}

class _OrganizationDashboardViewState
    extends ConsumerState<OrganizationDashboardView> {
  @override
  void initState() {
    super.initState();
    // Refresh list on entry
    Future.microtask(
      () => ref.read(organizationProvider.notifier).loadUserOrganizations(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orgState = ref.watch(organizationProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        title: const Text('Organizations'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to create organization
              // Navigator.pushNamed(context, '/create-organization');
            },
          ),
        ],
      ),
      body: orgState.isLoading && orgState.userOrganizations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref
                  .read(organizationProvider.notifier)
                  .loadUserOrganizations(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Organizations',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textDark,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    if (orgState.userOrganizations.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'You don\'t belong to any organizations yet.',
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orgState.userOrganizations.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: BauhausDesign.space3),
                        itemBuilder: (context, index) {
                          final org = orgState.userOrganizations[index];
                          // Check if this is current active org
                          // Simple check: compare ID if available in currentOrganization
                          final isSelected =
                              orgState.currentOrganization?.id == org['id'];

                          return OrganizationCard(
                            organization: org,
                            isSelected: isSelected,
                            onTap: () {
                              ref
                                  .read(organizationProvider.notifier)
                                  .switchOrganization(org['id']);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Switched to ${org['name']}'),
                                ),
                              );
                            },
                          );
                        },
                      ),

                    const SizedBox(height: BauhausDesign.space5),

                    const Text(
                      'Cross-Organization Reports',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textDark,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space3),

                    BauhausContainer(
                      width: double.infinity,
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          color: BauhausDesign.primaryYellow,
                          child: const Icon(
                            Icons.bar_chart,
                            color: Colors.black,
                          ),
                        ),
                        title: const Text('Consolidated Revenue'),
                        subtitle: const Text(
                          'View revenue across all organizations',
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          // Navigate to cross-org report
                          // Navigator.pushNamed(context, '/cross-org-reports');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
