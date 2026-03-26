// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:cleaning/src/ui/cleaning_booking_screen.dart' as _i1;
import 'package:cleaning/src/ui/cleaning_screen.dart' as _i2;
import 'package:flutter/material.dart' as _i4;

abstract class $CleaningModule extends _i3.AutoRouterModule {
  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    CleaningBookingRoute.name: (routeData) {
      final args = routeData.argsAs<CleaningBookingRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CleaningBookingScreen(
          key: args.key,
          serviceId: args.serviceId,
        ),
      );
    },
    CleaningRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CleaningScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CleaningBookingScreen]
class CleaningBookingRoute extends _i3.PageRouteInfo<CleaningBookingRouteArgs> {
  CleaningBookingRoute({
    _i4.Key? key,
    required int serviceId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          CleaningBookingRoute.name,
          args: CleaningBookingRouteArgs(
            key: key,
            serviceId: serviceId,
          ),
          initialChildren: children,
        );

  static const String name = 'CleaningBookingRoute';

  static const _i3.PageInfo<CleaningBookingRouteArgs> page =
      _i3.PageInfo<CleaningBookingRouteArgs>(name);
}

class CleaningBookingRouteArgs {
  const CleaningBookingRouteArgs({
    this.key,
    required this.serviceId,
  });

  final _i4.Key? key;

  final int serviceId;

  @override
  String toString() {
    return 'CleaningBookingRouteArgs{key: $key, serviceId: $serviceId}';
  }
}

/// generated route for
/// [_i2.CleaningScreen]
class CleaningRoute extends _i3.PageRouteInfo<void> {
  const CleaningRoute({List<_i3.PageRouteInfo>? children})
      : super(
          CleaningRoute.name,
          initialChildren: children,
        );

  static const String name = 'CleaningRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
