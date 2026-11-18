import '../network/api_client.dart';

/// Base class for all remote and local data services.
abstract class BaseService {
  final ApiClient apiClient;

  BaseService({ApiClient? client}) : apiClient = client ?? StandardApiClient();
}
