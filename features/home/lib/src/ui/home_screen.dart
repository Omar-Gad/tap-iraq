import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/address/address_cubit.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const AutoRouter(),
      ),
    );
  }
}
