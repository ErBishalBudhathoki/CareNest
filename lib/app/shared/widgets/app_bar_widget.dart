import 'package:carenest/app/shared/widgets/profile_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';

class CustomAppBar extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final Uint8List? photoData;

  const CustomAppBar({
    super.key,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.photoData,
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
        title: ProfilePlaceholder(
          firstName: firstName,
          lastName: lastName,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 24,
              top: 4,
            ),
            child: CircleAvatar(
              radius: 27.5,
              child: ClipOval(
                child: CircleAvatar(
                  radius: 25.0,
                  child: ProfileImageWidget(photoData: photoData),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
