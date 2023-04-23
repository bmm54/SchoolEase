import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';

class Check {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<bool> isTeacher() async {
    //check if current user is in teacher collection
    final User? user = FirebaseAuth.instance.currentUser;
    var collectionRef = FirebaseFirestore.instance.collection('teachers');
    var query = collectionRef.where('email', isEqualTo: user?.email).limit(1);
    var querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      // Access the document data using documentSnapshot.data()
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> isStudent() async {
    //check if current user is in teacher collection
    final User? user = FirebaseAuth.instance.currentUser;
    var collectionRef = FirebaseFirestore.instance.collection('students');
    var query = collectionRef.where('email', isEqualTo: user?.email).limit(1);
    var querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      // Access the document data using documentSnapshot.data()
      return true;
    } else {
      return false;
    }
  }
}
