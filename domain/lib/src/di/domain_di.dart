import 'package:core/core.dart';
import 'package:domain/domain.dart';

abstract class DomainDi {
  static Future<void> init(GetIt locator) async {
    locator
      ..registerFactory<LoginUseCase>(() => LoginUseCase(locator()))
      ..registerFactory<RegisterUseCase>(() => RegisterUseCase(locator()))
      ..registerFactory<SignOutUseCase>(() => SignOutUseCase(locator()))
      ..registerFactory<CheckSessionUseCase>(
          () => CheckSessionUseCase(locator()));
  }
}
