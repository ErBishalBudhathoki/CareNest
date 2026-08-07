import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RBACManagementView extends ConsumerStatefulWidget {
  const RBACManagementView({super.key});

  @override
  ConsumerState<RBACManagementView> createState() => _RBACManagementViewState();
}

class _RBACManagementViewState extends ConsumerState<RBACManagementView> {
  late final ApiMethod _api;
  bool _isLoading = true;
  List<String> _permissions = <String>[];
  Map<String, List<String>> _rolePermissions = <String, List<String>>{};
  List<dynamic> _roles = <dynamic>[];

  String _selectedRoleId = 'admin';

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    try {
      final response = await _api.get('rbac/roles');
      if (!mounted) return;

      if (response['success'] == true) {
        final data = response['data'] as Map<String, dynamic>? ?? {};
        final roles = (data['roles'] as List?) ?? <dynamic>[];
        final availablePermissions =
            (data['availablePermissions'] as List?) ?? <dynamic>[];

        final rolePermissions = <String, List<String>>{};
        for (final role in roles) {
          if (role is! Map) continue;
          final roleId = (role['id'] ?? '').toString();
          if (roleId.isEmpty) continue;
          final rolePerms = (role['permissions'] as List?) ?? <dynamic>[];
          rolePermissions[roleId] = rolePerms.map((e) => e.toString()).toList();
        }

        final defaultRoleId = rolePermissions.containsKey(_selectedRoleId)
            ? _selectedRoleId
            : (roles.isNotEmpty
                  ? ((roles.first as Map)['id'] ?? 'admin').toString()
                  : 'admin');

        setState(() {
          _roles = roles;
          _permissions = availablePermissions
              .map((e) => e.toString())
              .toList(growable: false);
          _rolePermissions = rolePermissions;
          _selectedRoleId = defaultRoleId;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        _showError(AppLocalizations.of(context)!.requestFailed);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError(AppLocalizations.of(context)!.requestFailed);
    }
  }

  Future<void> _updatePermission(
    String roleId,
    String permission,
    bool isGranted,
  ) async {
    final current = List<String>.from(_rolePermissions[roleId] ?? <String>[]);

    if (isGranted) {
      if (!current.contains(permission)) current.add(permission);
    } else {
      current.remove(permission);
    }

    setState(() {
      _rolePermissions[roleId] = current;
    });

    try {
      final response = await _api.put(
        'rbac/roles/$roleId/permissions',
        body: {'permissions': current},
      );

      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Failed to save permission');
      }
    } catch (_) {
      if (!mounted) return;
      final reverted = List<String>.from(
        _rolePermissions[roleId] ?? <String>[],
      );
      if (isGranted) {
        reverted.remove(permission);
      } else {
        if (!reverted.contains(permission)) reverted.add(permission);
      }
      setState(() {
        _rolePermissions[roleId] = reverted;
      });
      _showError(AppLocalizations.of(context)!.requestFailed);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: BauhausDesign.surfaceLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          side: const BorderSide(color: BauhausDesign.error, width: 2),
        ),
        content: Text(
          message,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String _selectedRoleName() {
    for (final role in _roles) {
      if (role is Map && role['id']?.toString() == _selectedRoleId) {
        return role['name']?.toString() ?? _selectedRoleId;
      }
    }
    return _selectedRoleId;
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border(
            bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: BauhausDesign.textDark,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.roleManagementTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).displaySmall?.copyWith(color: BauhausDesign.textDark),
                  ),
                ),
                IconButton(
                  tooltip: AppLocalizations.of(context)!.reloadAllTooltip,
                  onPressed: _fetchRoles,
                  icon: const Icon(
                    Icons.refresh,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleTabs() {
    return Container(
      height: 58,
      margin: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _roles.length,
        separatorBuilder: (_, _) => const VerticalDivider(
          width: 1,
          thickness: 1,
          color: BauhausDesign.neutral,
        ),
        itemBuilder: (context, index) {
          final role = _roles[index];
          final roleId = role['id']?.toString() ?? '';
          final roleName = role['name']?.toString() ?? roleId;
          final isSelected = roleId == _selectedRoleId;

          return Material(
            color: isSelected
                ? BauhausDesign.neutral
                : BauhausDesign.surfaceLight,
            child: InkWell(
              onTap: () => setState(() => _selectedRoleId = roleId),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minWidth: 120),
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space4,
                ),
                child: Text(
                  roleName.toUpperCase(),
                  style: BauhausDesign.getTextTheme(context).labelLarge
                      ?.copyWith(
                        color: isSelected
                            ? BauhausDesign.surfaceLight
                            : BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoleStatusStrip() {
    final isAdminRole = _selectedRoleId == 'admin';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.admin_panel_settings,
            color: BauhausDesign.secondary,
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Text(
              'Role: ${_selectedRoleName()}',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space2,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: isAdminRole
                  ? BauhausDesign.warning
                  : BauhausDesign.success,
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: Text(
              isAdminRole ? 'LOCKED' : 'EDITABLE',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionList() {
    final isAdminRole = _selectedRoleId == 'admin';
    if (_permissions.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noData,
          style: BauhausDesign.getTextTheme(
            context,
          ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      itemCount: _permissions.length,
      itemBuilder: (context, index) {
        final permission = _permissions[index];
        final isEnabled =
            _rolePermissions[_selectedRoleId]?.contains(permission) ?? false;
        return Container(
          margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(
              color: isEnabled
                  ? BauhausDesign.secondary
                  : BauhausDesign.neutral,
              width: 2,
            ),
            boxShadow: const [BauhausDesign.shadowHardXs],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      permission,
                      style: BauhausDesign.getTextTheme(context).bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      isEnabled
                          ? AppLocalizations.of(context)!.accessGranted
                          : AppLocalizations.of(context)!.accessDenied,
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              BauhausSwitch(
                value: isEnabled,
                enabled: !isAdminRole,
                variant: BauhausSwitchVariant.secondary,
                onChanged: (value) =>
                    _updatePermission(_selectedRoleId, permission, value),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary),
            )
          : Column(
              children: [
                const SizedBox(height: BauhausDesign.space4),
                _buildRoleTabs(),
                const SizedBox(height: BauhausDesign.space3),
                _buildRoleStatusStrip(),
                const SizedBox(height: BauhausDesign.space3),
                Expanded(child: _buildPermissionList()),
              ],
            ),
    );
  }
}
