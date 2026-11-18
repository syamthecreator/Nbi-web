import 'dart:async';
import '../exceptions/app_exception.dart';

/// Abstract API client contract for network operations.
abstract class ApiClient {
  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<dynamic> delete(String endpoint, {Map<String, String>? headers});
}

/// Standard Mock/Default implementation of [ApiClient] for frontend-first production architecture.
class StandardApiClient implements ApiClient {
  final String baseUrl;
  final Duration timeout;

  StandardApiClient({
    this.baseUrl = '',
    this.timeout = const Duration(seconds: 30),
  });

  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    return {...defaultHeaders, ...?headers};
  }

  @override
  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) async {
    try {
      final mergedHeaders = _mergeHeaders(headers);
      assert(mergedHeaders.isNotEmpty);
      // Prepared for backend integration
      return <String, dynamic>{'status': 'success', 'data': []};
    } catch (e) {
      throw NetworkException('Failed to execute GET request: $e');
    }
  }

  @override
  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    try {
      final mergedHeaders = _mergeHeaders(headers);
      assert(mergedHeaders.isNotEmpty);
      return <String, dynamic>{'status': 'success', 'data': body};
    } catch (e) {
      throw NetworkException('Failed to execute POST request: $e');
    }
  }

  @override
  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    try {
      final mergedHeaders = _mergeHeaders(headers);
      assert(mergedHeaders.isNotEmpty);
      return <String, dynamic>{'status': 'success', 'data': body};
    } catch (e) {
      throw NetworkException('Failed to execute PUT request: $e');
    }
  }

  @override
  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final mergedHeaders = _mergeHeaders(headers);
      assert(mergedHeaders.isNotEmpty);
      return <String, dynamic>{'status': 'success'};
    } catch (e) {
      throw NetworkException('Failed to execute DELETE request: $e');
    }
  }
}
