/// core/network/api_client.dart
library;

import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../storage/secure_storage_service.dart';

/// Central HTTP client used across the application.
///
/// Responsibilities:
/// - Configure Dio
/// - Attach JWT token automatically
/// - Apply base URL and timeouts
/// - Provide a reusable HTTP client
class ApiClient {
  final Dio dio;
  final SecureStorageService storage;

  ApiClient(this.storage)
      : dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
            connectTimeout:
                const Duration(seconds: AppConfig.connectionTimeoutSeconds),
            receiveTimeout:
                const Duration(seconds: AppConfig.receiveTimeoutSeconds),
            headers: {
              "Content-Type": "application/json",
            },
          ),
        ) {
    _initializeInterceptors();
  }

  /// Attach interceptors
  void _initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await storage.getToken();

            if (token != null && token.isNotEmpty) {
              options.headers["Authorization"] = "Bearer $token";
            }

            handler.next(options);
          } catch (e) {
            handler.next(options);
          }
        },
      ),
    );
  }
}