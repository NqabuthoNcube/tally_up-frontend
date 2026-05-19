/// features/auth/data/auth_repository.dart
library;

import '../../../core/storage/secure_storage_service.dart';
import 'auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource _remote;
  final SecureStorageService _storage;

  AuthRepository(this._remote, this._storage);

  /// Creates or retrieves a user — returns user id string.
  Future<String> createOrGetUser(String phone) async {
    final user = await _remote.createOrGetUser(phone);
    final userId = user['id']?.toString();
    if (userId == null || userId.isEmpty) {
      throw Exception('Invalid user response — missing id');
    }
    return userId;
  }

  /// Logs in via phone number.
  /// Stores JWT token and user_id in secure storage.
  /// Returns the JWT access token.
  Future<String> login(String phone) async {
    final data = await _remote.login(phone);
    final token = data['access_token']?.toString();
    if (token == null || token.isEmpty) {
      throw Exception('Invalid authentication response — missing access_token');
    }
    await _storage.saveToken(token);

    // Also persist user_id returned from login if available
    final userId = data['user_id']?.toString();
    if (userId != null && userId.isNotEmpty) {
      await _storage.saveUserId(userId);
    }

    return token;
  }

  Future<void> logout() async {
    await _storage.clearSession();
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.getToken();
    return token != null && token.isNotEmpty;
  }
}