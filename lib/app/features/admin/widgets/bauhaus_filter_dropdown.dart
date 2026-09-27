import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';

class BauhausFilterDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String label;

  const BauhausFilterDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label = 'Filter',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down_sharp,
                color: Theme.of(context).colorScheme.onSurface,
                size: 32,
              ),
              dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
              style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
