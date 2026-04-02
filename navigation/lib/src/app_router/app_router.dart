import 'package:auto_route/auto_route.dart';
import 'package:auth/auth.dart';
import 'package:home/home.dart';
import 'package:cleaning/cleaning.dart';
import 'package:core_ui/core_ui.dart';
import 'package:addresses/addresses.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(
  modules: [
    AuthModule,
    HomeModule,
    CleaningModule,
    CoreUIModule,
    AddressesModule,
  ],
  replaceInRouteName: 'Screen|Body,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.custom(transitionsBuilder: TransitionsBuilders.fadeIn);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AuthRoute.page,
      initial: true,
      children: [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: UserRegisterRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
      ],
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      children: [
        AutoRoute(page: AddressesRoute.page, path: 'addresses'),
        AutoRoute(page: CleaningRoute.page, path: 'cleaning', initial: true),
        AutoRoute(page: OrdersRoute.page, path: 'orders'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(page: SettingsRoute.page, path: 'settings'),
      ],
    ),

    CustomRoute(
      page: AddAddressRoute.page,
      path: '/add-address',
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: CleaningBookingRoute.page,
      path: '/booking/:serviceId',
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ];
}
