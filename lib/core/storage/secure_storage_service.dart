/// core/storage/secure_storage_service.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const _tokenKey = "jwt_token";
  static const _accountKey = "account_id";

  /// Save JWT token
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Retrieve JWT token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Save account ID
  Future<void> saveAccountId(String accountId) async {
    await _storage.write(key: _accountKey, value: accountId);
  }

  /// Get account ID
  Future<String?> getAccountId() async {
    return await _storage.read(key: _accountKey);
  }

  /// Clear authentication session
  Future<void> clearSession() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _accountKey);
  }
}