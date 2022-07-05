import 'package:shared_preferences/shared_preferences.dart';

class MyPreference {
  static SharedPreferences? _preferences;

  Future init() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  Future setUserType(int type) async {
    try {
      await _preferences?.setInt('user_type', type);
    } catch (e) {}
  }

  int getUserType() {
    try {
      return _preferences?.getInt('user_type') ?? 0;
    } catch (e) {}
    return 0;
  }

  Future setName(String type) async {
    try {
      await _preferences?.setString('user_name', type);
    } catch (e) {}
  }

  String getName() {
    try {
      return _preferences?.getString('user_name') ?? '';
    } catch (e) {}
    return '';
  }

  Future setEmail(String type) async {
    try {
      await _preferences?.setString('user_email', type);
    } catch (e) {}
  }

  String getEmail() {
    try {
      return _preferences?.getString('user_email') ?? '';
    } catch (e) {}
    return '';
  }

  Future setMyId(String type) async {
    try {
      await _preferences?.setString('user_id', type);
    } catch (e) {}
  }

  String getMyId() {
    try {
      return _preferences?.getString('user_id') ?? '';
    } catch (e) {}
    return '';
  }

  Future setToken(String type) async {
    try {
      await _preferences?.setString('user_token', type);
    } catch (e) {}
  }

  String getToken() {
    try {
      return _preferences?.getString('user_token') ?? '';
    } catch (e) {}
    return '';
  }

  Future<bool> dropPreferences()async {
   return await _preferences?.clear()??false;
  }
}
