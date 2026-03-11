/// core/services/otp_service.dart

import 'package:dio/dio.dart';
import 'package:tally_up/core/providers.dart';

import '../storage/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles OTP authentication with the backend.
///
/// The mobile app never generates OTP codes.
/// It only requests and verifies them via API.
class OtpService {
  final Dio dio;
  final SecureStorageService storage;

  OtpService(this.dio, this.storage);

  /// Request OTP from backend
  Future<void> requestOtp(String phoneNumber) async {
    await dio.post(
      "/auth/request-otp",
      queryParameters: {
        "phone_number": phoneNumber,
      },
    );
  }

  /// Verify OTP and store JWT token
  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final response = await dio.post(
      "/auth/verify-otp",
      data: {
        "phone_number": phoneNumber,
        "otp": otp,
      },
    );

    final token = response.data["access_token"] as String;

    await storage.saveToken(token);
  }
}

/// Riverpod provider
final otpServiceProvider = Provider<OtpService>((ref) {
  final dio = ref.read(dioProvider);
  final storage = ref.read(secureStorageProvider);

  return OtpService(dio, storage);
});