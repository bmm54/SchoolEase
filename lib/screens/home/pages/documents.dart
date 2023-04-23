import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se2/screens/home/pages/tbas/doc/cour.dart';

import '../../../services/auth.dart';
import '../../../ui/theme.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();

  getSelectedClass() {
    return selectedClass;
  }
}

String? selectedClass;

class _DocumentsState extends State<Documents> {
  static final AuthService _auth = AuthService();
  String currentUserUid = _auth.getUid()!;
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
              height: 150,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              color: backg1,
              child: Column(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('teachers')
                        .doc(currentUserUid) // Assuming the current user's UID is stored in a variable called `currentUser.uid`
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      List<DropdownMenuItem<String>> items = [];
                      List<dynamic> classesList =
                          snapshot.data!.get('classes');
                      for (int i = 0; i < classesList.length; i++) {
                        final className = classesList[i];
                        items.add(DropdownMenuItem(
                          value: className,
                          child: Text(className),
                        ));
                      }
                      return DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: dropDownDeco,
                        value: null,
                        items: items,
                        onChanged: (String? selected) {
                          // Do something with the selected class
                          setState(() {
                            selectedClass = selected;
                            print(selectedClass);
                          });
                        },
                        hint: Text('Select a class'),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
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
                          text: "Cour",
                        ),
                        Tab(
                          text: "TP",
                        ),
                        Tab(
                          text: "TD",
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
                ],
              ),
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
