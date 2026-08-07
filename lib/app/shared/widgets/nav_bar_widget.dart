import 'dart:io';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'dart:typed_data';

import 'package:carenest/app/shared/widgets/line_items_view.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/repositories/request_repository.dart';
import 'package:carenest/app/features/training_compliance/views/training_compliance_hub_view.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

import 'package:flutter/services.dart' show SystemNavigator, MethodChannel;

// Use a static GlobalKey to prevent duplicates
final _navBarScaffoldKey = GlobalKey<ScaffoldState>(
  debugLabel: 'navbar_scaffold_key',
);

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

  const NavBarWidget({
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiMethod = ref.read(apiMethodProvider);
    final theme = Theme.of(context);

    debugPrint("Navbar widget photo data: $photoData");
    return Consumer(
      builder: (context, ref, _) {
        final photoDataState = ref.watch(photoDataProvider);
        final currentPhotoData = photoDataState.photoData ?? photoData;
        final sharedPrefs = ref.watch(sharedPreferencesUtilsProvider);
        final currentImageUrl =
            sharedPrefs.getString('profilePic') ??
            sharedPrefs.getString('photoUrl');

        return SizedBox(
          width:
              MediaQuery.of(context).size.width *
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
                          style: BauhausDesign.getTextTheme(context).bodyMedium
                              ?.copyWith(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      if (organizationCode != null)
                        Text(
                          'Code: $organizationCode',
                          style: BauhausDesign.getTextTheme(context).bodyMedium
                              ?.copyWith(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.white70, // Keep specific visual
                              ),
                        ),
                    ],
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: ProfileImageWidget(
                        photoData: currentPhotoData,
                        imageUrl: currentImageUrl,
                        size: 55.0,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    image: const DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/Invo.gif'),
                    ),
                  ),
                ),
                if (role == UserRole.admin)
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text(
                      'Assign C 2 E',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontFamily: "ShadowsIntoLightTwo",
                      ),
                    ),
                    onTap: () async => {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AssignC2E(),
                        ),
                      ),
                    },
                  ),
                if (role == UserRole.admin)
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      'Line Items',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontFamily: "ShadowsIntoLightTwo",
                      ),
                    ),
                    onTap: () async => {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LineItemsView(),
                        ),
                      ),
                    },
                  ),
                if (role == UserRole.admin)
                  ListTile(
                    leading: const Icon(Icons.update),
                    title: Text(
                      'Update Holiday',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontFamily: "ShadowsIntoLightTwo",
                      ),
                    ),
                    onTap: () async {
                      var value = await apiMethod.uploadCSV();
                      if (value['message'].toString() == "Upload successful") {
                        Flushbar(
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          duration: const Duration(seconds: 3),
                          titleText: Text(
                            "Success",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "ShadowsIntoLightTwo",
                            ),
                          ),
                          messageText: Text(
                            "Holiday list updated in database",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontFamily: "ShadowsIntoLightTwo",
                            ),
                          ),
                        ).show(_navBarScaffoldKey.currentContext!);
                      }
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(
                    'Request',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontFamily: "ShadowsIntoLightTwo",
                    ),
                  ),
                  onTap: () {},
                  trailing: ClipOval(
                    child: Container(
                      color: theme.colorScheme.error,
                      width: 20,
                      height: 20,
                      child: Center(
                        child: Text(
                          '8',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: Text(
                    'Training & Compliance',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontFamily: "ShadowsIntoLightTwo",
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrainingComplianceHubView(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontFamily: "ShadowsIntoLightTwo",
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.delete_forever_outlined),
                  title: Text(
                    'Delete Account',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontFamily: "ShadowsIntoLightTwo",
                    ),
                  ),
                  onTap: () {
                    // Show the delete confirmation dialog
                    _showDeleteConfirmationDialog(context, theme, ref);
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'Exit',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontFamily: "ShadowsIntoLightTwo",
                    ),
                  ),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(
                        context,
                      ); // Pop the current screen on both platforms
                    } else {
                      final role = getRole(ref);
                      if (Platform.isAndroid) {
                        SystemNavigator.pop(); // Close the Android app
                      } else {
                        const platform = MethodChannel(
                          'app.channel.shared.data',
                        );
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

  void _showDeleteConfirmationDialog(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Start account deletion? After approval, your account is deactivated and records required for payroll, tax, audit, and care obligations are retained for up to 90 days before permanent deletion.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                _deleteAccount(theme, ref);
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

  Future<void> _deleteAccount(ThemeData theme, WidgetRef ref) async {
    try {
      final orgId = organizationId ?? ref.read(organizationIdProvider);
      final currentUser = FirebaseAuth.instance.currentUser;
      if (orgId == null || orgId.isEmpty || currentUser == null) {
        throw Exception('Missing organization or user context');
      }

      final request = RequestModel(
        organizationId: orgId,
        userId: currentUser.uid,
        type: 'ACCOUNT_DELETION',
        status: RequestStatus.pending,
        details: {
          'reason':
              'User requested account deletion from navigation drawer with 90-day retention',
          'email': email,
          'retentionDays': 90,
          'retentionReason':
              'Payroll, tax, audit, and care-service record obligations',
          'deactivateOnApproval': true,
          'requestedAt': DateTime.now().toIso8601String(),
        },
      );

      await ref.read(requestRepositoryProvider).createRequest(request, email);

      final context = _navBarScaffoldKey.currentContext!;
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        titleText: Text(
          "Deletion Requested",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "ShadowsIntoLightTwo",
          ),
        ),
        messageText: Text(
          "You have been signed out. After approval, the account is deactivated and required records are retained for up to 90 days before permanent deletion.",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontFamily: "ShadowsIntoLightTwo",
          ),
        ),
      ).show(context);

      await SessionTimeoutService(
        sharedPrefs: ref.read(sharedPreferencesUtilsProvider),
      ).logoutAndClearSession(reason: 'account_deletion_requested_from_nav');

      await Future.delayed(const Duration(milliseconds: 900));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    } catch (error) {
      final context = _navBarScaffoldKey.currentContext!;
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        titleText: Text(
          "Error",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "ShadowsIntoLightTwo",
          ),
        ),
        messageText: Text(
          error.toString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontFamily: "ShadowsIntoLightTwo",
          ),
        ),
      ).show(context);
    }
  }
}
