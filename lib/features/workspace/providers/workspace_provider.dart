import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/workspace_model.dart';
import '../repositories/workspace_repository.dart';

enum WorkspaceStep {
  institutionDetails, // Step 1
  adminDetails, // Step 2
  success, // Step 3
}

class WorkspaceProvider extends ChangeNotifier {
  final WorkspaceRepository _repository;

  // Step 1 Fields
  String _institutionName = '';
  String _workspaceName = '';
  String _institutionType = '';
  String _institutionCode = '';
  String? _schoolLogoAsset;
  Uint8List? _schoolLogoBytes;
  String? _schoolLogoFileName;
  bool _userEditedWorkspaceName = false;

  String get institutionName => _institutionName;
  String get workspaceName => _workspaceName;
  String get institutionType => _institutionType;
  String get institutionCode => _institutionCode;
  String? get schoolLogoAsset => _schoolLogoAsset;
  Uint8List? get schoolLogoBytes => _schoolLogoBytes;
  String? get schoolLogoFileName => _schoolLogoFileName;

  // Step 2 Fields
  String _adminFullName = 'Rahul Sharma';
  String _adminDesignation = '';
  String _adminEmail = 'email@gmail.com';
  String _adminMobile = '8787878888';

  String get adminFullName => _adminFullName;
  String get adminDesignation => _adminDesignation;
  String get adminEmail => _adminEmail;
  String get adminMobile => _adminMobile;

  // Institution Type Dropdown Options
  final List<String> institutionTypes = const [
    'Higher Secondary School',
    'High School & Primary',
    'Degree College / University',
    'Coaching & Entrance Academy',
    'International School',
  ];

  // Admin Designation Dropdown Options
  final List<String> designations = const [
    'Principal / Headmaster',
    'Director / Chairperson',
    'Dean / Administrator',
    'Vice Principal',
    'IT Admin / Technical Officer',
    'Trustee / Correspondent',
  ];

  // Feedback, Errors & Redirect
  String? _toastMessage;
  String? get toastMessage => _toastMessage;

  int _redirectCountdown = 5;
  int get redirectCountdown => _redirectCountdown;
  Timer? _redirectTimer;

  WorkspaceModel? _createdWorkspace;
  WorkspaceModel? get createdWorkspace => _createdWorkspace;

  WorkspaceStep _currentStep = WorkspaceStep.institutionDetails;
  WorkspaceStep get currentStep => _currentStep;

  // Text Controllers for rock-solid Provider-driven input
  late final TextEditingController institutionNameController;
  late final TextEditingController workspaceNameController;
  late final TextEditingController institutionCodeController;
  late final TextEditingController adminFullNameController;
  late final TextEditingController adminEmailController;
  late final TextEditingController adminMobileController;

  WorkspaceProvider({WorkspaceRepository? repository})
    : _repository = repository ?? WorkspaceRepositoryImpl() {
    _initDefaults();
  }

  void _initDefaults() {
    _institutionCode =
        'NBI-SCH-${1000 + (DateTime.now().millisecondsSinceEpoch % 8999)}';
    institutionNameController = TextEditingController(text: _institutionName);
    workspaceNameController = TextEditingController(text: _workspaceName);
    institutionCodeController = TextEditingController(text: _institutionCode);
    adminFullNameController = TextEditingController(text: _adminFullName);
    adminEmailController = TextEditingController(text: _adminEmail);
    adminMobileController = TextEditingController(text: _adminMobile);
  }

