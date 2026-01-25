import 'package:carenest/app/core/utils/permission_manager.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'dart:typed_data';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
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
  // Removed unused legacy colors

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _loadUserData();
      // Request notification permission after the dashboard is loaded
      if (mounted) {
        await PermissionManager.requestNotificationPermission(context);
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        tabs: _buildNavBarItems(),
        controller: _controller,
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: BauhausDesign.surfaceLight,
            border: null,
            boxShadow: null,
          ),
        ),
        navBarHeight: 70, // Accommodate content without overflow
        navBarOverlap: const NavBarOverlap.none(),
      ),
    );
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
        icon: _buildActiveTabItem(
          Icons.home,
          'HOME',
          BauhausDesign.primary,
          BauhausDesign.textLight,
        ),
        inactiveIcon: _buildInactiveTabItem(Icons.home_outlined, 'HOME'),
        title: '',
        activeForegroundColor: BauhausDesign.primary,
        inactiveForegroundColor: BauhausDesign.neutral,
      ),
    );
  }

  PersistentTabConfig _buildPhotoUploadTab() {
    return PersistentTabConfig(
      screen: PhotoUploadScreen(email: widget.email),
      item: ItemConfig(
        icon: _buildActiveTabItem(
          Icons.person,
          'PROFILE',
          BauhausDesign.secondary,
          BauhausDesign.textLight,
        ),
        inactiveIcon: _buildInactiveTabItem(Icons.person_outline, 'PROFILE'),
        title: '',
        activeForegroundColor: BauhausDesign.secondary,
        inactiveForegroundColor: BauhausDesign.neutral,
      ),
    );
  }

  PersistentTabConfig _buildAssignC2ETab() {
    return PersistentTabConfig(
      screen: AssignC2E(),
      item: ItemConfig(
        icon: _buildActiveTabItem(
          Icons.search,
          'ASSIGN',
          BauhausDesign.accent,
          BauhausDesign.textDark,
        ),
        inactiveIcon: _buildInactiveTabItem(Icons.search_outlined, 'ASSIGN'),
        title: '',
        activeForegroundColor: BauhausDesign.neutral,
        inactiveForegroundColor: BauhausDesign.neutral,
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
        icon: _buildActiveTabItem(
          Icons.settings,
          'SETTINGS',
          BauhausDesign.neutral,
          BauhausDesign.textLight,
        ),
        inactiveIcon:
            _buildInactiveTabItem(Icons.settings_outlined, 'SETTINGS'),
        title: '',
        activeForegroundColor: BauhausDesign.neutral,
        inactiveForegroundColor: BauhausDesign.neutral,
      ),
    );
  }

  Widget _buildActiveTabItem(
    IconData icon,
    String label,
    Color bgColor,
    Color contentColor,
  ) {
    return Container(
      width: 70, // Wider to accommodate text
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.neutral,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: contentColor,
          ),
          Text(
            label,
            style: TextStyle(
              color: contentColor,
              fontWeight: FontWeight.w900,
              fontSize: 8,
              fontFamily: 'Inter',
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInactiveTabItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 20,
          color: BauhausDesign.neutral,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: BauhausDesign.neutral,
            fontWeight: FontWeight.w900,
            fontSize: 10,
            fontFamily: 'Inter',
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
