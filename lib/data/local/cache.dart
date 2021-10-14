import 'package:clypto/utils/clypto_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalCache {
  bool containsKey(String key);
  Future<void> saveToLocalStorage({required String key, required dynamic value});
  Future<dynamic> getFromLocalStorage(String key);
  Future<void> removeFromLocalStorage(String key);
}

class LocalCacheImpl implements LocalCache {
  static final String INCOME = 'token';

  SharedPreferences sharedPreferences;

  LocalCacheImpl({required this.sharedPreferences});

  @override
  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }

  @override
  Future<dynamic> getFromLocalStorage(String key) async {
    return sharedPreferences.get(key);
  }

  @override
  Future<void> removeFromLocalStorage(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> saveToLocalStorage({required String key, required value}) async {
    MyLogger.logger.d('Data being saved:: key: $key, value: $value');
    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    }
  }
}
