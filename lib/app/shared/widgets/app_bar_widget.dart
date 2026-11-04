import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/profile_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';

class CustomAppBar extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final Uint8List? photoData;
  final String? imageUrl;

  const CustomAppBar({
    super.key,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.photoData,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.inverseSurface,
      child: AppBar(
        toolbarHeight: 70.0,
        elevation: 0,
        surfaceTintColor: theme.colorScheme.inverseSurface,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: false,
        titleTextStyle: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onInverseSurface,
        ),
        title: ProfilePlaceholder(firstName: firstName, lastName: lastName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24, top: 4),
            child: CircleAvatar(
              radius: 27.5,
              child: ClipOval(
                child: CircleAvatar(
                  radius: 25.0,
                  child: ProfileImageWidget(
                    photoData: photoData,
                    imageUrl: imageUrl,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Standard Bauhaus AppBar that matches the "All Invoices" reference design.
/// Uses BauhausDesign.primary (amber/yellow) background with a 2px bottom
/// border matching the app-wide Bauhaus design system.
///
/// Use [backgroundColor] and [foregroundColor] only when you intentionally
/// need to deviate from the standard (e.g., error states).
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final Widget? leading;
  final List<Widget>? actions;
  // Override background only when intentionally deviating from the standard
  final Color? backgroundColor;
  // Override foreground only when intentionally deviating from the standard
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;

  const AppBarWidget({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Default to BauhausDesign.primary (amber/yellow) matching the reference design
    final resolvedBackground = backgroundColor ?? BauhausDesign.primary;
    // Default foreground: onPrimary for standard primary bg, or infer from custom bg
    final resolvedForeground =
        foregroundColor ??
        (backgroundColor == null
            ? theme.colorScheme.onPrimary
            : ThemeData.estimateBrightnessForColor(resolvedBackground) ==
                  Brightness.dark
            ? theme.colorScheme.surface
            : theme.colorScheme.onSurface);

    return AppBar(
      title: titleWidget ?? (title != null
          ? Text(
              title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              // Match reference: titleLarge + w800 weight
              style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: resolvedForeground,
                fontWeight: FontWeight.w800,
              ),
            )
          : null),
      centerTitle: true,
      backgroundColor: resolvedBackground,
      foregroundColor: resolvedForeground,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      // Match reference: 2px solid bottom border using onSurface color
      shape: Border(
        bottom: BorderSide(
          color: theme.colorScheme.onSurface,
          width: 2,
        ),
      ),
      leading: leading ?? (showBackButton
          ? IconButton(
              tooltip: 'Back',
              icon: Icon(Icons.arrow_back, color: resolvedForeground, size: 24),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  // Height = kToolbarHeight (56) + bottom height
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
