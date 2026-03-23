import 'package:auto_route/annotations.dart';

import 'home.gm.dart';

export 'src/ui/home_screen.dart';
export 'src/bloc/address/address_cubit.dart';
export 'src/bloc/address/address_state.dart';
export 'home.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen|Dialog,Route')
class HomeModule extends $HomeModule {}
