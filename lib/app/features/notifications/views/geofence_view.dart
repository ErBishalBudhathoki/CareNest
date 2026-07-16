import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/providers/notification_providers.dart';
import 'package:carenest/app/features/notifications/models/geofence_model.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
import 'package:carenest/app/shared/widgets/loading_indicator.dart';

class GeofenceView extends ConsumerStatefulWidget {
  const GeofenceView({super.key});

  @override
  ConsumerState<GeofenceView> createState() => _GeofenceViewState();
}

class _GeofenceViewState extends ConsumerState<GeofenceView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(geofenceViewModelProvider.notifier).loadGeofences();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(geofenceViewModelProvider);
    final notifier = ref.read(geofenceViewModelProvider.notifier);

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Geofence Locations',
        showBackButton: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGeofenceDialog(context),
        child: const Icon(Icons.add),
      ),
      body: state.isLoading
          ? const Center(child: LoadingIndicator())
          : state.geofences.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: state.geofences.length,
                  itemBuilder: (context, index) {
                    final geofence = state.geofences[index];
                    return _buildGeofenceItem(geofence, notifier);
                  },
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No geofences found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add a location to get alerts when entering/exiting',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGeofenceItem(GeofenceModel geofence, dynamic notifier) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.location_on),
        ),
        title: Text(geofence.name),
        subtitle: Text('${geofence.address}\nRadius: ${geofence.radius}m'),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _confirmDelete(geofence, notifier),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(GeofenceModel geofence, dynamic notifier) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Geofence'),
        content: Text('Are you sure you want to delete "${geofence.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(geofenceViewModelProvider.notifier).deleteGeofence(geofence.id);
    }
  }

  void _showAddGeofenceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddGeofenceDialog(),
    );
  }
}

class AddGeofenceDialog extends ConsumerStatefulWidget {
  const AddGeofenceDialog({super.key});

  @override
  ConsumerState<AddGeofenceDialog> createState() => _AddGeofenceDialogState();
}

class _AddGeofenceDialogState extends ConsumerState<AddGeofenceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  final _radiusController = TextEditingController(text: '100');

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _latController.dispose();
    _lngController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Geofence'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _latController,
                      decoration: const InputDecoration(labelText: 'Latitude'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lngController,
                      decoration: const InputDecoration(labelText: 'Longitude'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _radiusController,
                decoration: const InputDecoration(labelText: 'Radius (meters)'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final geofence = GeofenceModel(
        id: '', // Server assigns ID
        clientId: 'temp_client_id', // Needs to be dynamic or handled by backend
        name: _nameController.text,
        address: _addressController.text,
        latitude: double.parse(_latController.text),
        longitude: double.parse(_lngController.text),
        radius: double.parse(_radiusController.text),
        isActive: true,
      );

      try {
        await ref.read(geofenceViewModelProvider.notifier).addGeofence(geofence);
        if (mounted) Navigator.pop(context);
      } catch (e) {
        // Handle error (maybe show snackbar)
      }
    }
  }
}
