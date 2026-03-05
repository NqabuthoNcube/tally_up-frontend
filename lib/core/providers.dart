import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'network/api_client.dart';
import 'storage/secure_storage_service.dart';

final storageProvider = Provider((ref) {
  return SecureStorageService();
});

final apiClientProvider = Provider((ref) {
  final storage = ref.read(storageProvider);
  return ApiClient(storage);
});