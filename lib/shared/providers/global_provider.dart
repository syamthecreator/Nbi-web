import 'package:flutter/material.dart';
import '../enums/view_state.dart';
import '../models/user_role.dart';

/// Global application provider managing session state, connectivity, and role context.
class GlobalProvider extends ChangeNotifier {
  ViewState _state = ViewState.initial;
  UserRole _activeRole = UserRole.institution;
  bool _isOnline = true;
  String? _errorMessage;

  ViewState get state => _state;
  UserRole get activeRole => _activeRole;
  bool get isOnline => _isOnline;
  String? get errorMessage => _errorMessage;

  void setRole(UserRole role) {
    if (_activeRole != role) {
      _activeRole = role;
      notifyListeners();
    }
  }

  void setConnectivity(bool online) {
    if (_isOnline != online) {
      _isOnline = online;
      notifyListeners();
    }
  }

  void setViewState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  void setError(String? error) {
    _errorMessage = error;
    _state = error != null ? ViewState.error : ViewState.loaded;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_state == ViewState.error) {
      _state = ViewState.loaded;
    }
    notifyListeners();
  }
}
