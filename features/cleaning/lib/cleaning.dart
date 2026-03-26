import 'package:auto_route/auto_route.dart';
import 'cleaning.gm.dart';

export 'src/ui/cleaning_screen.dart';
export 'src/ui/cleaning_booking_screen.dart';
export 'src/bloc/cleaning_cubit.dart';
export 'src/bloc/cleaning_state.dart';
export 'cleaning.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen,Route')
class CleaningModule extends $CleaningModule {}
