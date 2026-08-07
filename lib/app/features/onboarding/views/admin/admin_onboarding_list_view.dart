import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/onboarding_providers.dart';
import 'admin_onboarding_detail_view.dart';

class AdminOnboardingListView extends ConsumerStatefulWidget {
  const AdminOnboardingListView({super.key});

  @override
  ConsumerState<AdminOnboardingListView> createState() =>
      _AdminOnboardingListViewState();
}

class _AdminOnboardingListViewState
    extends ConsumerState<AdminOnboardingListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          ref.read(adminOnboardingViewModelProvider.notifier).loadPendingList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminOnboardingViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pending Onboardings')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? Center(child: Text('Error: ${state.error}'))
          : state.pendingList.isEmpty
          ? const Center(child: Text('No pending onboardings'))
          : ListView.builder(
              itemCount: state.pendingList.length,
              itemBuilder: (context, index) {
                final item = state.pendingList[index];
                final user = item['user'] ?? {};
                final name =
                    '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'
                        .trim();
                final email = user['email'] ?? 'No Email';
                final status = item['status'] ?? 'Unknown';

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(name.isNotEmpty ? name[0] : '?'),
                  ),
                  title: Text(name.isNotEmpty ? name : 'Unknown User'),
                  subtitle: Text('$email\nStatus: $status'),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ref
                        .read(adminOnboardingViewModelProvider.notifier)
                        .selectUser(item);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AdminOnboardingDetailView(),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
