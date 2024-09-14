import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Database();

  Future<bool> saveList(String key, List<String> value) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool h = await sharedPreferences.setStringList(key, value);
      return h;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<List<String>?> loadList(String key) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<String>? data = sharedPreferences.getStringList(key);
      return data;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
