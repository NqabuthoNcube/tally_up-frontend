import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tally_up/core/network/api_client.dart';
import 'package:tally_up/core/storage/secure_storage_service.dart';

final storageProvider = Provider((ref) => SecureStorageService());

final apiClientProvider = Provider((ref) {
  final storage = ref.read(storageProvider);
  return ApiClient(storage).dio;
});