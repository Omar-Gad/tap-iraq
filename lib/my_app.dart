import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'package:auto_route/auto_route.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;
  final bool isLoggedIn;

  const App({
    required this.appRouter,
    required this.isLoggedIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(
        deepLinkBuilder: (deepLink) {
          if (isLoggedIn) {
            return DeepLink([const HomeRoute()]);
          }
          return DeepLink([const AuthRoute()]);
        },
      ),
    );
  }
}
