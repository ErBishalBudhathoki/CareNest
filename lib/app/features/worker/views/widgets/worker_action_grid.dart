import 'package:flutter/material.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';

class WorkerActionGrid extends StatelessWidget {
  const WorkerActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildActionCard(
          icon: Icons.receipt_long,
          label: 'EXPENSES',
          color: BauhausTheme.blue,
          onTap: () {
            // Navigate to Expenses
            // Navigator.pushNamed(context, Routes.EXPENSES);
          },
        ),
        _buildActionCard(
          icon: Icons.calendar_today,
          label: 'LEAVE',
          color: BauhausTheme.red,
          onTap: () {
            // Navigate to Leave
          },
        ),
        _buildActionCard(
          icon: Icons.history,
          label: 'TIMESHEETS',
          color: BauhausTheme.yellow,
          textColor: BauhausTheme.black,
          onTap: () {
            // Navigate to Timesheets
          },
        ),
        _buildActionCard(
          icon: Icons.person,
          label: 'PROFILE',
          color: BauhausTheme.black,
          onTap: () {
            // Navigate to Profile
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
    Color textColor = BauhausTheme.white,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: BauhausTheme.black, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: BauhausTheme.subHeaderStyle.copyWith(
                color: textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
