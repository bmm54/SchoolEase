import 'package:flutter/material.dart';

import '../../../ui/theme.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backg2,
      body: DefaultTabController(
        length: 3,
        child: TabBar(tabs:
        [
          Tab(text: "Teacher",),
          Tab(text: "Admin\istration",),
          Tab(text: "Club",),
        ],
          //style
          labelColor: textColor1,
          unselectedLabelColor: Colors.black26,
          //backgroundcolor
          indicatorColor: mainColor,
          labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}