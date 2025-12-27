import 'package:carenest/app/core/providers/app_providers.dart';
import 'dart:typed_data';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/home/views/home_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/photo/views/photo_upload_view.dart';
import 'package:carenest/app/features/settings/views/settings_view.dart';

import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';


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
  final bool _isLoading = true;
  String _firstName = '';
  String _lastName = '';

  // Color constants
  static const Color _primaryColor = Color(0xFF6366F1);
  static const Color _gray100 = Color(0xFFF3F4F6);
  static const Color _gray200 = Color(0xFFE5E7EB);

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
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
      await ref.read(photoDataProvider.notifier).fetchPhotoData(widget.email);
      final photoState = ref.read(photoDataProvider);

      setState(() {
        _photoData = photoState.photoData;
      });

      if (photoState.photoData != null) {
        debugPrint("Photo data successfully loaded in BottomNavBarWidget");
      } else {
        debugPrint("No photo data available in BottomNavBarWidget");
      }
    } catch (e) {
      debugPrint("Error in _initializePhotoData: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PersistentTabConfig> _buildNavBarItems() {
    debugPrint("BottomNavBarWidget role: ${widget.role}");
    if (widget.role == UserRole.admin) {
      return [
        _buildHomeTab(),
        _buildAssignC2ETab(),
        _buildPhotoUploadTab(),
        _buildSettingsTab(),
      ];
    } else {
      return [
        _buildHomeTab(),
        _buildPhotoUploadTab(),
        _buildSettingsTab(),
      ];
    }
  }

  List<PersistentTabConfig> _buildLoadingTabs() {
    if (widget.role == UserRole.admin) {
      return [
        _buildHomeTab(),
        _buildAssignC2ETab(),
        _buildPhotoUploadTab(),
        _buildSettingsTab(),
      ];
    } else {
      return [
        _buildHomeTab(),
        _buildPhotoUploadTab(),
        _buildSettingsTab(),
      ];
    }
  }

  PersistentTabConfig _buildHomeTab() {
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
        activeForegroundColor: _primaryColor,
        inactiveBackgroundColor: _gray100,
      ),
    );
  }

  PersistentTabConfig _buildPhotoUploadTab() {
    return PersistentTabConfig(
      screen: PhotoUploadScreen(email: widget.email),
      item: ItemConfig(
        icon: const Icon(Icons.person),
        title: 'Profile Photo',
        activeForegroundColor: _primaryColor,
        inactiveBackgroundColor: _gray100,
      ),
    );
  }

  PersistentTabConfig _buildAssignC2ETab() {
    return PersistentTabConfig(
      screen: AssignC2E(),
      item: ItemConfig(
        icon: const Icon(Icons.search),
        title: 'Assign',
        activeForegroundColor: _primaryColor,
        inactiveBackgroundColor: _gray100,
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
        activeForegroundColor: _primaryColor,
        inactiveBackgroundColor: _gray100,
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
          navBarDecoration: NavBarDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: _gray200, width: 0.3),
            ),
          ),
        ),
        navBarOverlap: const NavBarOverlap.none(),
      ),
    );
  }
}
