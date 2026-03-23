import 'package:auto_route/annotations.dart';
import 'core_ui.gm.dart';

export 'src/screens/coming_soon_screen.dart';
export 'src/screens/tab_placeholders.dart';
export 'src/widgets/bottom_nav_bar/bottom_nav_bar.dart';
export 'core_ui.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen,Route')
class CoreUIModule extends $CoreUIModule {}
