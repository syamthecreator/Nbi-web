import 'package:flutter/material.dart';
import '../../../shared/models/user_role.dart';
import '../models/role_item_model.dart';
import '../repositories/role_repository.dart';

/// Pure Stateless architecture with Provider. Zero setState().
class RoleProvider extends ChangeNotifier {
  final RoleRepository _repository;
  UserRole _selectedRole = UserRole.institution;
  bool _isSaving = false;

  RoleProvider({RoleRepository? repository})
      : _repository = repository ?? RoleRepositoryImpl();

  UserRole get selectedRole => _selectedRole;
  bool get isSaving => _isSaving;
  List<RoleItemModel> get availableRoles => _repository.getAvailableRoles();

  void selectRole(UserRole role) {
    if (_selectedRole != role) {
      _selectedRole = role;
      notifyListeners();
    }
  }

  Future<void> submitRole(VoidCallback onComplete) async {
    _isSaving = true;
    notifyListeners();

    await _repository.saveRole(_selectedRole);

    _isSaving = false;
    notifyListeners();
    onComplete();
  }
}
