import '../../../shared/models/user_role.dart';
import '../models/role_item_model.dart';
import '../services/role_service.dart';

abstract class RoleRepository {
  List<RoleItemModel> getAvailableRoles();
  Future<void> saveRole(UserRole role);
  Future<UserRole> getActiveRole();
}

class RoleRepositoryImpl implements RoleRepository {
  final RoleService roleService;

  RoleRepositoryImpl({RoleService? service})
      : roleService = service ?? RoleServiceImpl();

  @override
  List<RoleItemModel> getAvailableRoles() {
    return RoleItemModel.defaultRoles();
  }

  @override
  Future<void> saveRole(UserRole role) async {
    await roleService.saveSelectedRole(role);
  }

  @override
  Future<UserRole> getActiveRole() async {
    return await roleService.getSavedRole();
  }
}
