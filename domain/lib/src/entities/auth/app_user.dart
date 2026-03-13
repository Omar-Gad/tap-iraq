import 'package:core/core.dart';

class AppUser extends Equatable {
  final int id;
  final String name;
  final String login;

  const AppUser({
    required this.id,
    required this.name,
    required this.login,
  });

  AppUser copyWith({
    int? id,
    String? name,
    String? login,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      login: login ?? this.login,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'login': login,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as int,
      name: map['name'] as String,
      login: map['login'] as String,
    );
  }

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, login: $login)';
  }

  @override
  List<Object?> get props => [id, name, login];
}
