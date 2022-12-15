import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future setSession(String session) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("session", session);
  }

  Future<String> getSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("session") ?? "";
  }

  Future setHmailKey(String hmailkey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("hmail_key", hmailkey);
  }

  Future<String> getHmailKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("hmail_key") ?? "";
  }
}
