import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  bool _isLoggedIn = false;

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    final storedPassword = prefs.getString('password');

    await Future.delayed(Duration(seconds: 1)); // Simulating a delay

    if (email == storedEmail && password == storedPassword) {
      _isLoggedIn = true;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    return true;
  }

  bool isLoggedIn() {
    return _isLoggedIn;
  }

  void logout() {
    _isLoggedIn = false;
  }
}
