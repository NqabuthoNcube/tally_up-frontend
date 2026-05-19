/// core/config/app_config.dart
///
/// Global configuration for the Flutter application.
/// Handles environment variables and runtime configuration.
library;

import 'package:flutter/foundation.dart';

class AppConfig {
  /// Toggle mock services (should be FALSE in production)
  static const bool useMock = bool.fromEnvironment(
    'USE_MOCK',
    defaultValue: false,
  );

  /// Backend base URL
  ///
  /// Defaults to localhost for Flutter web and 10.0.2.2 for Android emulator.
  /// Override with --dart-define=BASE_URL=... for production or physical devices.
  static const String _configuredBaseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: '',
  );

  static String get baseUrl {
    if (_configuredBaseUrl.isNotEmpty) {
      return _configuredBaseUrl;
    }
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    }
    return 'http://10.0.2.2:8000';
  }

  /// HTTP connection timeout
  static const int connectionTimeoutSeconds = 10;

  /// HTTP receive timeout
  static const int receiveTimeoutSeconds = 10;

  /// Pagination defaults
  static const int defaultPageSize = 20;

  /// Debug flag
  static const bool debug = bool.fromEnvironment(
    'DEBUG',
    defaultValue: true,
  );
}
