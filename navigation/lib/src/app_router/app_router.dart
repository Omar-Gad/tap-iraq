import 'package:auto_route/auto_route.dart';
import 'package:auth/auth.dart';
import 'package:home/home.dart';
import 'package:cleaning/cleaning.dart';
import 'package:core_ui/core_ui.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(
  modules: [AuthModule, HomeModule, CleaningModule, CoreUIModule],
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page, initial: true),
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      children: [
        AutoRoute(page: CleaningRoute.page, path: 'cleaning', initial: true),
        AutoRoute(page: OrdersRoute.page, path: 'orders'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(page: SettingsRoute.page, path: 'settings'),
      ],
    ),
    AutoRoute(
      page: CleaningBookingRoute.page,
      path: '/booking/:serviceId',
    ),
  ];
}
