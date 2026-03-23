import '../../entities/address/user_address.dart';
import '../../repositories/address_repository.dart';
import '../usecase.dart';

class UpdateAddressUseCase extends FutureUseCase<UserAddress, UserAddress> {
  final AddressRepository _repository;

  UpdateAddressUseCase(this._repository);

  @override
  Future<UserAddress> execute(UserAddress input) {
    return _repository.updateAddress(input);
  }
}
