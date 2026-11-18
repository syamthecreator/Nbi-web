import '../models/settings_model.dart';
import '../services/settings_service.dart';

abstract class SettingsRepository {
  Future<SettingsModel> getSettings();
  Future<bool> updateSettings(SettingsModel settings);
}

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsService service;

  SettingsRepositoryImpl({SettingsService? service})
      : service = service ?? SettingsServiceImpl();

  @override
  Future<SettingsModel> getSettings() {
    return service.getSettings();
  }

  @override
  Future<bool> updateSettings(SettingsModel settings) {
    return service.saveSettings(settings);
  }
}
