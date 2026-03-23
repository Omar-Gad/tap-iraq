import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressCubit>(
      create: (context) => AddressCubit(
        getAddressesUseCase: appLocator<GetAddressesUseCase>(),
        addAddressUseCase: appLocator<AddAddressUseCase>(),
        updateAddressUseCase: appLocator<UpdateAddressUseCase>(),
        deleteAddressUseCase: appLocator<DeleteAddressUseCase>(),
        setDefaultAddressUseCase: appLocator<SetDefaultAddressUseCase>(),
      )..fetchAddresses(1),
      child: AutoRouter(
        builder: (context, child) {
          final router = context.router;
          final currentIndex = _getCurrentIndex(router.currentPath);
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                switch (index) {
                  case 0:
                    router.navigateNamed('cleaning');
                    break;
                  case 1:
                    router.navigateNamed('orders');
                    break;
                  case 2:
                    router.navigateNamed('profile');
                    break;
                  case 3:
                    router.navigateNamed('settings');
                    break;
                }
              },
            ),
          );
        },
      ),
    );
  }

  int _getCurrentIndex(String path) {
    if (path.contains('cleaning')) return 0;
    if (path.contains('orders')) return 1;
    if (path.contains('profile')) return 2;
    if (path.contains('settings')) return 3;
    return 0;
  }
}
