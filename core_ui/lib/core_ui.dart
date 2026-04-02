import 'package:auto_route/annotations.dart';
import 'core_ui.gm.dart';

export 'src/screens/coming_soon_screen.dart';
export 'src/screens/tab_placeholders.dart';
export 'src/validators/app_email_validator.dart';
export 'src/validators/app_password_validator.dart';
export 'src/validators/app_phone_validator.dart';
export 'src/validators/app_name_validator.dart';
export 'src/validators/app_confirm_password_validator.dart';

export 'src/widgets/app_button.dart';
export 'src/widgets/app_password_field.dart';
export 'src/widgets/app_text_field.dart';
export 'src/widgets/bottom_nav_bar/bottom_nav_bar.dart';
export 'core_ui.gm.dart';
export 'src/theme/theme.dart';
export 'src/widgets/adaptive_builder.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen,Route')
class CoreUIModule extends $CoreUIModule {}
