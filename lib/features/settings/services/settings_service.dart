import '../../../core/services/base_service.dart';
import '../models/settings_model.dart';

abstract class SettingsService extends BaseService {
  SettingsService({super.client});

  Future<SettingsModel> getSettings();
  Future<bool> saveSettings(SettingsModel settings);
}

class SettingsServiceImpl extends SettingsService {
  SettingsServiceImpl({super.client});

  @override
  Future<SettingsModel> getSettings() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return const SettingsModel();
  }

  @override
  Future<bool> saveSettings(SettingsModel settings) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
