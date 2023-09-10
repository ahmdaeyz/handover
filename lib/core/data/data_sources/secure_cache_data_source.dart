import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:handover/core/data/data_sources/cache_data_source.dart';
import 'package:injectable/injectable.dart';

/// A simple cache source that uses preferences as means
@LazySingleton(as: CacheDataSource)
class SecureCacheDataSource implements CacheDataSource {
  final FlutterSecureStorage _secureStorage;

  SecureCacheDataSource({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  @override
  void delete({required String key}) {
    _secureStorage.delete(key: key);
  }

  @override
  Future<String?> getString({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  @override
  void putString({required String key, required String value}) {
    _secureStorage.write(key: key, value: value);
  }
}
