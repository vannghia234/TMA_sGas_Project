import 'package:shared_preferences/shared_preferences.dart';

class KeyStorage {
  String? _accessToken;
  String? _refreshToken;
  String? get accessToken => _accessToken;
  get refreshToken => _refreshToken;

  Future<void> save(
      {required String accessToken, required String refreshToken}) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", accessToken);
    await prefs.setString("refreshToken", refreshToken);

    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  Future<void> read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('accessToken') != null) {
      _accessToken = prefs.getString('accessToken');
    }
    if (prefs.getString('refreshToken') != null) {
      _refreshToken = prefs.getString('refreshToken');
    }
  }

  Future<void> remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}
