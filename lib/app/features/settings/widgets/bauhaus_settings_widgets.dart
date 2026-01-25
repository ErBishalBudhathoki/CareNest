import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'dart:typed_data';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';

// --- Bauhaus Settings Header ---
class BauhausSettingsHeader extends StatelessWidget {
  final String title;

  const BauhausSettingsHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        BauhausDesign.space4,
        BauhausDesign.space8, // Top padding for status bar
        BauhausDesign.space4,
        BauhausDesign.space4,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.secondary, // Royal Indigo background
        border: const Border(
          bottom: BorderSide(
            color: BauhausDesign.neutral,
            width: 3.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
                  color: BauhausDesign.textLight,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
          ),
        ],
      ),
    );
  }
}

// --- Bauhaus Profile Card ---
class BauhausProfileCard extends StatelessWidget {
  final String userName;
  final String userEmail;
  final Uint8List? photoData;
  final VoidCallback onPhotoTap;

  const BauhausProfileCard({
    super.key,
    required this.userName,
    required this.userEmail,
    this.photoData,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space4,
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 2.0,
        ),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Row(
        children: [
          // Profile Image with "Edit" badge
          GestureDetector(
            onTap: onPhotoTap,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(2), // White gap
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 2.0,
                    ),
                  ),
                  child: ProfileImageWidget(
                    photoData: photoData,
                    size: 64,
                    borderWidth: 0, // Handled by container
                    borderColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: BauhausDesign.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 12,
                      color: BauhausDesign.textDark, // Dark icon on orange
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: BauhausDesign.space4),
          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: BauhausDesign.textDark,
                          ),
                ),
                const SizedBox(height: 2),
                Text(
                  userEmail,
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: BauhausDesign.textDark.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Bauhaus Section Title ---
class BauhausSectionTitle extends StatelessWidget {
  final String title;
  final bool isDangerZone;

  const BauhausSectionTitle({
    super.key,
    required this.title,
    this.isDangerZone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: BauhausDesign.space4,
        top: BauhausDesign.space4,
        bottom: BauhausDesign.space2,
      ),
      child: Text(
        title.toUpperCase(),
        style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
              color:
                  isDangerZone ? BauhausDesign.error : BauhausDesign.textDark,
            ),
      ),
    );
  }
}

// --- Bauhaus Settings Tile ---
class BauhausSettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color iconColor; // Background color for the icon square

  const BauhausSettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 2.0,
        ),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            child: Row(
              children: [
                // Icon Block
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space2),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: BauhausDesign.textDark, // Dark icons for contrast
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: BauhausDesign.getTextTheme(context)
                            .titleSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: BauhausDesign.textDark,
                              letterSpacing: 0.3,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.textDark.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
                // Arrow
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: BauhausDesign.neutral.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
