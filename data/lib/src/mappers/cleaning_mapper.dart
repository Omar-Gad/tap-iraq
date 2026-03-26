import 'package:data/src/providers/mock/app_database.dart' as db;
import 'package:data/src/models/models.dart';
import 'package:drift/drift.dart';
import 'package:domain/domain.dart';

class CleaningMapper {
  // --- Services ---

  static CleaningService fromDriftService(db.CleaningServiceEntry model, List<db.CleaningTypeEntry> types) {
    return CleaningService(
      id: model.id,
      name: model.name,
      description: model.description,
      types: types.map(fromDriftType).toList(),
    );
  }

  static CleaningType fromDriftType(db.CleaningTypeEntry model) {
    return CleaningType(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      duration: model.duration,
      isPopular: model.isPopular,
    );
  }

  static db.CleaningServicesCompanion serviceToCompanion(CleaningService entity) {
    return db.CleaningServicesCompanion(
      id: entity.id != 0 ? Value(entity.id) : const Value.absent(),
      name: Value(entity.name),
      description: Value(entity.description),
    );
  }

  // --- Requests ---

  static CleaningRequest fromDriftRequest(db.CleaningRequestEntry model) {
    CleanerInfo? cleaner;
    if (model.cleanerName != null && model.cleanerPhone != null) {
      cleaner = CleanerInfo(
        name: model.cleanerName!,
        phone: model.cleanerPhone!,
        photoUrl: model.cleanerPhotoUrl,
      );
    }

    return CleaningRequest(
      id: model.id,
      serviceId: model.serviceId,
      typeId: model.typeId,
      addressId: model.addressId,
      scheduledAt: model.scheduledAt,
      status: CleaningRequestStatus.values[model.status],
      assignedCleaner: cleaner,
    );
  }

  static db.CleaningRequestsCompanion requestToCompanion(CleaningRequest entity) {
    return db.CleaningRequestsCompanion(
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      serviceId: Value(entity.serviceId),
      typeId: Value(entity.typeId),
      addressId: Value(entity.addressId),
      scheduledAt: Value(entity.scheduledAt),
      status: Value(entity.status.index),
      cleanerName: Value(entity.assignedCleaner?.name),
      cleanerPhone: Value(entity.assignedCleaner?.phone),
      cleanerPhotoUrl: Value(entity.assignedCleaner?.photoUrl),
    );
  }

  // --- DTO Mappings ---

  static CleaningService entityFromServiceModel(CleaningServiceModel model) {
    return CleaningService(
      id: model.id,
      name: model.name,
      description: model.description,
      types: model.types.map(typeFromTypeModel).toList(),
    );
  }

  static CleaningType typeFromTypeModel(CleaningTypeModel model) {
    return CleaningType(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      duration: model.duration,
      isPopular: model.isPopular,
    );
  }

  static CleaningRequest entityFromRequestModel(CleaningRequestModel model) {
    CleanerInfo? cleaner;
    if (model.cleanerName != null && model.cleanerPhone != null) {
      cleaner = CleanerInfo(
        name: model.cleanerName!,
        phone: model.cleanerPhone!,
        photoUrl: model.cleanerPhotoUrl,
      );
    }
    return CleaningRequest(
      id: model.id,
      serviceId: model.serviceId,
      typeId: model.typeId,
      addressId: model.addressId,
      scheduledAt: model.scheduledAt,
      status: CleaningRequestStatus.values[model.status],
      assignedCleaner: cleaner,
    );
  }

  static CleaningRequestModel entityToRequestModel(CleaningRequest entity) {
    return CleaningRequestModel(
      id: entity.id,
      serviceId: entity.serviceId,
      typeId: entity.typeId,
      addressId: entity.addressId,
      scheduledAt: entity.scheduledAt,
      status: entity.status.index,
      cleanerName: entity.assignedCleaner?.name,
      cleanerPhone: entity.assignedCleaner?.phone,
      cleanerPhotoUrl: entity.assignedCleaner?.photoUrl,
    );
  }
}
