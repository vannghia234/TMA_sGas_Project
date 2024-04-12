import 'package:shared_preferences/shared_preferences.dart';

class LocalServiceClient {
  static save({required String key, required dynamic value}) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case int:
        await instance.setInt(key, value);
        break;
      case double:
        await instance.setDouble(key, value);
        break;
      case const (List<String>):
        await instance.setStringList(key, value);
        break;
      case bool:
        await instance.setBool(key, value);
        break;

      default:
        await instance.setString(key, value.toString());
    }
  }

  static get(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.get(key);
  }

  static remove(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove(key);
  }
}
