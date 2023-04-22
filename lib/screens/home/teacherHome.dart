import 'package:flutter/material.dart';
import 'package:se2/screens/home/pages/documents.dart';
import 'package:se2/screens/home/pages/notifications.dart';
import 'package:se2/ui/theme.dart';

import 'navbar.dart';

class TeacherHome extends StatelessWidget {
  TeacherHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: backg2,
        appBar: AppBar(
          iconTheme: IconThemeData(color: textColor1),
          backgroundColor: backg1,
          elevation: 0.0,
          title: Text(
            "Teacher",
            style: TextStyle(color: textColor1),
          ),
          centerTitle: true,
        ),
        drawer: NavBar(),
        body: const TabBarView(
          //stop swiping
          physics: NeverScrollableScrollPhysics(),
          children: [
            Scaffold(
              backgroundColor: backg2,
              body: Center(
                child: Text("Timetable"),
              ),
            ),
            Documents(),
            Scaffold(
              backgroundColor: backg2,
              body: Center(
                child: Text("Messages"),
              ),
            ),
            Notifications(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: const TabBar(
            unselectedLabelColor: Colors.black54,
            labelColor: mainColor,
            labelStyle: TextStyle(
                fontSize: 10), // reduce font size of selected tab label
            unselectedLabelStyle: TextStyle(
                fontSize: 10), // reduce font size of unselected tab label
            indicatorWeight: 1, // reduce height of selected tab indicator
            indicatorPadding: EdgeInsets.all(5),
            tabs: [
              Tab(
                icon: Icon(Icons.calendar_month),
                text: 'Timetable',
              ),
              Tab(
                icon: Icon(Icons.work),
                text: 'Documents',
              ),
              Tab(icon: Icon(Icons.question_answer), text: 'Messages'),
              Tab(
                icon: Icon(Icons.notifications),
                text: 'Notifications',
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
