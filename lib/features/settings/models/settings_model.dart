/// Strongly-typed User Preferences & Notifications Settings model.
class SettingsModel {
  final bool pushNotifications;
  final bool smsWeatherAlerts;
  final bool dailyDigestEmail;

  const SettingsModel({
    this.pushNotifications = true,
    this.smsWeatherAlerts = true,
    this.dailyDigestEmail = true,
  });

  SettingsModel copyWith({
    bool? pushNotifications,
    bool? smsWeatherAlerts,
    bool? dailyDigestEmail,
  }) {
    return SettingsModel(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      smsWeatherAlerts: smsWeatherAlerts ?? this.smsWeatherAlerts,
      dailyDigestEmail: dailyDigestEmail ?? this.dailyDigestEmail,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNotifications': pushNotifications,
      'smsWeatherAlerts': smsWeatherAlerts,
      'dailyDigestEmail': dailyDigestEmail,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      pushNotifications: json['pushNotifications'] as bool? ?? true,
      smsWeatherAlerts: json['smsWeatherAlerts'] as bool? ?? true,
      dailyDigestEmail: json['dailyDigestEmail'] as bool? ?? true,
    );
  }
}
