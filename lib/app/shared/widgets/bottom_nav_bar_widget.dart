import 'package:carenest/app/core/utils/permission_manager.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'dart:typed_data';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/home/views/employee_home_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';

import 'package:carenest/app/features/settings/views/settings_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBarWidget extends ConsumerStatefulWidget {
  final String email;
  final UserRole role;
  final String organizationId;
  final String organizationName;
  final String organizationCode;
  final int? initialIndex;

  const BottomNavBarWidget({
    required this.email,
    required this.role,
    required this.organizationId,
    required this.organizationName,
    required this.organizationCode,
    this.initialIndex,
    super.key,
  });

  @override
  ConsumerState<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends ConsumerState<BottomNavBarWidget> {
  int _selectedIndex = 0;
  final Set<int> _visitedTabs = <int>{0};
  Uint8List? _photoData;
  String? _imageUrl;
  String _firstName = '';
  String _lastName = '';

  @override
  void initState() {
    super.initState();
    _selectedIndex = _normalizeInitialIndex(widget.initialIndex);
    _visitedTabs.add(_selectedIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _loadUserData();
      // Ensure the role provider is fresh from the backend
      ref.read(userRoleProvider.notifier).refreshRole();
      if (mounted) {
        await PermissionManager.requestNotificationPermission(context);
      }
    });
  }

  int _normalizeInitialIndex(int? value) {
    if (value == null) return 0;
    final maxIndex = widget.role == UserRole.admin ? 2 : 1;
    if (value < 0) return 0;
    if (value > maxIndex) return maxIndex;
    return value;
  }

  Future<void> _loadUserData() async {
    await _initializePhotoData();
    if (!mounted) return;
    try {
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();

      final firstName = sharedPrefs.getString('firstName');
      final lastName = sharedPrefs.getString('lastName');

      if (!mounted) return;
      setState(() {
        _firstName = firstName ?? '';
        _lastName = lastName ?? '';
      });
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  Future<void> _initializePhotoData() async {
    try {
      final notifier = ref.read(photoDataProvider.notifier);
      await notifier.fetchPhotoData(widget.email);
      if (!mounted) return;

      final photoState = ref.read(photoDataProvider);

      // Also get imageUrl from shared prefs if available, or we might need to fetch user data
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      final imageUrl =
          sharedPrefs.getString('profilePic') ??
          sharedPrefs.getString('photoUrl');

      if (!mounted) return;
      setState(() {
        _photoData = photoState.photoData;
        _imageUrl = imageUrl;
      });
    } catch (e) {
      debugPrint("Error in _initializePhotoData: $e");
    }
  }

  List<Widget> _getScreens() {
    // Build lazily: only the initially-visited tab is built up front. Other
    // tabs get built on first visit so their initState network calls are not
    // fired at startup while sitting in the (eager) IndexedStack.
    final screens = <Widget>[];

    if (_visitedTabs.contains(0)) {
      screens.add(_buildHomeScreen());
    } else {
      screens.add(const SizedBox.shrink());
    }

    final settingsIndex = widget.role == UserRole.admin ? 2 : 1;

    if (widget.role == UserRole.admin) {
      if (_visitedTabs.contains(1)) {
        screens.add(AssignC2E());
      } else {
        screens.add(const SizedBox.shrink());
      }
    }

    if (_visitedTabs.contains(settingsIndex)) {
      screens.add(
        SettingsView(
          organizationId: widget.organizationId,
          organizationName: widget.organizationName,
          organizationCode: widget.organizationCode,
          userEmail: widget.email,
          userName: '$_firstName $_lastName'.trim(),
          photoData: _photoData,
          imageUrl: _imageUrl,
          currentDashboardRole: widget.role,
        ),
      );
    } else {
      screens.add(const SizedBox.shrink());
    }

    return screens;
  }

  Widget _buildHomeScreen() {
    if (widget.role == UserRole.admin) {
      return AdminDashboardView(
        email: widget.email,
        photoData: _photoData,
        organizationId: widget.organizationId,
        organizationName: widget.organizationName,
        organizationCode: widget.organizationCode,
      );
    } else {
      return EmployeeHomeView(
        email: widget.email,
        photoData: _photoData,
        organizationId: widget.organizationId,
        organizationName: widget.organizationName,
        organizationCode: widget.organizationCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = _getScreens();

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border(
          top: BorderSide(
            color: BauhausDesign.neutral.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64, // Precise height for content
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavItems() {
    final items = <Widget>[
      _buildNavItem(
        0,
        Icons.home,
        Icons.home_outlined,
        'HOME',
        BauhausDesign.primary,
        BauhausDesign.textLight,
      ),
    ];

    int indexOffset = 1;
    if (widget.role == UserRole.admin) {
      items.add(
        _buildNavItem(
          1,
          Icons.how_to_reg,
          Icons.how_to_reg_outlined,
          'ASSIGN',
          BauhausDesign.accent,
          BauhausDesign.textDark,
        ),
      );
      indexOffset = 2;
    }

    items.add(
      _buildNavItem(
        indexOffset,
        Icons.settings,
        Icons.settings_outlined,
        'SETTINGS',
        BauhausDesign.neutral,
        BauhausDesign.textLight,
      ),
    );

    return items;
  }

  Widget _buildNavItem(
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label,
    Color activeBg,
    Color activeContent,
  ) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() {
        _selectedIndex = index;
        _visitedTabs.add(index);
      }),
      behavior: HitTestBehavior.opaque,
      child: isSelected
          ? _buildActiveItem(activeIcon, label, activeBg, activeContent)
          : _buildInactiveItem(inactiveIcon, label),
    );
  }

  Widget _buildActiveItem(
    IconData icon,
    String label,
    Color bgColor,
    Color contentColor,
  ) {
    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.neutral,
            offset: Offset(1.5, 1.5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: contentColor),
          const SizedBox(height: 2),
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

  Widget _buildInactiveItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: BauhausDesign.neutral),
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
