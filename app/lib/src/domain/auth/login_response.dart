import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  const LoginResponse({
    required this.token,
    required this.userId,
    required this.email,
    required this.name,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }

  final String token;
  final String userId;
  final String email;
  final String name;

  Map<String, dynamic> toJson() {
    return {'token': token, 'userId': userId, 'email': email, 'name': name};
  }

  @override
  List<Object?> get props => [token, userId, email, name];
}
