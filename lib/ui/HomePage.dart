import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se2/models/user.dart';

import '../screens/home/home.dart';
import '../screens/home/teacherHome.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    if (user == null) {
      // If user is not authenticated, show Authenticate widget
      return Container(); // or show an error message
    } else {
      // Check if user is a teacher
      bool isTeacher = user.role == 'Teacher';
      if (isTeacher) {
        // If user is a teacher, show TeacherHome widget
        return TeacherHome();
      } else {
        // If user is not a teacher, show StudentHome widget
        return Home();
      }
    }
  }
}
