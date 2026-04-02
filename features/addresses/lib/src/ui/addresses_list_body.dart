import 'package:addresses/addresses.gm.dart';
import 'package:addresses/src/ui/widgets/address_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

@RoutePage()
class AddressesListBody extends StatelessWidget {
  const AddressesListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          switch (state) {
            case AddressLoaded state:
              final addresses = state.addresses;

              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            top: 24,
                            bottom: 24,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localizations.my_addresses,
                                  style: AppFonts.bold36
                                      .copyWith(letterSpacing: -0.9),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  localizations.saved_service.toUpperCase(),
                                  style: AppFonts.normal14.copyWith(
                                    letterSpacing: 0.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (addresses.isEmpty)
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Text(
                                localizations.no_addresses,
                                style: AppFonts.normal16,
                              ),
                            ),
                          )
                        else
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            sliver: SliverList.separated(
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                return AddressItem(address: addresses[index]);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16);
                              },
                            ),
                          ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 24),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 24,
                    ),
                    child: AppButton(
                      submitText: localizations.add_address,
                      onSubmit: () {
                        context.router.push(AddAddressRoute());
                      },
                      isActive: true,
                      icon: Icon(Icons.add_location_alt_outlined,
                          color: colors.white),
                    ),
                  ),
                ],
              );

            case AddressInitial():
              return const SizedBox.shrink();
            case AddressLoading():
              return const Center(child: CircularProgressIndicator());
            case AddressError():
              return Center(child: Text(state.message));
          }
        },
      ),
    );
  }
}
