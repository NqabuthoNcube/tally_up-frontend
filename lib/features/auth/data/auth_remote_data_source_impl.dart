import '../../../core/config/app_config.dart';
import 'dart:async';

class AuthRemoteDataSource {
  Future<void> requestOtp(String phone) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(seconds: 1));
      return;
    }

    throw UnimplementedError("Real backend not implemented yet");
  }

  Future<String> verifyOtp(String phone, String otp) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(seconds: 1));

      if (otp == "123456") {
        return "mock_jwt_token";
      } else {
        throw Exception("Invalid OTP");
      }
    }

    throw UnimplementedError("Real backend not implemented yet");
  }
}