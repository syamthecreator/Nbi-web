import '../models/splash_model.dart';
import '../services/splash_service.dart';

abstract class SplashRepository {
  Future<SplashModel> initializeApp();
}

class SplashRepositoryImpl implements SplashRepository {
  final SplashService splashService;

  SplashRepositoryImpl({SplashService? service})
      : splashService = service ?? SplashServiceImpl();

  @override
  Future<SplashModel> initializeApp() async {
    await splashService.prefetchInitialData();
    return const SplashModel(isInitialized: true);
  }
}
