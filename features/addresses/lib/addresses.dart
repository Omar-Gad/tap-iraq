import 'package:auto_route/auto_route.dart';
import 'addresses.gm.dart';
export 'addresses.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen|Body,Route')
class AddressesModule extends $AddressesModule {}
