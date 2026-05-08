import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/bauhaus_design.dart';
import '../../../shared/widgets/button_widget.dart';
import '../models/employee_document.dart';
import '../providers/onboarding_providers.dart';

class DocumentUploadView extends ConsumerStatefulWidget {
  const DocumentUploadView({
    super.key,
    required this.title,
    required this.description,
    required this.documentTypes,
    required this.onComplete,
    this.optionalDocumentTypes = const <String>{},
    this.buttonText = 'Continue',
  });

  final String title;
  final String description;
  final List<String> documentTypes;
  final Set<String> optionalDocumentTypes;
  final String buttonText;
  final VoidCallback onComplete;

  @override
  ConsumerState<DocumentUploadView> createState() => _DocumentUploadViewState();
}

class _DocumentUploadViewState extends ConsumerState<DocumentUploadView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingViewModelProvider);
    final documents = state.documents;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          widget.title,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Text(
          widget.description,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.documentTypes.length,
            separatorBuilder: (ctx, i) =>
                const Divider(color: BauhausDesign.textDark),
            itemBuilder: (ctx, index) {
              final docType = widget.documentTypes[index];
              final uploadedDoc = documents.firstWhere(
                (d) => d.type == docType,
                orElse: () => EmployeeDocument(
                  id: '',
                  userId: '',
                  organizationId: '',
                  type: '',
                  fileUrl: '',
                  status: 'pending',
                  uploadedAt: DateTime.now(),
                ),
              );

              final isUploaded =
                  uploadedDoc.id != null && uploadedDoc.id!.isNotEmpty;
              final isOptional = widget.optionalDocumentTypes.contains(docType);

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  isOptional ? '$docType (Optional)' : docType,
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                ),
                subtitle: Text(
                  isUploaded ? 'Uploaded' : 'Tap to upload',
                  style: TextStyle(
                    color: isUploaded
                        ? Colors.green
                        : BauhausDesign.textDark.withOpacity(0.6),
                  ),
                ),
                trailing: isUploaded
                    ? IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: BauhausDesign.error,
                        ),
                        onPressed: () async {
                          if (uploadedDoc.id == null ||
                              uploadedDoc.id!.isEmpty) {
                            return;
                          }

                          try {
                            await ref
                                .read(onboardingViewModelProvider.notifier)
                                .deleteDocument(uploadedDoc.id!);
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Delete failed: $e')),
                              );
                            }
                          }
                        },
                      )
                    : const Icon(
                        Icons.upload_file,
                        color: BauhausDesign.textDark,
                      ),
                onTap: isUploaded ? null : () => _pickAndUpload(docType),
              );
            },
          ),
        const SizedBox(height: 16),
        if (state.isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ButtonWidget(
            buttonText: widget.buttonText,
            onPressed: () {
              final requiredDocs = widget.documentTypes
                  .where((doc) => !widget.optionalDocumentTypes.contains(doc))
                  .toList();
              final uploadedTypes = documents.map((d) => d.type).toSet();
              final missingDocs = requiredDocs
                  .where((doc) => !uploadedTypes.contains(doc))
                  .toList();

              if (missingDocs.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Missing required documents:\n- ${missingDocs.join('\n- ')}',
                    ),
                    backgroundColor: BauhausDesign.error,
                    duration: const Duration(seconds: 4),
                  ),
                );
                return;
              }

              widget.onComplete();
            },
          ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: widget.onComplete,
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(
                  color: BauhausDesign.neoInk.withOpacity(0.3),
                  width: 2),
            ),
            child: Text(
              'Skip for now',
              style: BauhausDesign.neoMonoStyle(
                context,
                color: BauhausDesign.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ],
    ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: $e')),
          );
        }
      }
    }
  }
}
