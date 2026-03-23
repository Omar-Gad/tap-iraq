import 'package:core/core.dart';

class LoginParams extends Equatable {
  final String login;
  final String password;

  const LoginParams({
    required this.login,
    required this.password,
  });

  LoginParams copyWith({
    String? login,
    String? password,
  }) {
    return LoginParams(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'password': password,
    };
  }

  factory LoginParams.fromMap(Map<String, dynamic> map) {
    return LoginParams(
      login: map['login'] as String,
      password: map['password'] as String,
    );
  }

  @override
  String toString() {
    return 'LoginParams(login: $login, password: [PROTECTED])';
  }

  @override
  List<Object?> get props => [login, password];
}
