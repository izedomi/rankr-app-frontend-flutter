import 'package:shared_preferences/shared_preferences.dart';

import '../app/constants/storage_keys.dart';

class StorageService {
  /* ====== Token ========= */
  static Future<bool> storeAccessToken(String token) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(StorageKey.accessToken, token);
  }

  static Future<String?> getAccessToken() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(StorageKey.accessToken) &&
        sharedPreferences.getString(StorageKey.accessToken) != null) {
      return sharedPreferences.getString(StorageKey.accessToken);
    }
    return null;
  }

  /* ====== Generic ========= */
  static Future reset() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    await sharedPreferences.remove(StorageKey.accessToken);
  }
}
