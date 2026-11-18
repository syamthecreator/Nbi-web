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
}
