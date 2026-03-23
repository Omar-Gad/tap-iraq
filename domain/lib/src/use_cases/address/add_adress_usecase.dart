import '../../entities/address/user_address.dart';
import '../../repositories/address_repository.dart';
import '../usecase.dart';

class AddAddressUseCase extends FutureUseCase<UserAddress, UserAddress> {
  final AddressRepository _repository;

  AddAddressUseCase(this._repository);

  @override
  Future<UserAddress> execute(UserAddress input) {
    return _repository.addAddress(input);
  }
}
