import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se2/models/user.dart';
import 'package:se2/screens/home/home.dart';
import 'package:se2/screens/home/teacherHome.dart';
import 'package:se2/services/auth.dart';
import 'package:se2/ui/HomePage.dart';
import 'authenricate/choose.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    if (user == null)
      return Choose();
    else {
      return HomePage();
    }
  }
}
