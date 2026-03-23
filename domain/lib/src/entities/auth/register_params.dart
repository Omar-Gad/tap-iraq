import 'package:core/core.dart';

class RegisterParams extends Equatable {
  final String name;
  final String login;
  final String password;

  const RegisterParams({
    required this.name,
    required this.login,
    required this.password,
  });

  RegisterParams copyWith({
    String? name,
    String? login,
    String? password,
  }) {
    return RegisterParams(
      name: name ?? this.name,
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'login': login,
      'password': password,
    };
  }

  factory RegisterParams.fromMap(Map<String, dynamic> map) {
    return RegisterParams(
      name: map['name'] as String,
      login: map['login'] as String,
      password: map['password'] as String,
    );
  }

  @override
  String toString() {
    return 'RegisterParams(name: $name, login: $login, password: [PROTECTED])';
  }

  @override
  List<Object?> get props => [name, login, password];
}
