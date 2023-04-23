import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';

class Check {
  static Future<bool> isTeacher() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(user.uid)
        .get();
    return doc.exists;
  }
}
