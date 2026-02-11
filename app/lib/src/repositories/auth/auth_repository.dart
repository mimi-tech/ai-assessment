import 'package:ai_assessment/src/domain/auth/login_response.dart';
import 'package:ai_assessment/src/services/auth/auth_service.dart';

abstract class AuthRepository {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });
}

class IAuthRepository implements AuthRepository {
  IAuthRepository({required AuthService authService})
    : _authService = authService;

  final AuthService _authService;

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) => _authService.login(email: email, password: password);
}
