import 'package:flutter/material.dart';
import 'package:tap_iraq/my_app.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DataDI.init(appLocator);
  await DomainDi.init(appLocator);
  NavigationDI.init(appLocator);

  final authRepository = appLocator<AuthRepository>();
  final isLoggedIn = await authRepository.checkSession();

  runApp(
    App(
      appRouter: appLocator<AppRouter>(),
      isLoggedIn: isLoggedIn,
    ),
  );
}
