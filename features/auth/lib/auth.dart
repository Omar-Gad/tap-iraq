import 'package:auto_route/annotations.dart';

import 'auth.gm.dart';

export 'src/ui/auth_screen.dart';
export 'src/ui/login_body.dart';
export 'src/ui/register_body.dart';
export 'src/bloc/auth_cubit.dart';
export 'src/bloc/auth_state.dart';
export 'auth.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen,Route')
class AuthModule extends $AuthModule {}
