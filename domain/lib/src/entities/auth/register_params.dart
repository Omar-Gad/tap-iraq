import 'package:core/core.dart';

class RegisterParams extends Equatable {
  final String name;
  final String login;
  final String password;
  final String phone;

  const RegisterParams({
    required this.name,
    required this.login,
    required this.password,
    required this.phone,
  });

  RegisterParams copyWith({
    String? name,
    String? login,
    String? password,
    String? phone,
  }) {
    return RegisterParams(
      name: name ?? this.name,
      login: login ?? this.login,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'login': login,
      'password': password,
      'phone': phone,
    };
  }

  factory RegisterParams.fromMap(Map<String, dynamic> map) {
    return RegisterParams(
      name: map['name'] as String,
      login: map['login'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
    );
  }

  @override
  String toString() {
    return 'RegisterParams(name: $name, login: $login, phone: $phone, password: [PROTECTED])';
  }

  @override
  List<Object?> get props => [name, login, password, phone];
}

