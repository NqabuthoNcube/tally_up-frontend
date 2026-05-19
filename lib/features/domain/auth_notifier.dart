/// lib/features/domain/auth_notifier.dart
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/domain/auth_state.dart';
import '../auth/data/auth_providers.dart';
import '../../core/providers.dart';

export '../auth/domain/auth_state.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repo = ref.read(authRepositoryProvider);
  final storage = ref.read(secureStorageProvider);
  return AuthNotifier(repo, storage);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final dynamic _repo;
  final dynamic _storage;

  AuthNotifier(this._repo, this._storage) : super(const AuthState());

  /// Called at app startup — restores session if token exists.
  Future<void> bootstrap() async {
    final token = await _storage.getToken();
    if (token != null && token.isNotEmpty) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
      );
    }
  }

  /// Full login flow:
  ///   1. POST /users       — create or get user, get user_id
  ///   2. POST /auth/login  — get access_token, store it
  Future<void> loginWithPhone(String phone) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      phone: phone,
      errorMessage: null,
    );
    try {
      // Step 1: ensure user exists and get user_id
      final userId = await _repo.createOrGetUser(phone);
      await _storage.saveUserId(userId);

      // Step 2: authenticate and receive JWT
      await _repo.login(phone);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        phone: phone,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _friendlyError(e),
      );
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AuthState();
  }

  String _friendlyError(Object e) {
    final msg = e.toString();
    if (msg.contains('404')) return 'Phone number not registered.';
    if (msg.contains('SocketException') || msg.contains('connection')) {
      return 'Cannot reach server. Check your connection.';
    }
    if (msg.contains('401') || msg.contains('403')) {
      return 'Authentication failed. Try again.';
    }
    return 'Something went wrong. Please try again.';
  }
}
