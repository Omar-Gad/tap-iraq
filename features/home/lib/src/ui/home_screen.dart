import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:home/home.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, child) {
        context.read<AddressCubit>().fetchAddresses(1);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavBar(),
        );
      },
    );
  }
}
