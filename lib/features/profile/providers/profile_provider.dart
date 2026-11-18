import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../repositories/profile_repository.dart';

/// Pure Stateless architecture with Provider. Zero setState().
class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _repository;

  String _fullName = 'Rahul Dev Sharma';
  String _email = 'rahul.sharma@nbi-school.edu.in';
  String _phone = '9876543210';
  String _role = 'Student'; // 'Student' or 'Parent'

  String get fullName => _fullName;
  String get email => _email;
  String get phone => _phone;
  String get role => _role;

  // Edit Profile Modal State
  bool _isEditModalOpen = false;
  bool get isEditModalOpen => _isEditModalOpen;

  String _editFullName = '';
  String _editEmail = '';
  String _editPhone = '';

  String get editFullName => _editFullName;
  String get editEmail => _editEmail;
  String get editPhone => _editPhone;

  // Role Dropdown Open State
  bool _isRoleDropdownOpen = false;
  bool get isRoleDropdownOpen => _isRoleDropdownOpen;

  String? _toastMessage;
  String? get toastMessage => _toastMessage;

  ProfileProvider({ProfileRepository? repository})
      : _repository = repository ?? ProfileRepositoryImpl();

  void setRole(String newRole) {
    if (_role != newRole) {
      _role = newRole;
      _isRoleDropdownOpen = false;
      notifyListeners();
    }
  }

  void toggleRoleDropdown() {
    _isRoleDropdownOpen = !_isRoleDropdownOpen;
    notifyListeners();
  }

  void closeRoleDropdown() {
    if (_isRoleDropdownOpen) {
      _isRoleDropdownOpen = false;
      notifyListeners();
    }
  }

  void openEditModal() {
    _editFullName = _fullName;
    _editEmail = _email;
    _editPhone = _phone;
    _isEditModalOpen = true;
    notifyListeners();
  }

  void closeEditModal() {
    _isEditModalOpen = false;
    notifyListeners();
  }

  void updateEditFullName(String val) {
    _editFullName = val;
    notifyListeners();
  }

  void updateEditEmail(String val) {
    _editEmail = val;
    notifyListeners();
  }

  void updateEditPhone(String val) {
    _editPhone = val;
    notifyListeners();
  }

  bool saveProfile() {
    if (_editFullName.trim().isEmpty || _editEmail.trim().isEmpty || _editPhone.trim().isEmpty) {
      return false;
    }

    _fullName = _editFullName.trim();
    _email = _editEmail.trim();
    _phone = _editPhone.trim();
    _isEditModalOpen = false;

    _repository.saveProfile(
      ProfileModel(
        fullName: _fullName,
        email: _email,
        phone: _phone,
        role: _role,
      ),
    );

    showToast('✅ Profile updated successfully!');
    notifyListeners();
    return true;
  }

  void showToast(String msg) {
    _toastMessage = msg;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      if (_toastMessage == msg) {
        _toastMessage = null;
        notifyListeners();
      }
    });
  }

  void clearToast() {
    _toastMessage = null;
    notifyListeners();
  }
}
