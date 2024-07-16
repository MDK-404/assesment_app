import 'dart:async';

class AuthService {
  String _username = 'admin';
  String _password = 'admin';
  bool _isLoggedIn = false;

  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulating a delay

    if (username == _username && password == _password) {
      _isLoggedIn = true;
      return true;
    } else {
      return false;
    }
  }

  bool isLoggedIn() {
    return _isLoggedIn;
  }

  void logout() {
    _isLoggedIn = false;
  }
}
