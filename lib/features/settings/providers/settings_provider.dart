import 'package:flutter/material.dart';
import '../models/settings_model.dart';
import '../repositories/settings_repository.dart';

/// Pure Stateless architecture with Provider. Zero setState().
class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _repository;

  String _activeTab = 'all'; // 'all', 'notifications', 'security'
  String get activeTab => _activeTab;

  SettingsModel _settings = const SettingsModel();
  SettingsModel get settings => _settings;

  String? _toastMessage;
  String? get toastMessage => _toastMessage;

  SettingsProvider({SettingsRepository? repository})
      : _repository = repository ?? SettingsRepositoryImpl();

  void setActiveTab(String tab) {
    if (_activeTab != tab) {
      _activeTab = tab;
      notifyListeners();
    }
  }

  void togglePushNotifications(bool val) {
    _settings = _settings.copyWith(pushNotifications: val);
    notifyListeners();
  }

  void toggleSmsWeatherAlerts(bool val) {
    _settings = _settings.copyWith(smsWeatherAlerts: val);
    notifyListeners();
  }

  void toggleDailyDigestEmail(bool val) {
    _settings = _settings.copyWith(dailyDigestEmail: val);
    notifyListeners();
  }

  void saveSettings() {
    _repository.updateSettings(_settings);
    showToast('✅ Settings saved successfully!');
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
