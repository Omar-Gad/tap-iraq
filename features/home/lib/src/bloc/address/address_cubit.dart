import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final GetAddressesUseCase _getAddressesUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final SetDefaultAddressUseCase _setDefaultAddressUseCase;

  AddressCubit({
    required GetAddressesUseCase getAddressesUseCase,
    required AddAddressUseCase addAddressUseCase,
    required UpdateAddressUseCase updateAddressUseCase,
    required DeleteAddressUseCase deleteAddressUseCase,
    required SetDefaultAddressUseCase setDefaultAddressUseCase,
  })  : _getAddressesUseCase = getAddressesUseCase,
        _addAddressUseCase = addAddressUseCase,
        _updateAddressUseCase = updateAddressUseCase,
        _deleteAddressUseCase = deleteAddressUseCase,
        _setDefaultAddressUseCase = setDefaultAddressUseCase,
        super(const AddressInitial());

  Future<void> fetchAddresses(int userId) async {
    emit(const AddressLoading());
    try {
      final addresses = await _getAddressesUseCase.execute(userId);
      emit(AddressLoaded(addresses: addresses));
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  Future<void> addAddress(UserAddress address) async {
    emit(const AddressLoading());
    try {
      await _addAddressUseCase.execute(address);
      await fetchAddresses(address.userId);
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  Future<void> updateAddress(UserAddress address) async {
    emit(const AddressLoading());
    try {
      await _updateAddressUseCase.execute(address);
      await fetchAddresses(address.userId);
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  Future<void> deleteAddress(int userId, int addressId) async {
    emit(const AddressLoading());
    try {
      await _deleteAddressUseCase.execute(addressId);
      await fetchAddresses(userId);
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  Future<void> setDefaultAddress(int userId, int addressId) async {
    emit(const AddressLoading());
    try {
      final params = SetDefaultAddressParams(userId: userId, addressId: addressId);
      await _setDefaultAddressUseCase.execute(params);
      await fetchAddresses(userId);
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }
}
