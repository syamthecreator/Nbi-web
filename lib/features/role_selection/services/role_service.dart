import '../../../core/services/base_service.dart';
import '../../../shared/models/user_role.dart';

abstract class RoleService extends BaseService {
  RoleService({super.client});

  Future<void> saveSelectedRole(UserRole role);
  Future<UserRole> getSavedRole();
}

class RoleServiceImpl extends RoleService {
  RoleServiceImpl({super.client});

  UserRole _cachedRole = UserRole.institution;

  @override
  Future<void> saveSelectedRole(UserRole role) async {
    _cachedRole = role;
    // Simulate API or local storage latency matching select-role.js
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<UserRole> getSavedRole() async {
    return _cachedRole;
  }
}
