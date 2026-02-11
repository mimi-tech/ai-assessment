// ignore_for_file: one_member_abstracts

import 'package:ai_assessment/src/domain/auth/login_response.dart';

abstract class AuthService {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });
}

class IAuthService implements AuthService {
  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(seconds: 1));

    // Demo JSON response
    const demoEmail = 'test@example.com';
    const demoPassword = 'password123';

    if (email == demoEmail && password == demoPassword) {
      final demoJson = <String, dynamic>{
        'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.demo_token',
        'userId': 'usr_001',
        'email': demoEmail,
        'name': 'John Doe',
      };

      return LoginResponse.fromJson(demoJson);
    }

    throw Exception('Invalid email or password');
  }
}
