import 'package:shared_preferences/shared_preferences.dart';

import '../../data/cache/cache.dart';

class LocalDataSourceAdapter implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceAdapter(this.sharedPreferences);

  @override
  Future<bool> saveData({required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> getData({required String key}) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<bool> deleteData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
