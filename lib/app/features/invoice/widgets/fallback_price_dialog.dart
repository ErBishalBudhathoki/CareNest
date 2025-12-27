import 'package:flutter/material.dart';

/// Dialog widget prompting the user to enter or update the fallback price.
///
/// This widget is generic and does not access ViewModels directly.
/// The parent view is responsible for providing initial values, loading state,
/// and handling the save callback.
class FallbackPriceDialog extends StatelessWidget {
  final double? initialPrice;
  final bool isSaving;
  final String? errorText;
  final String currencySuffix;
  final ValueChanged<double> onSave;

  const FallbackPriceDialog({
    super.key,
    required this.initialPrice,
    required this.isSaving,
    required this.errorText,
    required this.currencySuffix,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: initialPrice != null ? initialPrice!.toStringAsFixed(2) : '',
    );
    return AlertDialog(
      title: const Text('Update Fallback Price'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter the organization fallback base rate used when no other pricing applies.',
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixText: currencySuffix,
              hintText: 'e.g., 35.00',
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: isSaving
              ? null
              : () {
                  final input = controller.text.trim();
                  final parsed = double.tryParse(input);
                  if (parsed == null || parsed <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter a valid positive amount.')),
                    );
                    return;
                  }
                  onSave(parsed);
                },
          child: isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}