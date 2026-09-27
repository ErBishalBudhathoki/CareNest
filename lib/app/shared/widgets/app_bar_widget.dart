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

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedBackground =
        backgroundColor ?? theme.colorScheme.inverseSurface;
    final resolvedForeground =
        foregroundColor ??
        (backgroundColor == null
            ? theme.colorScheme.onInverseSurface
            : ThemeData.estimateBrightnessForColor(resolvedBackground) ==
                  Brightness.dark
            ? theme.colorScheme.surface
            : theme.colorScheme.onSurface);
    return AppBar(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleLarge?.copyWith(
          color: resolvedForeground,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: resolvedBackground,
      foregroundColor: resolvedForeground,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(color: resolvedForeground, height: 2.0),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2.0);
}
