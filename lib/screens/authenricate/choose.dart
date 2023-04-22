import 'package:flutter/material.dart';
import 'package:se2/screens/authenricate/studentSignin.dart';
import 'package:se2/screens/authenricate/teacherSignin.dart';

import '../../ui/theme.dart';

class Choose extends StatefulWidget {
  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.95;
    return Scaffold(
      backgroundColor: backg2,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  top: 85, bottom: 15, left: 10, right: 10),
              color: backg1,
              child: Container(
                padding: const EdgeInsets.all(3),
                height: 40, //adjust the height as per your requirement
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      15), //adjust the border radius as per your requirement
                  border: Border.all(color: input1, width: 1),
                  color: Colors.white, //set your desired color
                ),
                child: const TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    //change the height

                    //make the text and the icon visible
                    color: mainColor,
                  ),
                  tabs: [
                    Tab(
                      text: "Student",
                    ),
                    Tab(
                      text: "Teacher",
                    ),
                  ],
                  //style
                  labelColor: Colors.white,
                  unselectedLabelColor: textColor1,
                  //backgroundcolor
                  indicatorColor: mainColor,
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  // Content for the "Cour" tab
                  SigninStudent(),
                  // Content for the "TP" tab
                  SigninTeacher(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
