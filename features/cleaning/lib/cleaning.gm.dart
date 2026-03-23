// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:cleaning/src/ui/cleaning_screen.dart' as _i1;

abstract class $CleaningModule extends _i2.AutoRouterModule {
  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    CleaningRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CleaningScreen(),
      );
    }
  };
}

/// generated route for
/// [_i1.CleaningScreen]
class CleaningRoute extends _i2.PageRouteInfo<void> {
  const CleaningRoute({List<_i2.PageRouteInfo>? children})
      : super(
          CleaningRoute.name,
          initialChildren: children,
        );

  static const String name = 'CleaningRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
