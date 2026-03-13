import 'package:core/core.dart';
import '../app_router/app_router.dart';

abstract class NavigationDI {
  static void init(GetIt locator) {
    locator.registerLazySingleton<AppRouter>(() => AppRouter());
  }
}
