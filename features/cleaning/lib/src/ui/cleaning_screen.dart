import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import '../bloc/cleaning_cubit.dart';
import '../bloc/cleaning_state.dart';

@RoutePage()
class CleaningScreen extends StatelessWidget {
  const CleaningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CleaningCubit>(
      create: (context) => CleaningCubit(
        getServices: appLocator<GetCleaningServicesUseCase>(),
        getAddresses: appLocator<GetAddressesUseCase>(),
        createRequest: appLocator<CreateCleaningRequestUseCase>(),
        cancelRequest: appLocator<CancelCleaningRequestUseCase>(),
      )..fetchBookingData(1),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Cleaning Service'),
        ),
        body: BlocBuilder<CleaningCubit, CleaningState>(
          builder: (context, state) {
            if (state is CleaningLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CleaningLoaded) {
              return ListView.builder(
                itemCount: state.services.length,
                itemBuilder: (context, index) {
                  final service = state.services[index];
                  double minPrice = 0;
                  if (service.types.isNotEmpty) {
                    minPrice = service.types.map((t) => t.price).reduce((a, b) => a < b ? a : b);
                  }

                  return ListTile(
                    title: Text(service.name),
                    subtitle: Text(service.description),
                    trailing: minPrice > 0 ? Text('From IQD ${minPrice.toInt()}') : null,
                    onTap: () {
                      context.router.push(
                        CleaningBookingRoute(serviceId: service.id),
                      );
                    },
                  );
                },
              );
            }

            if (state is CleaningError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
