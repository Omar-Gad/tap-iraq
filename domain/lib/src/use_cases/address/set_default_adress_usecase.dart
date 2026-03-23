import '../../repositories/address_repository.dart';
import '../../entities/address/set_default_address_params.dart';
import '../usecase.dart';

class SetDefaultAddressUseCase extends FutureUseCase<SetDefaultAddressParams, void> {
  final AddressRepository _repository;

  SetDefaultAddressUseCase(this._repository);

  @override
  Future<void> execute(SetDefaultAddressParams input) {
    return _repository.setDefaultAddress(input.userId, input.addressId);
  }
}
