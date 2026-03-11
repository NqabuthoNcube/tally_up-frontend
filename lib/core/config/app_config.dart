/// core/config/app_config.dart
///
/// Global configuration for the Flutter application.
/// Handles environment variables and runtime configuration.

class AppConfig {
  /// Toggle mock services (should be FALSE in production)
  static const bool useMock = bool.fromEnvironment(
    'USE_MOCK',
    defaultValue: false,
  );

  /// Backend base URL
  ///
  /// Android emulator must use 10.0.2.2 instead of localhost.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

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