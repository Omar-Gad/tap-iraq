import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/src/mappers/login_mapper.dart';
import 'package:data/src/mappers/register_mapper.dart';
import 'package:data/src/mappers/user_mapper.dart';
import 'package:data/src/providers/local/local_data_provider.dart';
import 'package:domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiProvider _apiProvider;
  final LocalDataProvider _localDataProvider;

  AuthRepositoryImpl({
    required ApiProvider apiProvider,
    required LocalDataProvider localDataProvider,
  })  : _apiProvider = apiProvider,
        _localDataProvider = localDataProvider;

  @override
  Future<AppUser> login(LoginParams params) async {
    final model = await _apiProvider.login(LoginMapper.toRequest(params));

    await _localDataProvider.write(
      key: StorageConstants.tokenKey,
      value: model.sessionId,
    );
    await _localDataProvider.write(
      key: StorageConstants.userIdKey,
      value: model.uid.toString(),
    );

    return AuthMapper.toEntity(model);
  }

  @override
  Future<AppUser> register(RegisterParams params) async {
    final model = await _apiProvider.register(RegisterMapper.toRequest(params));

    await _localDataProvider.write(
      key: StorageConstants.tokenKey,
      value: model.sessionId,
    );
    await _localDataProvider.write(
      key: StorageConstants.userIdKey,
      value: model.uid.toString(),
    );

    return AuthMapper.toEntity(model);
  }

  @override
  Future<bool> checkSession() async {
    final hasStoredSession = await _localDataProvider.contains(
      StorageConstants.tokenKey,
    );

    if (!hasStoredSession) return false;

    return _apiProvider.checkSession();
  }

  @override
  Future<void> logout() async {
    await _apiProvider.logout();
    await _localDataProvider.delete(StorageConstants.tokenKey);
    await _localDataProvider.delete(StorageConstants.userIdKey);
  }
}
