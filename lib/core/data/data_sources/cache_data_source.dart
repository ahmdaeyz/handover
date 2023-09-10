abstract class CacheDataSource {
  void putString({required String key, required String value});

  Future<String?> getString({required String key});

  void delete({required String key});
}
