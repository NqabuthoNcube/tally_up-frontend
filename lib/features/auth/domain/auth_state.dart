/// features/auth/domain/auth_state.dart

enum AuthStatus {
  initial,
  loading,
  codeSent,
  authenticated,
  error,
}

class AuthState {
  final AuthStatus status;
  final String? phone;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.phone,
    this.errorMessage,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    String? phone,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      errorMessage: errorMessage,
    );
  }
}