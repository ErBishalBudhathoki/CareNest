import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

/// Real-Time Client Portal Dashboard
/// Main entry point for all real-time features
class RealtimePortalDashboard extends ConsumerWidget {
  const RealtimePortalDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Real-Time Portal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 24),

            // Feature Cards
            _buildFeatureCard(
              icon: Icons.location_on,
              title: 'Live Tracking',
              description: 'Track worker location in real-time',
              color: AppColors.colorPrimary,
              onTap: () => Get.toNamed('/realtime-portal/live-tracking'),
            ),
            const SizedBox(height: 16),

            _buildFeatureCard(
              icon: Icons.timeline,
              title: 'Appointment Timeline',
              description: 'View service progress and updates',
              color: AppColors.colorSecondary,
              onTap: () => Get.toNamed('/realtime-portal/appointment-timeline'),
            ),
            const SizedBox(height: 16),

            _buildFeatureCard(
              icon: Icons.message,
              title: 'Secure Messaging',
              description: 'Chat with workers and support',
              color: AppColors.colorAccent,
              onTap: () => Get.toNamed('/realtime-portal/secure-messaging'),
            ),
            const SizedBox(height: 16),

            _buildFeatureCard(
              icon: Icons.edit_document,
              title: 'Service Confirmation',
              description: 'Sign and confirm completed services',
              color: AppColors.colorSuccess,
              onTap: () => Get.toNamed('/realtime-portal/service-confirmation'),
            ),
            const SizedBox(height: 16),

            _buildFeatureCard(
              icon: Icons.family_restroom,
              title: 'Family Access',
              description: 'Manage family member permissions',
              color: AppColors.colorWarning,
              onTap: () => Get.toNamed('/realtime-portal/family-management'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.colorPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.real_estate_agent,
                  color: AppColors.colorPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Real-Time Portal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorFontPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stay connected with live updates',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666), // BauhausDesign.textMuted
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.colorPrimary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.colorPrimary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'All communications are encrypted and secure',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF666666), // BauhausDesign.textMuted
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorFontPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666), // BauhausDesign.textMuted
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
