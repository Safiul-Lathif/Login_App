import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String authToken = "auth_token";
  final String lang = "language";
  final String prefLang = "prefLanguage";
  final String teacherId = "teacherId";
  final String teacherName = "teacherName";
  final String playerId = "playerId";

//set data into shared preferences like this
  Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(authToken, token);
  }

//get value from shared preferences
  Future<String?> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? authToken;
    authToken = (pref.getString(this.authToken));
    return authToken;
  }
}

class UserManage {
  final String id = "id";
  final String email = "email";
  final String first_name = "first_name";
  final String last_name = "last_name";
  final String avatar = "avatar";

//set data into shared preferences like this
  Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(id, id);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String id;
    id = (pref.getString(this.id) ?? null)!;
    return id;
  }
}
