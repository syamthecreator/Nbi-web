/// Application configuration and environment constants.
class AppConfig {
  AppConfig._();

  static const String appTitle = 'NBI – Notice Board India';
  static const String apiBaseUrl = 'https://api.noticeboardindia.in/v1';
  static const Duration requestTimeout = Duration(seconds: 15);
}
