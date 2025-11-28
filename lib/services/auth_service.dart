import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // REGISTER
  Future<bool> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString("email") != null) {
      return false; // user sudah ada
    }

    await prefs.setString("email", email);
    await prefs.setString("password", password);
    return true;
  }

  // LOGIN
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString("email");
    final savedPassword = prefs.getString("password");

    if (email == savedEmail && password == savedPassword) {
      prefs.setBool("isLogin", true);
      return true;
    }
    return false;
  }

  // LOGOUT
  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }
}
