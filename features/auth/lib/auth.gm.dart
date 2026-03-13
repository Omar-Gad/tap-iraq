// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth/src/ui/auth_screen.dart' as _i1;
import 'package:auto_route/auto_route.dart' as _i2;

abstract class $AuthModule extends _i2.AutoRouterModule {
  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    }
  };
}

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i2.PageRouteInfo<void> {
  const AuthRoute({List<_i2.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
