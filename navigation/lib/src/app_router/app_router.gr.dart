// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth/auth.dart' as _i2;
import 'package:auto_route/auto_route.dart' as _i1;
import 'package:cleaning/cleaning.dart' as _i4;
import 'package:core_ui/core_ui.dart' as _i5;
import 'package:home/home.dart' as _i3;

abstract class $AppRouter extends _i1.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    ..._i2.AuthModule().pagesMap,
    ..._i3.HomeModule().pagesMap,
    ..._i4.CleaningModule().pagesMap,
    ..._i5.CoreUIModule().pagesMap,
  };
}
