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
  final String? token;
  final String? accountId;
  final String? phone;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.token,
    this.accountId,
    this.phone,
    this.errorMessage,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    String? accountId,
    String? phone,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      accountId: accountId ?? this.accountId,
      phone: phone ?? this.phone,
      errorMessage: errorMessage,
    );
  }
}