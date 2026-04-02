import 'package:data/src/providers/mock/app_database.dart';
import 'package:data/src/models/models.dart';
import 'package:drift/drift.dart';
import 'package:domain/domain.dart';

class AddressMapper {
  // From Drift to Domain
  static UserAddress fromDriftToEntity(AddressEntry model) {
    return UserAddress(
      id: model.id,
      userId: model.userId,
      street: model.street,
      city: model.city,
      zipCode: model.zipCode,
      label: model.label,
      isDefault: model.isDefault,
    );
  }

  // From DTO (API) to Domain
  static UserAddress fromDtoToEntity(AddressModel model) {
    return UserAddress(
      id: model.uid,
      userId: model.userId,
      street: model.street,
      city: model.city,
      zipCode: model.zipCode,
      label: model.label,
      isDefault: model.isDefault,
    );
  }

  // From Domain to DTO (API)
  static AddressModel toDto(UserAddress entity) {
    return AddressModel(
      uid: entity.id ?? 0,
      userId: entity.userId,
      street: entity.street,
      city: entity.city,
      zipCode: entity.zipCode,
      label: entity.label,
      isDefault: entity.isDefault,
    );
  }

  // From Domain to Drift Companion
  static AddressesCompanion toCompanion(UserAddress entity) {
    return AddressesCompanion(
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      userId: Value(entity.userId),
      street: Value(entity.street),
      city: Value(entity.city),
      zipCode: Value(entity.zipCode),
      label: Value(entity.label),
      isDefault: Value(entity.isDefault),
    );
  }

  // From Drift to DTO (API) - used in FakeApiProvider
  static AddressModel fromDriftToDto(AddressEntry model) {
    return AddressModel(
      uid: model.id,
      userId: model.userId,
      street: model.street,
      city: model.city,
      zipCode: model.zipCode,
      label: model.label,
      isDefault: model.isDefault,
    );
  }
}
