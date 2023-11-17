abstract class LocalDataSource {
  Future<bool> saveData({required String key, required String value});
  Future<String?> getData({required String key});
  Future<bool> deleteData({required String key});
}
