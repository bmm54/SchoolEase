import 'package:flutter/material.dart';
import 'package:se2/screens/home/pages/tbas/doc/cour.dart';

import '../../../ui/theme.dart';
class Documents extends StatelessWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backg2,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: const <Widget>[
            TabBar(
              tabs: [
                Tab(text: "Cour",),
                Tab(text: "TP",),
                Tab(text: "TD",),
              ],
              //style
              labelColor: textColor1,
              unselectedLabelColor: Colors.black26,
              //backgroundcolor
              indicatorColor: mainColor,
              labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  // Content for the "Cour" tab
                  Cour(),
                  // Content for the "TP" tab
                  Center(
                    child: Text('Content for the "TP" tab'),
                  ),
                  // Content for the "TD" tab
                  Center(
                    child: Text('Content for the "TD" tab'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
