
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/team_providers.dart';

class TeamDashboardView extends ConsumerStatefulWidget {
  const TeamDashboardView({super.key});

  @override
  ConsumerState<TeamDashboardView> createState() => _TeamDashboardViewState();
}

class _TeamDashboardViewState extends ConsumerState<TeamDashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(teamViewModelProvider).loadMyTeams();
      ref.read(teamViewModelProvider).loadActiveBroadcasts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(teamViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Team Coordination')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildEmergencySection(context, viewModel),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Teams',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: () => _showCreateTeamDialog(context),
                  ),
                ],
              ),
            ),
          ),
          if (viewModel.isLoading)
            const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final team = viewModel.teams[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ExpansionTile(
                      leading: CircleAvatar(child: Text(team.name[0])),
                      title: Text(team.name),
                      subtitle: Text('${team.members.length} members'),
                      children: [
                        ...team.members.map((member) => ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(member.userId), // Show name in real app
                              subtitle: Text(member.role),
                              trailing: Text(
                                member.status,
                                style: TextStyle(
                                  color: member.status == 'active' ? Colors.green : Colors.grey,
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Invite member logic
                            },
                            child: const Text('Invite Member'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: viewModel.teams.length,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmergencySection(BuildContext context, dynamic viewModel) {
    return Container(
      color: Colors.red.shade50,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergency Broadcasts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 8),
          if (viewModel.activeBroadcasts.isEmpty)
            const Text('No active emergencies.')
          else
            ...viewModel.activeBroadcasts.map<Widget>((broadcast) => Card(
                  color: Colors.red.shade100,
                  child: ListTile(
                    leading: const Icon(Icons.warning, color: Colors.red),
                    title: Text(broadcast.message),
                    subtitle: Text('Type: ${broadcast.type}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                         ref.read(teamViewModelProvider).acknowledgeBroadcast(broadcast.id!);
                      },
                      child: const Text('Acknowledge'),
                    ),
                  ),
                )),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () => _showEmergencyDialog(context),
            icon: const Icon(Icons.campaign),
            label: const Text('Send Emergency Broadcast'),
          ),
        ],
      ),
    );
  }

  void _showCreateTeamDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Team'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Team Name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              ref.read(teamViewModelProvider).createTeam(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SEND EMERGENCY BROADCAST'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This will notify all team members immediately via all channels.',
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
               // Hardcoding teamId for demo, in real app user selects team
               // ref.read(teamViewModelProvider).sendBroadcast('team-id', controller.text, 'emergency');
              Navigator.pop(context);
            },
            child: const Text('BROADCAST NOW'),
          ),
        ],
      ),
    );
  }
}
