import 'package:flutter/material.dart';
import 'package:se2/screens/home/pages/tbas/doc/cour.dart';

import '../../../ui/theme.dart';
class Documents extends StatelessWidget {
  const Documents({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.95;
    return Scaffold(
      backgroundColor: backg2,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
           Container(
            height: 70,
            width:MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 8,bottom: 20,left: 10,right: 10),
            color: backg1,
             child: Container(
              padding: const EdgeInsets.all(3),
              height: 40, //adjust the height as per your requirement
              width: screenWidth,
                     decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), //adjust the border radius as per your requirement
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
                  Tab(text: "Cour",),
                  Tab(text: "TP",),
                  Tab(text: "TD",),
                ],
                //style
                labelColor: Colors.white,
                unselectedLabelColor: textColor1,
                //backgroundcolor
                indicatorColor: mainColor,
                labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
              ),),
           ),
            const Expanded(
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
