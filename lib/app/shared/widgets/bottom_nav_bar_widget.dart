import 'package:carenest/app/core/utils/permission_manager.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/home/views/employee_home_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';

import 'package:carenest/app/features/settings/views/settings_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBarWidget extends ConsumerStatefulWidget {
  final String email;
  final UserRole role;
  final String organizationId;
  final String organizationName;
  final String organizationCode;
  final int? initialIndex;

  /// Overrides the tab contents.
  ///
  /// The real screens each boot Firebase and fire network work from initState,
  /// which makes the shell's own navigation/back behaviour impossible to test
  /// in isolation. Tests pass lightweight placeholders here. Production leaves
  /// it null and gets the real dashboards.
  final List<Widget> Function(BuildContext context)? screensBuilder;

  const BottomNavBarWidget({
    required this.email,
    required this.role,
    required this.organizationId,
    required this.organizationName,
    required this.organizationCode,
    this.initialIndex,
    this.screensBuilder,
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
        // Safe to call un-awaited: PermissionManager guards itself, so a
        // Firebase or prefs failure here cannot become an unhandled async error.
        // (This runs once per shell instance, from initState.)
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
    final override = widget.screensBuilder;
    if (override != null) {
      return override(context);
    }

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

    // Back handling.
    //
    // This shell is a single route, and its tabs are siblings inside an
    // IndexedStack rather than routes. So the system back gesture had nothing to
    // pop while a non-first tab was selected: Navigator.maybePop returned false,
    // Android fell through to the default popRoute, and the activity was
    // finished. Settings also has no app bar of its own, so pressing back from
    // the Settings tab closed the app instead of returning to the dashboard —
    // which looked like the app dropping into a splash-screen loop, because the
    // next launch is a cold start through SplashScreen.
    //
    // canPop is only true on the first tab, so back still exits the app from
    // there (unchanged behaviour) but simply returns to the dashboard from any
    // other tab.
    final canExitApp = _selectedIndex == 0;

    return PopScope(
      // Named so the back contract can be asserted directly in tests rather
      // than inferred from behaviour. `find.byType(PopScope)` is unreliable
      // because PopScope is generic and the inferred type argument is not stable.
      key: const ValueKey('bottom_nav_back_scope'),
      canPop: canExitApp,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (!mounted) return;
        setState(() {
          _selectedIndex = 0;
          _visitedTabs.add(0);
        });
      },
      child: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: screens),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border(top: BorderSide(color: colorScheme.outline, width: 2)),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64, // Precise height for content
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavItems(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final items = <Widget>[
      _buildNavItem(
        0,
        Icons.home,
        Icons.home_outlined,
        'HOME',
        colorScheme.primary,
        colorScheme.onPrimary,
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
          colorScheme.tertiary,
          colorScheme.onTertiary,
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
        colorScheme.inverseSurface,
        colorScheme.onInverseSurface,
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

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() {
            _selectedIndex = index;
            _visitedTabs.add(index);
          });
        },
        child: Container(
          constraints: const BoxConstraints(minWidth: 72, minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: isSelected
              ? _buildActiveItem(
                  context,
                  activeIcon,
                  label,
                  activeBg,
                  activeContent,
                )
              : _buildInactiveItem(context, inactiveIcon, label),
        ),
      ),
    );
  }

  Widget _buildActiveItem(
    BuildContext context,
    IconData icon,
    String label,
    Color bgColor,
    Color contentColor,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.zero,
        border: Border.all(color: colorScheme.outline, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.neoInk,
            offset: Offset(3, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: contentColor, semanticLabel: label),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: contentColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInactiveItem(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
