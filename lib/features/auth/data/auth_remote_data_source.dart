/// features/auth/data/auth_remote_data_source.dart
library;

import 'package:dio/dio.dart';

/// Handles all authentication API calls.
/// Aligned to actual backend endpoints:
///   POST /users              — create or get user by phone
///   POST /auth/login         — query param phone_number → {access_token, user_id}
class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  /// Creates or retrieves a user by phone number.
  /// Body: { phone_number: String }
  /// Returns user object containing `id`.
  Future<Map<String, dynamic>> createOrGetUser(String phone) async {
    final response = await dio.post(
      '/users',
      data: {'phone_number': phone},
    );
    return (response.data as Map).cast<String, dynamic>();
  }

  /// Authenticates user via phone number.
  /// Query param: phone_number
  /// Returns { access_token: String, user_id: String }
  Future<Map<String, dynamic>> login(String phone) async {
    final response = await dio.post(
      '/auth/login',
      queryParameters: {'phone_number': phone},
    );
    return (response.data as Map).cast<String, dynamic>();
  }
}