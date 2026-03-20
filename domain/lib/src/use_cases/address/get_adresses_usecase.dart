import '../../entities/address/user_address.dart';
import '../../repositories/address_repository.dart';
import '../usecase.dart';

class GetAddressesUseCase extends FutureUseCase<int, List<UserAddress>> {
  final AddressRepository _repository;

  GetAddressesUseCase(this._repository);

  @override
  Future<List<UserAddress>> execute(int input) {
    return _repository.getAddresses(input);
  }
}
