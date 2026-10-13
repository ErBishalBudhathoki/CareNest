import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

/// Property detail: vacancy board + occupancy management (Phase 4).
class SILPropertyDetailView extends ConsumerStatefulWidget {
  const SILPropertyDetailView({
    super.key,
    required this.propertyId,
    required this.propertyName,
  });

  final String propertyId;
  final String propertyName;

  @override
  ConsumerState<SILPropertyDetailView> createState() =>
      _SILPropertyDetailViewState();
}

class _SILPropertyDetailViewState extends ConsumerState<SILPropertyDetailView> {
  SILVacancyBoard? _board;
  List<SILOccupancy> _occupancy = const [];
  List<Patient> _clients = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load();
      _loadClients();
    });
  }

  SILRepository get _repo => ref.read(silRepositoryProvider);

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final board = await _repo.getVacancies(widget.propertyId);
      final occupancy = await _repo.getOccupancy(propertyId: widget.propertyId);
      if (mounted) {
        setState(() {
          _board = board;
          _occupancy = occupancy.where((o) => o.status == 'active').toList();
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loadClients() async {
    try {
      final api = ref.read(app_providers.apiMethodProvider);
      final clients = await api.fetchClientData();
      if (mounted) setState(() => _clients = clients);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.propertyName),
        actions: [
          IconButton(
            tooltip: 'Roster',
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () => Navigator.of(context).pushNamed(
              Routes.silRoster,
              arguments: {
                'propertyId': widget.propertyId,
                'propertyName': widget.propertyName,
              },
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_board != null) _buildSummary(context, _board!),
                  const SizedBox(height: 16),
                  Text('Rooms', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ..._buildRooms(context, _board),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add_alt),
        label: const Text('Occupy'),
        onPressed: _board == null ? null : _showCreateOccupancyDialog,
      ),
    );
  }

  Widget _buildSummary(BuildContext context, SILVacancyBoard board) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _stat(context, 'Rooms', '${board.totalRooms}'),
            _stat(context, 'Occupied', '${board.occupiedCount}'),
            _stat(context, 'Vacant', '${board.vacantCount}'),
          ],
        ),
      ),
    );
  }

  Widget _stat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineSmall),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  List<Widget> _buildRooms(BuildContext context, SILVacancyBoard? board) {
    if (board == null || board.rooms.isEmpty) {
      return [const Text('No rooms configured.')];
    }
    return board.rooms.map((room) {
      final occupancy = _occupancy.where((o) => o.roomId == room.roomId).toList();
      final occupied = occupancy.isNotEmpty;
      return Card(
        child: ListTile(
          leading: Icon(
            occupied ? Icons.bed : Icons.bed_outlined,
            color: occupied ? Theme.of(context).colorScheme.primary : null,
          ),
          title: Text(room.label.isNotEmpty ? room.label : room.roomId),
          subtitle: Text(occupied ? 'Occupied' : 'Vacant'),
          trailing: occupied
              ? TextButton(
                  onPressed: () => _endOccupancy(occupancy.first),
                  child: const Text('Vacate'),
                )
              : null,
        ),
      );
    }).toList();
  }

  Future<void> _endOccupancy(SILOccupancy occupancy) async {
    try {
      await _repo.endOccupancy(occupancy.id, vacatedReason: 'vacated');
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  Future<void> _showCreateOccupancyDialog() async {
    if (_clients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No clients available.')),
      );
      return;
    }
    String? clientId = _clients.firstWhere((c) => c.id != null, orElse: () => _clients.first).id;
    final vacantRooms = (_board?.rooms ?? []).where((r) => !r.occupied).toList();
    String? roomId = vacantRooms.isNotEmpty ? vacantRooms.first.roomId : null;

    if (vacantRooms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No vacant rooms.')),
      );
      return;
    }

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: const Text('Create occupancy'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: clientId,
                decoration: const InputDecoration(labelText: 'Client'),
                items: _clients
                    .where((c) => c.id != null)
                    .map((c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(
                            c.clientName ??
                                '${c.clientFirstName ?? ''} ${c.clientLastName ?? ''}'.trim(),
                          ),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => clientId = v),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: roomId,
                decoration: const InputDecoration(labelText: 'Room'),
                items: vacantRooms
                    .map((r) => DropdownMenuItem(
                          value: r.roomId,
                          child: Text(r.label.isNotEmpty ? r.label : r.roomId),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => roomId = v),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                try {
                  await _repo.createOccupancy({
                    'propertyId': widget.propertyId,
                    'roomId': roomId,
                    'clientId': clientId,
                  });
                  if (dialogContext.mounted) Navigator.of(dialogContext).pop(true);
                } catch (e) {
                  if (dialogContext.mounted) {
                    ScaffoldMessenger.of(dialogContext)
                        .showSnackBar(SnackBar(content: Text('$e')));
                  }
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );

    if (created == true) await _load();
  }
}
