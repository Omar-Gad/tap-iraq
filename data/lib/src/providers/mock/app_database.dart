import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get login => text().unique()();
  TextColumn get password => text()();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get sessionId => text().withDefault(const Constant(''))();
  IntColumn get companyId => integer().withDefault(const Constant(1))();
  BoolColumn get isSessionActive =>
      boolean().withDefault(const Constant(false))();
}

@DataClassName('AddressEntry')
class Addresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get street => text()();
  TextColumn get city => text().withDefault(const Constant(''))();
  TextColumn get zipCode => text().withDefault(const Constant(''))();
  TextColumn get label => text().withDefault(const Constant(''))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}

@DataClassName('CleaningServiceEntry')
class CleaningServices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
}

@DataClassName('CleaningTypeEntry')
class CleaningTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get serviceId => integer()
      .references(CleaningServices, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  TextColumn get duration => text()();
  BoolColumn get isPopular => boolean().withDefault(const Constant(false))();
}

@DataClassName('CleaningRequestEntry')
class CleaningRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get serviceId => integer()
      .references(CleaningServices, #id, onDelete: KeyAction.cascade)();
  IntColumn get typeId =>
      integer().references(CleaningTypes, #id, onDelete: KeyAction.cascade)();
  IntColumn get addressId =>
      integer().references(Addresses, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get scheduledAt => dateTime()();
  IntColumn get status => integer()(); // Enum index for CleaningRequestStatus

  // Cleaner Info (Flattened for simplicity in mock DB)
  TextColumn get cleanerName => text().nullable()();
  TextColumn get cleanerPhone => text().nullable()();
  TextColumn get cleanerPhotoUrl => text().nullable()();
}

@DriftDatabase(tables: [
  Users,
  Addresses,
  CleaningServices,
  CleaningTypes,
  CleaningRequests
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) await m.createTable(addresses);
          if (from < 3) {
            await m.createTable(cleaningServices);
            await m.createTable(cleaningRequests);
          }
          if (from < 5) {
            // Destruction/Recreation for simplicity in mock during this refactor
            await m.deleteTable('cleaning_services');
            await m.deleteTable('cleaning_requests');
            await m.createTable(cleaningServices);
            await m.createTable(cleaningTypes);
            await m.createTable(cleaningRequests);
          }
          if (from < 6) {
            await m.addColumn(users, users.phone);
          }
          if (from < 7) {
            // Re-creating addresses table because of new non-nullable columns without defaults in existing rows
            // In a mock DB, we can just delete it or add columns with literal defaults
            await m.addColumn(addresses, addresses.city);
            await m.addColumn(addresses, addresses.zipCode);
            await m.addColumn(addresses, addresses.label);
          }
        },
      );



  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'tap_iraq_mock_db');
  }
}
