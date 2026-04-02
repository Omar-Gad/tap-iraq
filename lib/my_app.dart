import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddressCubit>(
          create: (context) => AddressCubit(
            getAddressesUseCase: appLocator<GetAddressesUseCase>(),
            addAddressUseCase: appLocator<AddAddressUseCase>(),
            updateAddressUseCase: appLocator<UpdateAddressUseCase>(),
            deleteAddressUseCase: appLocator<DeleteAddressUseCase>(),
            setDefaultAddressUseCase: appLocator<SetDefaultAddressUseCase>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        theme: lightTheme,
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
