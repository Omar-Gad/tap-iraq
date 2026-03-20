import 'package:data/data.dart';
import 'package:data/src/providers/local/local_data_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:data/src/providers/mock/app_database.dart';
import 'package:data/src/providers/mock/mock_provider.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';

abstract class DataDI {
  static Future<void> init(GetIt locator) async {
    await _initProviders(locator);
    _initRepositories(locator);
  }

  static Future<void> _initProviders(GetIt locator) async {
    locator
      ..registerLazySingleton<AppDatabase>(() => AppDatabase())
      ..registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage(),
      )
      ..registerLazySingleton<LocalDataProvider>(
        () => SecuredStorageProvider(storage: locator()),
      )
      ..registerLazySingleton<ApiProvider>(
        () => FakeApiProvider(locator<AppDatabase>()),
      );
  }

  static void _initRepositories(GetIt locator) {
    locator
      ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
          apiProvider: locator(),
          localDataProvider: locator(),
        ),
      )
      ..registerLazySingleton<AddressRepository>(
        () => AddressRepositoryImpl(locator()),
      );
  }
}
