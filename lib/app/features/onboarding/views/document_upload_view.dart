import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../providers/onboarding_providers.dart';
import '../models/employee_document.dart';
import '../../../shared/constants/bauhaus_design.dart';
import '../../../shared/widgets/button_widget.dart';

class DocumentUploadView extends ConsumerStatefulWidget {
  final VoidCallback onComplete;

  const DocumentUploadView({super.key, required this.onComplete});

  @override
  ConsumerState<DocumentUploadView> createState() => _DocumentUploadViewState();
}

class _DocumentUploadViewState extends ConsumerState<DocumentUploadView> {
  // Required documents list
  final List<String> _requiredDocs = [
    'Passport / ID',
    'Visa Grant (if applicable)',
    'Qualifications / Certifications',
    'Police Check',
    'WWCC (Working With Children Check)',
    'NDIS Worker Screening',
    'First Aid Certificate',
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingViewModelProvider);
    final documents = state.documents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Required Documents',
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Text(
          'Please upload the following documents. At least one document is required to complete onboarding.',
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: _requiredDocs.length,
            separatorBuilder: (ctx, i) => const Divider(color: BauhausDesign.textDark),
            itemBuilder: (ctx, index) {
              final docType = _requiredDocs[index];
              final uploadedDoc = documents.firstWhere(
                (d) => d.type == docType, 
                orElse: () => EmployeeDocument(
                  id: '', 
                  userId: '', 
                  organizationId: '', 
                  type: '', 
                  fileUrl: '', 
                  status: 'pending',
                  uploadedAt: DateTime.now()
                ),
              );
              
              final isUploaded = uploadedDoc.id != null && uploadedDoc.id!.isNotEmpty;

              return ListTile(
                leading: Icon(
                  isUploaded ? Icons.check_circle : Icons.circle_outlined,
                  color: isUploaded ? Colors.green : BauhausDesign.textDark,
                ),
                title: Text(
                  docType,
                  style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                subtitle: Text(
                  isUploaded ? 'Uploaded' : 'Tap to upload',
                  style: TextStyle(
                    color: isUploaded ? Colors.green : BauhausDesign.textDark.withOpacity(0.6),
                  ),
                ),
                trailing: isUploaded 
                    ? IconButton(
                        icon: const Icon(Icons.delete_outline, color: BauhausDesign.textDark),
                        onPressed: () async {
                          if (uploadedDoc.id != null) {
                            try {
                              await ref.read(onboardingViewModelProvider.notifier).deleteDocument(uploadedDoc.id!);
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
                              }
                            }
                          }
                        },
                      )
                    : const Icon(Icons.upload_file, color: BauhausDesign.textDark),
                onTap: isUploaded ? null : () => _pickAndUpload(docType),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        if (state.isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ButtonWidget(
            buttonText: 'Finish Onboarding',
            onPressed: () {
              final mandatoryDocs = _requiredDocs.where((doc) => !doc.toLowerCase().contains('(if applicable)')).toList();
              final uploadedTypes = documents.map((d) => d.type).toSet();
              
              final missingDocs = mandatoryDocs.where((doc) => !uploadedTypes.contains(doc)).toList();

              if (missingDocs.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Missing required documents:\n- ${missingDocs.join('\n- ')}'),
                    backgroundColor: BauhausDesign.error,
                    duration: const Duration(seconds: 4),
                  ),
                );
                return;
              }
              widget.onComplete();
            },
          ),
      ],
    );
  }

  Future<void> _pickAndUpload(String docType) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      
      try {
        await ref.read(onboardingViewModelProvider.notifier).uploadDocument(
          file,
          docType,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
        }
      }
    }
  }
}
