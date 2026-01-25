import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

class BauhausHomeHeader extends StatelessWidget {
  final String userName;
  final String? organizationName;
  final Uint8List? photoData;
  final VoidCallback? onRefresh;

  const BauhausHomeHeader({
    super.key,
    required this.userName,
    this.organizationName,
    this.photoData,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, d MMMM').format(now).toUpperCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      color: BauhausDesign.accent, // Yellow background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateStr,
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.textDark,
                                  letterSpacing: 1.0,
                                ),
                          ),
                          const SizedBox(height: BauhausDesign.space2),
                          Text(
                            'HELLO,',
                            style: BauhausDesign.getTextTheme(context)
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.textDark,
                                  height: 1.0,
                                ),
                          ),
                          Text(
                            userName.toUpperCase(),
                            style: BauhausDesign.getTextTheme(context)
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.textDark,
                                  height: 1.0,
                                ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    _buildProfileImage(context),
                  ],
                ),
                if ((organizationName != null &&
                        organizationName!.isNotEmpty) ||
                    onRefresh != null) ...[
                  const SizedBox(height: BauhausDesign.space4),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (organizationName != null &&
                            organizationName!.isNotEmpty) ...[
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal: BauhausDesign.space2,
                              vertical: BauhausDesign.space1,
                            ),
                            decoration: BoxDecoration(
                              color: BauhausDesign.surfaceLight,
                              border: Border.all(
                                color: BauhausDesign.textDark,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              organizationName!.toUpperCase(),
                              style: BauhausDesign.getTextTheme(context)
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: BauhausDesign.textDark,
                                    letterSpacing: 0.5,
                                  ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        if (onRefresh != null) _buildRefreshButton(),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshButton() {
    return _AnimatedRefreshButton(onTap: onRefresh);
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(
          color: BauhausDesign.textDark,
          width: 3,
        ),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.textDark,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: photoData != null
          ? Image.memory(
              photoData!,
              fit: BoxFit.cover,
            )
          : Center(
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                style: BauhausDesign.getTextTheme(context)
                    .headlineMedium
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.textDark,
                    ),
              ),
            ),
    );
  }
}

class _AnimatedRefreshButton extends StatefulWidget {
  final VoidCallback? onTap;

  const _AnimatedRefreshButton({this.onTap});

  @override
  State<_AnimatedRefreshButton> createState() => _AnimatedRefreshButtonState();
}

class _AnimatedRefreshButtonState extends State<_AnimatedRefreshButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space2),
          decoration: BoxDecoration(
            color: _isPressed
                ? BauhausDesign.neutral.withOpacity(0.1)
                : BauhausDesign.surfaceWhite,
            border: Border.all(
              color: BauhausDesign.textDark,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.refresh,
            size: 14,
            color: BauhausDesign.textDark,
          ),
        ),
      ),
    );
  }
}
