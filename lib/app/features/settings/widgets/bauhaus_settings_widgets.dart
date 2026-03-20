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
  final String? imageUrl;
  final bool isEmailVerified;
  final VoidCallback onPhotoTap;

  const BauhausProfileCard({
    super.key,
    required this.userName,
    required this.userEmail,
    this.photoData,
    this.imageUrl,
    this.isEmailVerified = false,
    required this.onPhotoTap,
  });

  String get _safeName {
    final normalized = userName.trim();
    return normalized.isEmpty ? 'User' : normalized;
  }

  String get _primaryName {
    final parts = _safeName
        .split(RegExp(r'\s+'))
        .where((part) => part.trim().isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'User';
    return parts.first;
  }

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIdentityHeader(context),
          const SizedBox(height: BauhausDesign.space3),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              userEmail,
              textAlign: TextAlign.left,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textMuted,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space2,
            ),
            decoration: BoxDecoration(
              color: (isEmailVerified
                      ? BauhausDesign.success
                      : BauhausDesign.warning)
                  .withOpacity(0.12),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(
                color: isEmailVerified
                    ? BauhausDesign.success
                    : BauhausDesign.warning,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isEmailVerified
                      ? Icons.verified
                      : Icons.warning_amber_rounded,
                  size: 14,
                  color: isEmailVerified
                      ? BauhausDesign.success
                      : BauhausDesign.warning,
                ),
                const SizedBox(width: 6),
                Text(
                  isEmailVerified ? 'EMAIL VERIFIED' : 'EMAIL NOT VERIFIED',
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: isEmailVerified
                                ? BauhausDesign.success
                                : BauhausDesign.warning,
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello,',
                  style: BauhausDesign.getTextTheme(context)
                      .displayLarge
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontSize: 56,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space1),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  _primaryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(context)
                      .displayLarge
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontSize: 72,
                        height: 0.96,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Container(
                width: 64,
                height: 6,
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        GestureDetector(
          onTap: onPhotoTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: 2.0,
                  ),
                ),
                child: ProfileImageWidget(
                  photoData: photoData,
                  imageUrl: imageUrl,
                  size: 76,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 2.0,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 12,
                    color: BauhausDesign.neutral,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
    final iconForegroundColor =
        ThemeData.estimateBrightnessForColor(iconColor) == Brightness.dark
            ? BauhausDesign.textLight
            : BauhausDesign.textDark;

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
                    color: iconForegroundColor,
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
