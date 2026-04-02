// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:addresses/src/ui/add_address_body.dart' as _i1;
import 'package:addresses/src/ui/addresses_list_body.dart' as _i2;
import 'package:addresses/src/ui/addresses_screen.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:domain/domain.dart' as _i6;
import 'package:flutter/material.dart' as _i5;

abstract class $AddressesModule extends _i4.AutoRouterModule {
  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AddAddressRoute.name: (routeData) {
      final args = routeData.argsAs<AddAddressRouteArgs>(
          orElse: () => const AddAddressRouteArgs());
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddAddressBody(
          key: args.key,
          address: args.address,
        ),
      );
    },
    AddressesListRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AddressesListBody(),
      );
    },
    AddressesRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AddressesScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddAddressBody]
class AddAddressRoute extends _i4.PageRouteInfo<AddAddressRouteArgs> {
  AddAddressRoute({
    _i5.Key? key,
    _i6.UserAddress? address,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          AddAddressRoute.name,
          args: AddAddressRouteArgs(
            key: key,
            address: address,
          ),
          initialChildren: children,
        );

  static const String name = 'AddAddressRoute';

  static const _i4.PageInfo<AddAddressRouteArgs> page =
      _i4.PageInfo<AddAddressRouteArgs>(name);
}

class AddAddressRouteArgs {
  const AddAddressRouteArgs({
    this.key,
    this.address,
  });

  final _i5.Key? key;

  final _i6.UserAddress? address;

  @override
  String toString() {
    return 'AddAddressRouteArgs{key: $key, address: $address}';
  }
}

/// generated route for
/// [_i2.AddressesListBody]
class AddressesListRoute extends _i4.PageRouteInfo<void> {
  const AddressesListRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AddressesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressesListRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddressesScreen]
class AddressesRoute extends _i4.PageRouteInfo<void> {
  const AddressesRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AddressesRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressesRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
