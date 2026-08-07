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
      color: theme.colorScheme.surface,
      child: AppBar(
        toolbarHeight: 70.0,
        elevation: 0,
        surfaceTintColor: theme.colorScheme.surface,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: theme.colorScheme.surface,
          statusBarIconBrightness: theme.brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
          statusBarBrightness: theme.brightness,
        ),
        centerTitle: false,
        titleTextStyle: theme.textTheme.headlineMedium?.copyWith(
          color: Colors.grey[800],
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

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    // Basic implementation to satisfy the compiler and usage
    // Using Bauhaus colors/style where possible
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: Colors.grey.shade300, height: 1.0),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
