import 'package:assesment_app/assesment_page.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService;
  final bool redirectToAssessment;

  LoginPage({required this.authService, this.redirectToAssessment = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Login.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;

                    bool loggedIn = await authService.login(username, password);

                    if (loggedIn) {
                      if (redirectToAssessment) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AssessmentPage(authService: authService)),
                        );
                      } else {
                        Navigator.pop(
                            context, true); // Navigate back with success flag
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Invalid username or password'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
