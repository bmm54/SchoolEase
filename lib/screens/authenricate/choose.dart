import 'package:flutter/material.dart';

class Choose extends StatelessWidget {
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/teacherSignUp');
              },
              child: Text('Teacher'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Student'),
            ),
          ],
        ),
      ),
    );
  }
}
