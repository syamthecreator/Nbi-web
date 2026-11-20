/// Splash state model encapsulating startup metrics and routing intention.
class SplashModel {
  final bool isInitialized;
  final Duration displayDuration;
  final String destinationRoute;

  const SplashModel({
    this.isInitialized = false,
    this.displayDuration = const Duration(seconds: 3),
    this.destinationRoute = '/select-role',
  });

  SplashModel copyWith({
    bool? isInitialized,
    Duration? displayDuration,
    String? destinationRoute,
  }) {
    return SplashModel(
      isInitialized: isInitialized ?? this.isInitialized,
      displayDuration: displayDuration ?? this.displayDuration,
      destinationRoute: destinationRoute ?? this.destinationRoute,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isInitialized': isInitialized,
      'displayDurationMs': displayDuration.inMilliseconds,
      'destinationRoute': destinationRoute,
    };
  }

  factory SplashModel.fromJson(Map<String, dynamic> json) {
    return SplashModel(
      isInitialized: json['isInitialized'] as bool? ?? false,
      displayDuration: Duration(
        milliseconds: json['displayDurationMs'] as int? ?? 3000,
      ),
      destinationRoute: json['destinationRoute'] as String? ?? '/select-role',
    );
  }
}
