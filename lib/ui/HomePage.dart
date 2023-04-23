import 'package:flutter/material.dart';
import 'package:se2/screens/home/home.dart';
import 'package:se2/screens/home/teacherHome.dart';
import 'package:se2/services/check.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isTeacher = false;

  @override
  void initState() {
    super.initState();
    _checkUserType();
  }

  void _checkUserType() async {
    bool isTeacher = await Check.isTeacher();
    setState(() {
      _isTeacher = isTeacher;
    });
  }

  Widget _buildTeacherHomePage() {
    return TeacherHome();
  }

  Widget _buildStudentHomePage() {
    return Home();
  }

  @override
  Widget build(BuildContext context) {
    return _isTeacher ? _buildTeacherHomePage() : _buildStudentHomePage();
  }
}
