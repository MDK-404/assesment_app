import 'package:assesment_app/assesment_page.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  final AuthService authService;

  HomePage({required this.authService});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment App'),
        actions: [
          TextButton(
            onPressed: () async {
              if (!widget.authService.isLoggedIn()) {
                bool? loggedIn = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage(authService: widget.authService)),
                );
                if (loggedIn == true) {
                  setState(() {}); // Refresh the state to reflect login status
                }
              } else {
                widget.authService.logout();
                setState(() {}); // Refresh the state to reflect logout status
              }
            },
            child: Text(
              widget.authService.isLoggedIn() ? 'Logout' : 'Login',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AssessmentPage(authService: widget.authService)),
            );
          },
          child: Text('Take Assessment'),
        ),
      ),
    );
  }
}
