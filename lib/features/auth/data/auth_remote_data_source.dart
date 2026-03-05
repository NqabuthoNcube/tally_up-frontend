import 'dart:async';

/// Offline-friendly auth data source used until backend integration is added.
class AuthRemoteDataSource {
  Future<void> requestOtp(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
  }

  Future<String> verifyOtp(String phone, String otp) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    if (otp == '123456') {
      return 'local_jwt_token';
    }

    throw Exception('Invalid OTP');
  }
}
