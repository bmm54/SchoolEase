import 'package:flutter/material.dart';
import 'package:se2/screens/home/pages/documents.dart';
import 'package:se2/screens/home/pages/notifications.dart';
import 'package:se2/ui/theme.dart';

import 'navbar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: backg2,
        appBar: AppBar(
          iconTheme: IconThemeData(color: textColor1),
          backgroundColor: backg1,
          elevation: 0.0,
          title: Text(
            "Home Page",
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
            Scaffold(
              backgroundColor: backg2,
              body: Center(
                child: Text("Absence"),
              ),
            ),
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
              Tab(
                icon: Icon(Icons.schedule),
                text: 'Absence',
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}

/*Scaffold(
      backgroundColor: backg1,
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor1),
        backgroundColor: backg2,
        elevation: 0.0,
        title: const Text("Home Page"),
      ),
      drawer: NavBar(),
    );*/

/*
import 'package:flutter/material.dart';
//DateTime get _now => DateTime.now();
class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: const TabBarView(
          children: [
            Center(

            ),
            Center(
              child: Text('Documents'),
            ),
            Center(
              child: Text('Messages'),
            ),
            Center(
              child: Text('Notifications'),
            ),
            Center(
              child: Text('Absence'),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: const TabBar(
            unselectedLabelColor: Colors.black54,
            labelColor: Colors.cyan,
            tabs: [
              Tab(
                icon: Icon(Icons.calendar_month),
                text: 'Timetable',
              ),
              Tab(
                icon: Icon(Icons.work),
                text: 'Documents',
              ),
              Tab(
                icon: Icon(Icons.question_answer),
                text: 'Messages'
              ),
              Tab(
                icon: Icon(Icons.notifications),
                text: 'Notifications',
              ),
              Tab(
                icon: Icon(Icons.schedule),
                text: 'Absence',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */
