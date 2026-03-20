import '../../repositories/address_repository.dart';
import '../usecase.dart';

class DeleteAddressUseCase extends FutureUseCase<int, void> {
  final AddressRepository _repository;

  DeleteAddressUseCase(this._repository);

  @override
  Future<void> execute(int input) {
    return _repository.deleteAddress(input);
  }
}
