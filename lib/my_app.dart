import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;

  const App({
    required this.appRouter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
