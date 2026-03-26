import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'package:auto_route/auto_route.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/home.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddressCubit>(
          create: (context) => AddressCubit(
            getAddressesUseCase: appLocator<GetAddressesUseCase>(),
            addAddressUseCase: appLocator<AddAddressUseCase>(),
            updateAddressUseCase: appLocator<UpdateAddressUseCase>(),
            deleteAddressUseCase: appLocator<DeleteAddressUseCase>(),
            setDefaultAddressUseCase: appLocator<SetDefaultAddressUseCase>(),
          )..fetchAddresses(1), // Mock user ID 1
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(
          deepLinkBuilder: (deepLink) {
            if (isLoggedIn) {
              return DeepLink([const HomeRoute()]);
            }
            return DeepLink([const AuthRoute()]);
          },
        ),
      ),
    );
  }
}
