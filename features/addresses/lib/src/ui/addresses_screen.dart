import 'package:addresses/src/ui/add_address_body.dart';
import 'package:addresses/src/ui/addresses_list_body.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

@RoutePage()
class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return BlocListener<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is AddressError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: switch (state) {
            AddressLoaded() => const AddressesListBody(),
            AddressLoading() =>
              const Center(child: CircularProgressIndicator()),
            AddressError() => const SizedBox.shrink(),
            AddressInitial() => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}
