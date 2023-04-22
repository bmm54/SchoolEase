import 'package:flutter/material.dart';
import 'package:se2/screens/authenricate/choose.dart';
import 'package:se2/screens/authenricate/register.dart';
import 'package:se2/screens/authenricate/studentSignin.dart';
import 'package:se2/screens/authenricate/teacherSignUp.dart';

// i replace this page with choose.dart
/*
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView() {
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin == true) {
      //return Signin(toggleView: toggleView);
      return Choose(toggleView: toggleView);
    } else {
      //return Register(toggleView: toggleView);
      //does not exist
      return Register(toggleView: toggleView);
    }
  }
}
*/