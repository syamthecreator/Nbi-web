import '../../../core/services/base_service.dart';

abstract class SplashService extends BaseService {
  SplashService({super.client});

  Future<void> prefetchInitialData();
}

class SplashServiceImpl extends SplashService {
  SplashServiceImpl({super.client});

  @override
  Future<void> prefetchInitialData() async {
    // Initial warmup / pre-fetch logic
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
