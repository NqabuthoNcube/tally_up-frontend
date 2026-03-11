/// lib/features/domain/auth_notifier.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/domain/auth_state.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> requestOtp(String phone) async {
    state = state.copyWith(status: AuthStatus.codeSent, phone: phone);
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = state.copyWith(status: AuthStatus.authenticated, phone: phone);
  }

  Future<void> logout() async {
    state = const AuthState();
  }
}