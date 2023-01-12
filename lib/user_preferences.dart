import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setEmail(String data) async {
    await _preferences?.setString('email', data);
  }

  static String? getEmail() {
    return _preferences?.getString('email');
  }
}
