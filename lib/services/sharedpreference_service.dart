import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService{
  SharedPreferences? _preferences;

  Future<void> initPreference() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    await initPreference();
    await _preferences!.setString('token', token);
  }

  Future<String> getToken() async {
    await initPreference();
    return await _preferences!.getString('token') ?? '';
  }


}