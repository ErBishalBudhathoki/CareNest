const Set<String> _adminRoleTags = {
  'admin',
  'superadmin',
  'owner',
};

const Set<String> _employeeRoleTags = {
  'employee',
};

const Set<String> _clientRoleTags = {
  'client',
  'family', // family members share client dashboard
};

enum UserRole {
  employee,
  admin,
  client,
}

class UserRoleResolver {
  const UserRoleResolver._();

  static bool isAdminTag(String? role) {
    final normalized = role?.trim().toLowerCase();
    return normalized != null && _adminRoleTags.contains(normalized);
  }

  static bool isEmployeeTag(String? role) {
    final normalized = role?.trim().toLowerCase();
    return normalized != null && _employeeRoleTags.contains(normalized);
  }

  static bool isClientTag(String? role) {
    final normalized = role?.trim().toLowerCase();
    return normalized != null && _clientRoleTags.contains(normalized);
  }

  static List<String> collectRoleTags({
    dynamic role,
    dynamic roles,
    dynamic organizationRole,
  }) {
    final tags = <String>{};

    void addTag(dynamic value) {
      final tag = value?.toString().trim().toLowerCase();
      if (tag != null && tag.isNotEmpty) {
        tags.add(tag);
      }
    }

    addTag(role);
    addTag(organizationRole);

    if (roles is List) {
      for (final entry in roles) {
        addTag(entry);
      }
    } else {
      addTag(roles);
    }

    return tags.toList(growable: false);
  }

  static UserRole resolve({
    dynamic role,
    dynamic roles,
    dynamic organizationRole,
    String? clientId,
  }) {
    final tags = collectRoleTags(
      role: role,
      roles: roles,
      organizationRole: organizationRole,
    );

    if (tags.any(isAdminTag)) {
      return UserRole.admin;
    }

    final normalizedClientId = clientId?.trim() ?? '';
    if (normalizedClientId.isNotEmpty || tags.any(isClientTag)) {
      return UserRole.client;
    }

    return UserRole.employee;
  }
}
