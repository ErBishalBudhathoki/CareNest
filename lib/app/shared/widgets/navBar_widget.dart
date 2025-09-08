import 'dart:io';
import 'dart:typed_data';
import 'package:carenest/app/features/auth/models/user_role.dart';

import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/app/shared/widgets/line_items_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

import 'package:flutter/services.dart' show SystemNavigator, MethodChannel;
import 'package:flutter/foundation.dart'
    show kIsWeb, kReleaseMode, TargetPlatform;

// Use a static GlobalKey to prevent duplicates
final _navBarScaffoldKey =
    GlobalKey<ScaffoldState>(debugLabel: 'navbar_scaffold_key');

class NavBarWidget extends ConsumerWidget {
  final BuildContext context;
  final String email;
  final String firstName;
  final String lastName;
  final Key? photoDisplayKey;
  final Uint8List? photoData;
  final UserRole role;
  final PersistentTabController? controller;
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;

  NavBarWidget({
    super.key,
    required this.context,
    required this.email,
    this.photoDisplayKey,
    this.photoData,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.controller,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    Uint8List? photoDataFromParent,
  });

  // Use the static GlobalKey instead of creating a new one for each instance
  ApiMethod apiMethod = ApiMethod();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Navbar widget photo data: $photoData");
    return Consumer(
      builder: (context, ref, _) {
        final photoDataState = ref.watch(photoDataProvider);
        final currentPhotoData = photoDataState.photoData ?? photoData;
        debugPrint(
            'NavBarWidget - Photo data from provider: ${photoDataState.photoData != null ? 'length ${photoDataState.photoData!.length}' : 'null'}');
        debugPrint(
            'NavBarWidget - Using photo data: ${currentPhotoData != null ? 'length ${currentPhotoData.length}' : 'null'}');

        return SizedBox(
          width: MediaQuery.of(context).size.width *
              0.5, // Adjust the width as needed
          child: Drawer(
            key: _navBarScaffoldKey,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('$firstName $lastName'),
                  accountEmail: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(email),
                      if (organizationName != null)
                        Text(
                          'Org: $organizationName',
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      if (organizationCode != null)
                        Text(
                          'Code: $organizationCode',
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                    ],
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: ProfileImageWidget(
                        photoData: currentPhotoData,
                        size: 55.0,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: ModernSaasDesign.primary,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/Invo.gif'),
                    ),
                  ),
                ),
                if (role == UserRole.admin)
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Assign C 2 E',
                        style: TextStyle(
                            color: ModernSaasDesign.textPrimary,
                            fontFamily: "ShadowsIntoLightTwo")),
                    onTap: () async => {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AssignC2E(),
                        ),
                      )
                    },
                  ),
                if (role == UserRole.admin)
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Line Items',
                        style: TextStyle(
                            color: ModernSaasDesign.textPrimary,
                            fontFamily: "ShadowsIntoLightTwo")),
                    onTap: () async => {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LineItemsView(),
                        ),
                      )
                    },
                  ),
                if (role == UserRole.admin)
                  ListTile(
                    leading: const Icon(Icons.update),
                    title: const Text('Update Holiday',
                        style: TextStyle(
                            color: ModernSaasDesign.textPrimary,
                            fontFamily: "ShadowsIntoLightTwo")),
                    onTap: () async {
                      var value = await apiMethod.uploadCSV();
                      if (value['message'].toString() == "Upload successful") {
                        Flushbar(
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          backgroundColor: ModernSaasDesign.secondary,
                          duration: const Duration(seconds: 3),
                          titleText: const Text(
                            "Success",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: ModernSaasDesign.textOnPrimary,
                                fontFamily: "ShadowsIntoLightTwo"),
                          ),
                          messageText: const Text(
                            "Holiday list updated in database",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: ModernSaasDesign.textOnPrimary,
                                fontFamily: "ShadowsIntoLightTwo"),
                          ),
                        ).show(_navBarScaffoldKey.currentContext!);
                      }
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Request',
                      style: TextStyle(
                          color: ModernSaasDesign.textPrimary,
                          fontFamily: "ShadowsIntoLightTwo")),
                  onTap: () {},
                  trailing: ClipOval(
                    child: Container(
                      color: ModernSaasDesign.error,
                      width: 20,
                      height: 20,
                      child: const Center(
                        child: Text(
                          '8',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings',
                      style: TextStyle(
                          color: ModernSaasDesign.textPrimary,
                          fontFamily: "ShadowsIntoLightTwo")),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.delete_forever_outlined),
                  title: const Text('Delete Account',
                      style: TextStyle(
                          color: ModernSaasDesign.textPrimary,
                          fontFamily: "ShadowsIntoLightTwo")),
                  onTap: () {
                    // Show the delete confirmation dialog
                    _showDeleteConfirmationDialog(context);
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Exit',
                      style: TextStyle(
                          color: ModernSaasDesign.textPrimary,
                          fontFamily: "ShadowsIntoLightTwo")),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(
                          context); // Pop the current screen on both platforms
                    } else {
                      final role = getRole(ref);
                      if (Platform.isAndroid) {
                        SystemNavigator.pop(); // Close the Android app
                      } else {
                        //exit(0);
                        const platform =
                            MethodChannel('app.channel.shared.data');
                        platform.invokeMethod('exitApp');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getRole(WidgetRef ref) {
    final prefsUtils = ref.read(sharedPreferencesUtilsProvider);
    UserRole? role = prefsUtils.getRole();
    debugPrint("Role: $role");
    return role.toString();
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform the delete operation
                _deleteAccount();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Dismiss the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    try {
      final response = await apiMethod.deleteUser(email);
      if (response.containsKey('message')) {
        if (response['message'].toString() == "User deleted successfully") {
          Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            backgroundColor: ModernSaasDesign.secondary,
            duration: const Duration(seconds: 3),
            titleText: const Text(
              "Success",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: ModernSaasDesign.textOnPrimary,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
            messageText: const Text(
              "User deleted successfully",
              style: TextStyle(
                  fontSize: 16.0,
                  color: ModernSaasDesign.textOnPrimary,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
          ).show(_navBarScaffoldKey.currentContext!);

          // Navigate to login after success message
          await Future.delayed(
              const Duration(seconds: 3)); // Delay for message visibility
          Navigator.of(_navBarScaffoldKey.currentContext!).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        } else {
          // Handle other messages or errors
          Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            backgroundColor: ModernSaasDesign.warning,
            duration: const Duration(seconds: 3),
            titleText: const Text(
              "Error",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: ModernSaasDesign.textOnPrimary,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
            messageText: const Text(
              "Failed to delete user, try again later",
              style: TextStyle(
                  fontSize: 16.0,
                  color: ModernSaasDesign.textOnPrimary,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
          ).show(_navBarScaffoldKey.currentContext!);
        }
      } else {
        // Handle unexpected response or errors
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: ModernSaasDesign.warning,
          duration: const Duration(seconds: 3),
          titleText: const Text(
            "Server error",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: ModernSaasDesign.textOnPrimary,
                fontFamily: "ShadowsIntoLightTwo"),
          ),
          messageText: const Text(
            "Server error, try again later",
            style: TextStyle(
                fontSize: 16.0,
                color: ModernSaasDesign.textOnPrimary,
                fontFamily: "ShadowsIntoLightTwo"),
          ),
        ).show(_navBarScaffoldKey.currentContext!);
      }
    } catch (error) {
      // Handle any errors during the API call
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: ModernSaasDesign.secondary,
        duration: const Duration(seconds: 3),
        titleText: const Text(
          "Error",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: ModernSaasDesign.textOnPrimary,
              fontFamily: "ShadowsIntoLightTwo"),
        ),
        messageText: Text(
          error.toString(),
          style: const TextStyle(
              fontSize: 16.0,
              color: ModernSaasDesign.warning,
              fontFamily: "ShadowsIntoLightTwo"),
        ),
      ).show(_navBarScaffoldKey.currentContext!);
    }
  }
}
