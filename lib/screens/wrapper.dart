import 'package:flutter/material.dart' ;
import 'package:provider/provider.dart';
import 'package:se2/models/user.dart';
import 'package:se2/screens/authenricate/authenticate.dart';
import 'package:se2/screens/home/home.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Users?>(context);
    //return home or authenticate widget
    if (user==null){
      return Authenticate();
    }else{
      return Home();
    }


  }
}
