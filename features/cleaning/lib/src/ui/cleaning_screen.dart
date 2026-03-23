import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
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
        getRequests: appLocator<GetCleaningRequestsUseCase>(),
        createRequest: appLocator<CreateCleaningRequestUseCase>(),
        cancelRequest: appLocator<CancelCleaningRequestUseCase>(),
      )..fetchCleaningData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cleaning Services'),
        ),
        body: BlocBuilder<CleaningCubit, CleaningState>(
          builder: (context, state) {
            if (state is CleaningLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CleaningLoaded) {
              if (state.services.isEmpty) {
                return const Center(child: Text('No services available'));
              }
              return ListView.builder(
                itemCount: state.services.length,
                itemBuilder: (context, index) {
                  final service = state.services[index];
                  return ListTile(
                    title: Text(service.name),
                    subtitle: Text('${service.price} QAR - ${service.duration}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to service detail or booking
                    },
                  );
                },
              );
            } else if (state is CleaningError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Initial state'));
          },
        ),
      ),
    );
  }
}
