import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalDataProvider {
  Future<void> write({required String key, required String value});

  Future<String?> read(String key);

  Future<void> delete(String key);

  Future<void> deleteAll();

  Future<bool> contains(String key);
}

class SecuredStorageProvider implements LocalDataProvider {
  SecuredStorageProvider({
    required FlutterSecureStorage storage,
  }) : _storage = storage;
  final FlutterSecureStorage _storage;

  @override
  Future<bool> contains(String key) {
    return _storage.containsKey(key: key);
  }

  @override
  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() {
    return _storage.deleteAll();
  }

  @override
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  @override
  Future<void> write({
    required String key,
    required String value,
  }) {
    return _storage.write(
      key: key,
      value: value,
    );
  }
}
