import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get login => text().unique()();
  TextColumn get password => text()();
  TextColumn get sessionId => text().withDefault(const Constant(''))();
  IntColumn get companyId => integer().withDefault(const Constant(1))();
  BoolColumn get isSessionActive =>
      boolean().withDefault(const Constant(false))();
}

@DataClassName('Address')
class Addresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get street => text()();
  IntColumn get propertyType => integer()();
  IntColumn get propertySize => integer()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Users, Addresses])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(addresses);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'tap_iraq_mock_db');
  }
}
