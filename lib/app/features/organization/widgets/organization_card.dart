import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/analytics/widgets/bauhaus_container.dart';
// import 'package:carenest/app/core/providers/organization_provider.dart'; // Unused

class OrganizationCard extends ConsumerWidget {
  final Map<String, dynamic> organization;
  final VoidCallback onTap;
  final bool isSelected;

  const OrganizationCard({
    super.key,
    required this.organization,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: BauhausContainer(
        color: isSelected ? BauhausDesign.primaryRed.withOpacity(0.1) : BauhausDesign.surfaceWhite,
        padding: const EdgeInsets.all(BauhausDesign.space3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: BauhausDesign.primaryBlue,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Center(
                    child: Text(
                      organization['name']?.substring(0, 1).toUpperCase() ?? 'O',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        organization['name'] ?? 'Unknown Organization',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        organization['code'] ?? '',
                        style: const TextStyle(
                          color: BauhausDesign.textMedium,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: BauhausDesign.primaryRed,
                  ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRoleTag(organization['role'] ?? 'Member'),
                Text(
                  'Last accessed: ${_formatDate(organization['lastAccessedAt'])}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: BauhausDesign.textMuted, // Changed from textLight
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleTag(String role) {
    Color color = BauhausDesign.neutral;
    if (role == 'owner') color = BauhausDesign.primaryRed;
    if (role == 'admin') color = BauhausDesign.primaryBlue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
      ),
      child: Text(
        role.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'Never';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Unknown';
    }
  }
}
