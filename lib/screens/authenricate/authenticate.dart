import 'package:flutter/material.dart';
import 'package:se2/screens/authenricate/register.dart';
import 'package:se2/screens/authenricate/sign_in.dart';
import 'package:se2/screens/authenricate/teacherSignUp.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin=true;
  void toggleView(){
    setState(() => showSignin = !showSignin);
  }
  @override
  Widget build(BuildContext context) {
    if (showSignin==true){
      return Signin(toggleView: toggleView);
    }
    else{
      //return Register(toggleView: toggleView);
      return TeacherSignupForm(toggleView: toggleView);
    }
  }
}