  void updateInstitutionName(String val) {
    _institutionName = val;
    if (!_userEditedWorkspaceName) {
      final slug = val
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]'), '-')
          .replaceAll(RegExp(r'-+'), '-')
          .replaceAll(RegExp(r'^-|-$'), '');
      _workspaceName = slug.isNotEmpty ? '$slug-workspace' : '';
      workspaceNameController.text = _workspaceName;
    }
    notifyListeners();
  }

  void updateWorkspaceName(String val) {
    _workspaceName = val;
    _userEditedWorkspaceName = true;
    notifyListeners();
  }

  void selectInstitutionType(String type) {
    _institutionType = type;
    notifyListeners();
  }

  void updateInstitutionCode(String code) {
    _institutionCode = code;
    notifyListeners();
  }

  Future<void> pickSchoolLogo() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'svg', 'webp'],
      );

      if (file != null) {
        final bytes = await file.readAsBytes();
        _schoolLogoBytes = bytes;
        _schoolLogoFileName = file.name;
        _schoolLogoAsset = null;
        notifyListeners();
      }
    } catch (e) {
      _showToast('⚠️ Could not open gallery / file picker');
    }
  }

  void selectSchoolLogo(String? assetPath) {
    _schoolLogoAsset = assetPath;
    _schoolLogoBytes = null;
    _schoolLogoFileName = null;
    notifyListeners();
  }

  void removeSchoolLogo() {
    _schoolLogoBytes = null;
    _schoolLogoFileName = null;
    _schoolLogoAsset = null;
    notifyListeners();
  }

  void updateAdminFullName(String val) {
    _adminFullName = val;
    notifyListeners();
  }

  void selectAdminDesignation(String val) {
    _adminDesignation = val;
    notifyListeners();
  }

  void selectDesignation(String val) => selectAdminDesignation(val);

  void updateAdminEmail(String val) {
    _adminEmail = val;
    notifyListeners();
  }

  void updateAdminMobile(String val) {
    _adminMobile = val;
    notifyListeners();
  }

  bool goToStep2() {
    if (_institutionName.trim().isEmpty ||
        _institutionType.isEmpty ||
        _workspaceName.trim().isEmpty ||
        _institutionCode.trim().isEmpty) {
      _showToast('⚠️ Please fill in all required fields marked with *');
      return false;
    }
    _currentStep = WorkspaceStep.adminDetails;
    notifyListeners();
    return true;
  }

  void backToStep1() {
    _currentStep = WorkspaceStep.institutionDetails;
    notifyListeners();
  }

  void goToStep1() => backToStep1();

  Future<bool> submitWorkspace() async {
    if (_adminFullName.trim().isEmpty ||
        _adminEmail.trim().isEmpty ||
        _adminDesignation.isEmpty ||
        _adminMobile.trim().isEmpty) {
      _showToast('⚠️ Please fill in all required Admin details marked with *');
      return false;
    }

    final newWs = WorkspaceModel(
      institutionName: _institutionName.trim(),
      workspaceName: _workspaceName.trim(),
      institutionType: _institutionType,
      institutionCode: _institutionCode.trim(),
      schoolLogoUrl: _schoolLogoAsset,
      schoolLogoBytes: _schoolLogoBytes,
      adminFullName: _adminFullName.trim(),
      adminDesignation: _adminDesignation,
      adminEmail: _adminEmail.trim(),
      adminMobile: _adminMobile.trim(),
      createdDate: DateTime.now().toIso8601String(),
    );

    try {
      _createdWorkspace = await _repository.createWorkspace(newWs);
      _currentStep = WorkspaceStep.success;
      _startRedirectCountdown();
      notifyListeners();
      return true;
    } catch (e) {
      _showToast('Failed to create workspace. Please try again.');
      return false;
    }
  }

  void _startRedirectCountdown() {
    _redirectCountdown = 5;
    _redirectTimer?.cancel();
    _redirectTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_redirectCountdown > 1) {
        _redirectCountdown--;
        notifyListeners();
      } else {
        _redirectCountdown = 0;
        _redirectTimer?.cancel();
        notifyListeners();
      }
    });
  }

  void cancelRedirectTimer() {
    _redirectTimer?.cancel();
    _redirectTimer = null;
  }

  void _showToast(String msg) {
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

  @override
  void dispose() {
    _redirectTimer?.cancel();
    institutionNameController.dispose();
    workspaceNameController.dispose();
    institutionCodeController.dispose();
    adminFullNameController.dispose();
    adminEmailController.dispose();
    adminMobileController.dispose();
    super.dispose();
  }
}
