part of 'login_bloc.dart';

enum LoginUiState { initial, loading, loaded, error }

class LoginState extends Equatable {
  const LoginState({
    this.email = 'test@example.com',
    this.password = 'password123',
    this.obscurePassword = true,
    this.uiState = LoginUiState.initial,
    this.errorMessage = '',
    this.loginSuccess = false,
    this.userName = '',
  });

  final String email;
  final String password;
  final bool obscurePassword;
  final LoginUiState uiState;
  final String errorMessage;
  final bool loginSuccess;
  final String userName;

  LoginState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
    LoginUiState? uiState,
    String? errorMessage,
    bool? loginSuccess,
    String? userName,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      uiState: uiState ?? this.uiState,
      errorMessage: errorMessage ?? this.errorMessage,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    obscurePassword,
    uiState,
    errorMessage,
    loginSuccess,
    userName,
  ];
}
