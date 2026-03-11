/// features/auth/data/auth_repository.dart

import '../../../core/storage/secure_storage_service.dart';
import 'auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource _remote;
  final SecureStorageService _storage;

  AuthRepository(this._remote, this._storage);

  Future<void> requestOtp(String phone) async {
    await _remote.requestOtp(phone);
  }

  Future<void> verifyOtp(String phone, String otp) async {
    final token = await _remote.verifyOtp(phone, otp);

    await _storage.saveToken(token);
  }

  Future<void> logout() async {
    await _storage.clearSession();
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.getToken();

    return token != null && token.isNotEmpty;
  }
}