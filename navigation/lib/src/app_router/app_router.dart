import 'package:auto_route/auto_route.dart';
import 'package:auth/auth.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(
  modules: [AuthModule],
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: true),
      ];
}
