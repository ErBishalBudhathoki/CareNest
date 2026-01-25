import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/onboarding_providers.dart';
import '../../models/employee_document.dart';

class AdminOnboardingDetailView extends ConsumerWidget {
  const AdminOnboardingDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminOnboardingViewModelProvider);
    final record = state.selectedRecord;
    final user = state.selectedUser;

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (record == null) {
      return const Scaffold(body: Center(child: Text('No record selected')));
    }

    final name = '${user?['firstName'] ?? ''} ${user?['lastName'] ?? ''}'.trim();

    return Scaffold(
      appBar: AppBar(title: Text('Review: $name')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(record.status),
            const SizedBox(height: 24),
            const Text('Documents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (state.selectedDocuments.isEmpty)
              const Text('No documents uploaded.')
            else
              ...state.selectedDocuments.map((doc) => _buildDocumentTile(context, ref, doc)),
            
            const SizedBox(height: 32),
            if (record.status == 'submitted' || record.status == 'review_pending')
              ElevatedButton(
                onPressed: () => _finalize(context, ref, record.userId),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Finalize & Approve Onboarding'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String status) {
    Color color;
    switch (status) {
      case 'completed': color = Colors.green; break;
      case 'submitted': color = Colors.orange; break;
      case 'rejected': color = Colors.red; break;
      default: color = Colors.blue;
    }
    
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: color),
            const SizedBox(width: 16),
            Text('Status: ${status.toUpperCase()}', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTile(BuildContext context, WidgetRef ref, EmployeeDocument doc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.description),
        title: Text(doc.type.toUpperCase()),
        subtitle: Text('Status: ${doc.status}\nNumber: ${doc.documentNumber ?? "N/A"}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              onPressed: () => _verifyDoc(context, ref, doc.id!, 'verified'),
              tooltip: 'Approve',
            ),
            IconButton(
              icon: const Icon(Icons.cancel_outlined, color: Colors.red),
              onPressed: () => _verifyDoc(context, ref, doc.id!, 'rejected'),
              tooltip: 'Reject',
            ),
             // Could add view button to open URL
          ],
        ),
        onTap: () {
           // Open document URL
        },
      ),
    );
  }

  void _verifyDoc(BuildContext context, WidgetRef ref, String docId, String status) async {
    await ref.read(adminOnboardingViewModelProvider.notifier).verifyDocument(docId, status);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Document $status')));
    }
  }

  void _finalize(BuildContext context, WidgetRef ref, String userId) async {
    await ref.read(adminOnboardingViewModelProvider.notifier).finalizeOnboarding(userId);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Onboarding Finalized')));
      Navigator.of(context).pop();
    }
  }
}
