import 'package:flutter/material.dart';
import 'package:se2/ui/theme.dart';

import '../../services/auth.dart';

class NavBar extends StatelessWidget {
  static final AuthService _auth = AuthService();
  String userEmail = _auth.getEmail()!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('SchoolEase',
                style: TextStyle(
                  color: textColor1,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )),
            accountEmail: Text(userEmail,
                style: TextStyle(
                  color: textColor2,
                )),
            otherAccountsPictures: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.verified,
                  color: Colors.blue,
                ),
              ),
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: backg1,
              child: ClipRect(
                child: Image.asset(
                  //change this to a schoolease logo
                  'assets/images/logoo.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: backg1,
            ),
          ),
          ListTile(
            textColor: textColor1,
            iconColor: textColor1,
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () async {
              await _auth.signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
