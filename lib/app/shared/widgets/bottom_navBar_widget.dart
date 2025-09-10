import 'dart:typed_data';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/home/views/home_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/photo/views/photo_upload_view.dart';
import 'package:carenest/app/features/settings/views/settings_view.dart';
import 'package:flutter/foundation.dart';

import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'navBar_widget.dart';

class BottomNavBarWidget extends ConsumerStatefulWidget {
  final String email;
  final UserRole role;
  final String organizationId;
  final String organizationName;
  final String organizationCode;

  const BottomNavBarWidget({
    required this.email,
    required this.role,
    required this.organizationId,
    required this.organizationName,
    required this.organizationCode,
    super.key,
  });

  @override
  ConsumerState<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends ConsumerState<BottomNavBarWidget> {
  late PersistentTabController _controller;
  Uint8List? _photoData;
  bool _isLoading = true;
  String _firstName = '';
  String _lastName = '';

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData(); // _initializePhotoData will be called within _loadUserData
    });
  }

  Future<void> _loadUserData() async {
    // Initialize photo data after loading user data
    await _initializePhotoData();
    try {
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();

      final firstName = sharedPrefs.getString('firstName');
      final lastName = sharedPrefs.getString('lastName');

      setState(() {
        _firstName = firstName ?? '';
        _lastName = lastName ?? '';
      });
    } catch (e) {
      debugPrint('Error loading user data: $e');
      setState(() {
        _firstName = '';
        _lastName = '';
      });
    }
  }

  Future<void> _initializePhotoData() async {
    debugPrint("=== _initializePhotoData started, _isLoading: $_isLoading ===");
    try {
      // Fetch photo data using the provider
      await ref.read(photoDataProvider.notifier).fetchPhotoData(widget.email);
      final photoState = ref.read(photoDataProvider);

      // debugPrint("=== Photo state after fetch ===");
      // debugPrint(
      //     "photoData: ${photoState.photoData != null ? 'length ${photoState.photoData!.length}' : 'null'}");
      // debugPrint("isLoading: ${photoState.isLoading}");
      // debugPrint("error: ${photoState.error}");

      // Always update the state regardless of whether photo data is available
      setState(() {
        _photoData = photoState.photoData;
        // _isLoading = false; // Ensure loading state is set to false
        // debugPrint("setState called, _isLoading set to: $_isLoading");
      });

      if (photoState.photoData != null) {
        debugPrint("Photo data successfully loaded in BottomNavBarWidget");
      } else {
        debugPrint("No photo data available in BottomNavBarWidget");
      }
    } catch (e) {
      debugPrint("Error in _initializePhotoData: $e");
      // Ensure loading state is set to false even in case of error
      // setState(() {
      //   _isLoading = false;
      //   debugPrint("setState called in catch block, _isLoading set to: $_isLoading");
      // }
      // );
    } finally {
      // Add a final check to ensure _isLoading is false
      // if (_isLoading) {
      //   debugPrint(
      //       "WARNING: _isLoading is still true in finally block, forcing to false");
      //   setState(() {
      //     _isLoading = false;
      //     debugPrint(
      //         "setState called in finally block, _isLoading set to: $_isLoading");
      //   });
      // } else {
      //   debugPrint("_isLoading is already false in finally block");
      // }
      // debugPrint("=== _initializePhotoData completed, _isLoading: $_isLoading ===");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PersistentTabConfig> _buildNavBarItems() {
    // Show loading tabs while data is being fetched
    // if (_isLoading) {
    //   return _buildLoadingTabs();
    // }
    debugPrint("BottomNavBarWidget role: ${widget.role}");
    if (widget.role == UserRole.admin) {
      // Admin: Home (AdminDashboard), Profile Photo, Settings, Assign C 2 E
      return [
        _buildHomeTab(),
        _buildAssignC2ETab(),
        _buildPhotoUploadTab(),
        _buildSettingsTab(),
      ];
    } else {
      // Normal user: Home, Profile Photo, Settings
      return [
        _buildHomeTab(),
        _buildPhotoUploadTab(),
        _buildSettingsTab(),
      ];
    }
  }

  List<PersistentTabConfig> _buildLoadingTabs() {
    // Instead of showing loading indicators, build the actual tabs
    // This prevents the "Nav Bar item index cannot be less than 0" error
    if (widget.role == UserRole.admin) {
      // Admin: Home (AdminDashboard), Assign C 2 E, Profile Photo, Settings
      return [
        _buildHomeTab(),
        _buildAssignC2ETab(),
        _buildPhotoUploadTab(),
        _buildSettingsTab(),
      ];
    } else {
      // Normal user: Home, Profile Photo, Settings
      return [
        _buildHomeTab(),
        _buildPhotoUploadTab(),
        _buildSettingsTab(),
      ];
    }
  }

  PersistentTabConfig _buildHomeTab() {
    // Show AdminDashboardView for admin users, HomeView for normal users
    Widget homeScreen;
    if (widget.role == UserRole.admin) {
      homeScreen = AdminDashboardView(
        email: widget.email,
        photoData: _photoData,
        controller: _controller,
        organizationId: widget.organizationId,
        organizationName: widget.organizationName,
        organizationCode: widget.organizationCode,
      );
    } else {
      homeScreen = HomeView(
        email: widget.email,
        photoData: _photoData,
        controller: _controller,
        organizationId: widget.organizationId,
        organizationName: widget.organizationName,
        organizationCode: widget.organizationCode,
      );
    }

    return PersistentTabConfig(
      screen: homeScreen,
      item: ItemConfig(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeForegroundColor: ModernSaasDesign.primary,
        inactiveBackgroundColor: ModernSaasDesign.secondary,
      ),
    );
  }

  PersistentTabConfig _buildPhotoUploadTab() {
    return PersistentTabConfig(
      screen: PhotoUploadScreen(email: widget.email),
      item: ItemConfig(
        icon: const Icon(Icons.person),
        title: 'Profile Photo',
        activeForegroundColor: ModernSaasDesign.primary,
        inactiveBackgroundColor: ModernSaasDesign.secondary,
      ),
    );
  }

  PersistentTabConfig _buildAssignC2ETab() {
    return PersistentTabConfig(
      screen: AssignC2E(),
      item: ItemConfig(
        icon: const Icon(Icons.search),
        title: 'Assign',
        activeForegroundColor: ModernSaasDesign.primary,
        inactiveBackgroundColor: ModernSaasDesign.secondary,
      ),
    );
  }

  PersistentTabConfig _buildSettingsTab() {
    return PersistentTabConfig(
      screen: SettingsView(
        organizationId: widget.organizationId,
        organizationName: widget.organizationName,
        organizationCode: widget.organizationCode,
        userEmail: widget.email,
        userName: '$_firstName $_lastName'.trim(),
        photoData: _photoData,
      ),
      item: ItemConfig(
        icon: const Icon(Icons.settings),
        title: 'Settings',
        activeForegroundColor: ModernSaasDesign.primary,
        inactiveBackgroundColor: ModernSaasDesign.secondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        tabs: _buildNavBarItems(),
        controller: _controller,
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: const NavBarDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            ),
          ),
        ),
        navBarOverlap: const NavBarOverlap.none(),
      ),
    );
  }
}
