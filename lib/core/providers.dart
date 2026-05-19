/// core/providers/providers.dart
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tally_up/core/storage/secure_storage_service.dart';

import '../../core/network/api_client.dart';

/// Provides secure storage across the app.
final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

/// Provides the ApiClient instance.
final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.read(secureStorageProvider);
  return ApiClient(storage);
});

/// Convenience provider to access Dio directly.
final dioProvider = Provider((ref) {
  final client = ref.read(apiClientProvider);
  return client.dio;
});