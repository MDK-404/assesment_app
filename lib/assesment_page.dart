import 'package:flutter/material.dart';
import 'auth.dart';
import 'login.dart';
//import 'login_page.dart';

class AssessmentPage extends StatefulWidget {
  final AuthService authService;

  AssessmentPage({required this.authService});

  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  List<int> _selectedOptions = List.filled(5, -1);

  final List<String> _questions = [
    "What is the capital of Pakistan?",
    "What is the capital of India?",
    "How many times has Australia won the ODI World Cup?",
    "Who scored the most centuries in T20 international?",
    "How many matches has Jimmy Anderson played in Test cricket?"
  ];

  final List<List<String>> _options = [
    ["Karachi", "Islamabad", "Peshawar", "Lahore"],
    ["Mumbai", "New Delhi", "Bengaluru", "Lucknow"],
    ["2", "4", "5", "6"],
    ["Maxwell", "Rohit Sharma", "Chris Gayle", "Both a and b"],
    ["190", "195", "188", "196"]
  ];

  final List<int> _correctAnswers = [1, 1, 3, 3, 2];

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < _selectedOptions.length; i++) {
      if (_selectedOptions[i] == _correctAnswers[i]) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assessment')),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[200]!, Colors.blue[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_questions[index],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          ...List.generate(4, (optionIndex) {
                            return RadioListTile(
                              title: Text(_options[index][optionIndex]),
                              value: optionIndex,
                              groupValue: _selectedOptions[index],
                              onChanged: (value) {
                                setState(() {
                                  _selectedOptions[index] = value!;
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.authService.isLoggedIn()) {
                  _showResultDialog();
                } else {
                  bool? loggedIn = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage(authService: widget.authService)),
                  );
                  if (loggedIn == true) {
                    _showResultDialog();
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text('Your score is ${_calculateScore()}/5'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.popUntil(context,
                    (route) => route.isFirst); // Navigate back to home screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
