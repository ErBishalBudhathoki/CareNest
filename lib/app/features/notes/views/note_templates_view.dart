import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/notes/viewmodels/note_templates_viewmodel.dart';

/// Admin UI to manage organisation progress-note templates (Phase 2).
///
/// Lets an admin define the typed sections that support workers complete in
/// the shift-notes screen, so structured notes are usable end-to-end.
class NoteTemplatesView extends ConsumerStatefulWidget {
  const NoteTemplatesView({super.key});

  @override
  ConsumerState<NoteTemplatesView> createState() => _NoteTemplatesViewState();
}

class _NoteTemplatesViewState extends ConsumerState<NoteTemplatesView> {
  static const _sectionTypes = [
    'text',
    'longText',
    'select',
    'checkbox',
    'number',
    'voice',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noteTemplatesViewModelProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteTemplatesViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Note Templates')),
      body: state.isLoading && state.templates.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.templates.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No note templates yet.\nTap + to create one.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(noteTemplatesViewModelProvider.notifier).load(),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.templates.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final template = state.templates[index];
                  final sections =
                      (template['sections'] as List?)?.length ?? 0;
                  final active = template['active'] != false;
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.description_outlined,
                        color: active ? null : Theme.of(context).disabledColor,
                      ),
                      title: Text(template['name']?.toString() ?? 'Template'),
                      subtitle: Text(
                        '${template['description'] ?? ''}\n$sections section(s)'
                            '${active ? '' : ' · inactive'}',
                      ),
                      isThreeLine: true,
                      onTap: () => _openEditor(template),
                      trailing: IconButton(
                        tooltip: 'Deactivate',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: active
                            ? () => _confirmDeactivate(
                                  template['id']?.toString() ?? '',
                                )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Template'),
        onPressed: () => _openEditor(null),
      ),
    );
  }

  Future<void> _openEditor(Map<String, dynamic>? template) async {
    final body = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => _TemplateEditorDialog(
        template: template,
        sectionTypes: _sectionTypes,
      ),
    );
    if (body == null || !mounted) return;

    final notifier = ref.read(noteTemplatesViewModelProvider.notifier);
    final id = template?['id']?.toString();
    final ok = id == null || id.isEmpty
        ? await notifier.create(body)
        : await notifier.update(id, body);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ok ? 'Template saved.' : 'Failed to save template.'),
        ),
      );
    }
  }

  Future<void> _confirmDeactivate(String id) async {
    if (id.isEmpty) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Deactivate template?'),
        content: const Text(
          'It will no longer appear in the shift-notes picker. Existing notes are kept.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref.read(noteTemplatesViewModelProvider.notifier).deactivate(id);
  }
}

class _TemplateEditorDialog extends StatefulWidget {
  const _TemplateEditorDialog({
    required this.template,
    required this.sectionTypes,
  });

  final Map<String, dynamic>? template;
  final List<String> sectionTypes;

  @override
  State<_TemplateEditorDialog> createState() => _TemplateEditorDialogState();
}

class _TemplateEditorDialogState extends State<_TemplateEditorDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final List<Map<String, dynamic>> _sections;

  @override
  void initState() {
    super.initState();
    final t = widget.template;
    _nameController = TextEditingController(text: t?['name']?.toString() ?? '');
    _descriptionController =
        TextEditingController(text: t?['description']?.toString() ?? '');
    _sections = ((t?['sections'] as List?) ?? const [])
        .whereType<Map>()
        .map((e) => {
              'key': e['key']?.toString() ?? '',
              'label': e['label']?.toString() ?? '',
              'type': e['type']?.toString() ?? 'text',
              'required': e['required'] == true,
              'options': ((e['options'] as List?) ?? const [])
                  .map((o) => o.toString())
                  .join(', '),
              'helpText': e['helpText']?.toString() ?? '',
            })
        .toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addSection() {
    setState(() {
      _sections.add({
        'key': '',
        'label': '',
        'type': 'text',
        'required': false,
        'options': '',
        'helpText': '',
      });
    });
  }

  void _submit() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Template name is required.')),
      );
      return;
    }
    final sections = <Map<String, dynamic>>[];
    for (var i = 0; i < _sections.length; i++) {
      final s = _sections[i];
      final key = (s['key'] as String).trim();
      final label = (s['label'] as String).trim();
      if (key.isEmpty || label.isEmpty) continue;
      sections.add({
        'key': key,
        'label': label,
        'type': s['type'],
        'required': s['required'],
        'options': (s['options'] as String)
            .split(',')
            .map((o) => o.trim())
            .where((o) => o.isNotEmpty)
            .toList(),
        'helpText': s['helpText'],
        'order': i + 1,
      });
    }
    Navigator.of(context).pop({
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'sections': sections,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.template == null ? 'New template' : 'Edit template'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sections',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add section'),
                    onPressed: _addSection,
                  ),
                ],
              ),
              for (var i = 0; i < _sections.length; i++) _buildSection(i),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }

  Widget _buildSection(int index) {
    final section = _sections[index];
    final type = section['type'] as String;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Label',
                      isDense: true,
                    ),
                    controller: TextEditingController(text: section['label'])
                      ..selection = TextSelection.collapsed(
                        offset: (section['label'] as String).length,
                      ),
                    onChanged: (v) => section['label'] = v,
                  ),
                ),
                IconButton(
                  tooltip: 'Remove',
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => setState(() => _sections.removeAt(index)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Key (unique id, e.g. summary)',
                isDense: true,
              ),
              controller: TextEditingController(text: section['key'])
                ..selection = TextSelection.collapsed(
                  offset: (section['key'] as String).length,
                ),
              onChanged: (v) => section['key'] = v,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: widget.sectionTypes.contains(type) ? type : 'text',
              decoration: const InputDecoration(labelText: 'Type', isDense: true),
              items: widget.sectionTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => section['type'] = v ?? 'text'),
            ),
            if (type == 'select') ...[
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Options (comma-separated)',
                  isDense: true,
                ),
                controller: TextEditingController(text: section['options'])
                  ..selection = TextSelection.collapsed(
                    offset: (section['options'] as String).length,
                  ),
                onChanged: (v) => section['options'] = v,
              ),
            ],
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text('Required'),
              value: section['required'] == true,
              onChanged: (v) => setState(() => section['required'] = v),
            ),
          ],
        ),
      ),
    );
  }
}
