/// features/auth/data/auth_remote_data_source.dart

import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<void> requestOtp(String phone) async {
    await dio.post(
      "/auth/request-otp",
      queryParameters: {
        "phone_number": phone,
      },
    );
  }

  Future<String> verifyOtp(String phone, String otp) async {
    final response = await dio.post(
      "/auth/verify-otp",
      data: {
        "phone_number": phone,
        "otp": otp,
      },
    );

    final token = response.data["access_token"];

    if (token == null || token is! String) {
      throw Exception("Invalid authentication response");
    }

    return token;
  }
}