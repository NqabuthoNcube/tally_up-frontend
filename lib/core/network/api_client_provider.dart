import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/secure_storage_service.dart';
import 'api_client.dart';

/// Provides a single ApiClient instance across the app.
/// Injects secure storage so JWT is attached automatically.
final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.read(secureStorageProvider);

  return ApiClient(storage);
});