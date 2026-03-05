import 'dart:async';

abstract class IAuthRemoteDataSource {
  Future<void> requestOtp(String phone);
  Future<String> verifyOtp(String phone, String otp);
}

class MockAuthRemoteDataSource implements IAuthRemoteDataSource {
  @override
  Future<void> requestOtp(String phone) async {
    // Always succeed in mock mode
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<String> verifyOtp(String phone, String otp) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (otp == "123456") {
      return "mock_jwt_token";
    }

    throw Exception("Invalid OTP");
  }
}