import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/home.dart';
import '../bloc/cleaning_cubit.dart';
import '../bloc/cleaning_state.dart';

@RoutePage()
class CleaningBookingScreen extends StatelessWidget {
  final int serviceId;

  const CleaningBookingScreen({
    super.key,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CleaningCubit>(
      create: (context) => CleaningCubit(
        getServices: appLocator<GetCleaningServicesUseCase>(),
        getAddresses: appLocator<GetAddressesUseCase>(),
        createRequest: appLocator<CreateCleaningRequestUseCase>(),
        cancelRequest: appLocator<CancelCleaningRequestUseCase>(),
      )..fetchBookingData(1), // Mocking user 1
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
        ),
        body: BlocBuilder<CleaningCubit, CleaningState>(
          builder: (context, cleaningState) {
            return BlocBuilder<AddressCubit, AddressState>(
              builder: (context, addressState) {
                if (cleaningState is CleaningLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (cleaningState is CleaningLoaded) {
                  // If no selection yet, auto-select based on serviceId
                  if (cleaningState.selectedService == null) {
                    final initialService = cleaningState.services.firstWhere(
                      (s) => s.id == serviceId,
                      orElse: () => cleaningState.services.first,
                    );
                    Future.microtask(() {
                      context.read<CleaningCubit>().selectService(initialService);
                      if (initialService.types.isNotEmpty) {
                        context.read<CleaningCubit>().selectType(initialService.types.first);
                      }
                    });
                  }

                  final addresses = addressState is AddressLoaded ? addressState.addresses : <UserAddress>[];
                  final currentService = cleaningState.selectedService;
                  final currentType = cleaningState.selectedType;

                  return LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (currentService != null) ...[
                            Text('Service: ${currentService.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(height: 4),
                            Text(currentService.description, style: const TextStyle(color: Colors.grey)),
                            const Divider(height: 32),
                            const Text('Select Service Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 12),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: currentService.types.length,
                              itemBuilder: (context, i) {
                                final t = currentService.types[i];
                                return RadioListTile<int>(
                                  title: Text(t.name),
                                  subtitle: Text('${t.description}\n${t.duration}'),
                                  secondary: Text('IQD ${t.price.toInt()}'),
                                  value: t.id,
                                  groupValue: currentType?.id,
                                  onChanged: (_) => context.read<CleaningCubit>().selectType(t),
                                );
                              },
                            ),
                            if (currentType != null) ...[
                              const SizedBox(height: 12),
                              Text(currentType.description, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                            ],
                          ], // Added missing closing bracket covering the whole currentService section
                          const Divider(height: 32),
                          const Text('Service Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 12),
                          if (addresses.isEmpty)
                            const Text('Please add an address in your profile.')
                          else
                            ...addresses.map((a) {
                              return RadioListTile<int>(
                                title: Text(a.street),
                                value: a.id!,
                                groupValue: cleaningState.selectedAddress?.id,
                                onChanged: (_) => context.read<CleaningCubit>().selectAddress(a),
                                activeColor: const Color(0xFF4A68FF),
                              );
                            }),
                          const Divider(height: 32),
                          const Text('Select Date:', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (context, i) {
                                final date = DateTime.now().add(Duration(days: i));
                                final isSelected = cleaningState.selectedDate?.day == date.day;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text('${date.day}/${date.month}'),
                                    selected: isSelected,
                                    onSelected: (_) => context.read<CleaningCubit>().selectDate(date),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(height: 32),
                          const Text('Select Time:', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(8, (i) {
                              final time = TimeOfDay(hour: 9 + i, minute: 0);
                              final isSelected = cleaningState.selectedTime?.hour == time.hour;
                              return ChoiceChip(
                                label: Text('${time.hour}:00'),
                                selected: isSelected,
                                onSelected: (_) => context.read<CleaningCubit>().selectTime(time),
                              );
                            }),
                          ),
                          const SizedBox(height: 48),
                          Row(
                            children: [
                              Expanded(
                                child: Text('Total: IQD ${currentType?.price.toInt() ?? 0}',
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: cleaningState.selectedService != null &&
                                        cleaningState.selectedType != null &&
                                        cleaningState.selectedAddress != null &&
                                        cleaningState.selectedDate != null &&
                                        cleaningState.selectedTime != null
                                    ? () {
                                        context.read<CleaningCubit>().placeOrder();
                                        context.router.pop(); // Pop back after booking
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4A68FF),
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Book Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
                }

                if (cleaningState is CleaningError) {
                  return Center(child: Text(cleaningState.message));
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
