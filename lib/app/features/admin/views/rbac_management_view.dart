import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/backend/api_method.dart';

class RBACManagementView extends ConsumerStatefulWidget {
  const RBACManagementView({super.key});

  @override
  ConsumerState<RBACManagementView> createState() => _RBACManagementViewState();
}

class _RBACManagementViewState extends ConsumerState<RBACManagementView> {
  late final ApiMethod _api;
  bool _isLoading = true;
  List<String> _permissions = [];
  Map<String, List<String>> _rolePermissions = {}; // Map Role ID to Permissions
  List<dynamic> _roles = [];

  String _selectedRoleId = 'admin'; // Default to admin

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    try {
      final response = await _api.get('api/rbac/roles');
      if (response['success'] == true) {
        final data = response['data'];
        setState(() {
          _roles = data['roles'];
          _permissions = List<String>.from(data['availablePermissions']);
          
          // Map permissions
          _rolePermissions = {};
          for (var role in _roles) {
            _rolePermissions[role['id']] = List<String>.from(role['permissions']);
          }
          
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching roles: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updatePermission(String roleId, String permission, bool isGranted) async {
    // Optimistic Update
    setState(() {
      if (isGranted) {
        _rolePermissions[roleId]!.add(permission);
      } else {
        _rolePermissions[roleId]!.remove(permission);
      }
    });

    try {
      await _api.put('api/rbac/roles/$roleId/permissions', body: {
        'permissions': _rolePermissions[roleId]
      });
    } catch (e) {
      // Revert on error
      setState(() {
        if (isGranted) {
          _rolePermissions[roleId]!.remove(permission);
        } else {
          _rolePermissions[roleId]!.add(permission);
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update permission: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: BauhausTheme.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.roleManagementTitle, style: BauhausTheme.headerStyle),
        backgroundColor: BauhausTheme.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausTheme.black),
      ),
      body: Column(
        children: [
          // Role Selector Tab Bar
          Container(
            height: 60,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BauhausTheme.black, width: 2)),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _roles.map((role) {
                final isSelected = role['id'] == _selectedRoleId;
                return GestureDetector(
                  onTap: () => setState(() => _selectedRoleId = role['id']),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: isSelected ? BauhausTheme.blue : BauhausTheme.white,
                    child: Center(
                      child: Text(
                        role['name'].toUpperCase(),
                        style: isSelected
                            ? BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white)
                            : BauhausTheme.subHeaderStyle,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Permissions List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _permissions.length,
              itemBuilder: (context, index) {
                final permission = _permissions[index];
                final isEnabled = _rolePermissions[_selectedRoleId]?.contains(permission) ?? false;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BauhausTheme.blockDecoration.copyWith(
                    color: isEnabled ? BauhausTheme.yellow.withOpacity(0.1) : BauhausTheme.white,
                  ),
                  child: SwitchListTile(
                    title: Text(permission, style: BauhausTheme.subHeaderStyle),
                    subtitle: Text(isEnabled ? AppLocalizations.of(context)!.accessGranted : AppLocalizations.of(context)!.accessDenied, style: BauhausTheme.bodyStyle),
                    value: isEnabled,
                    activeColor: BauhausTheme.blue,
                    onChanged: _selectedRoleId == 'admin' 
                      ? null // Cannot edit Admin permissions (always full)
                      : (bool value) => _updatePermission(_selectedRoleId, permission, value),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
