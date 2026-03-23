import 'package:data/data.dart';
import 'package:domain/domain.dart';

class AuthMapper {
  static AppUser toEntity(UserModel model) {
    return AppUser(
      id: model.uid,
      name: model.name,
      login: model.username,
    );
  }

  static UserModel toModel(AppUser user) {
    return UserModel(
      uid: user.id,
      name: user.name,
      username: user.login,
      companyId: 1,
      sessionId: '',
    );
  }
}
