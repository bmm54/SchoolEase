import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se2/models/user.dart';
import 'package:se2/screens/authenricate/choose.dart';
import 'package:se2/screens/home/home.dart';
import 'package:se2/screens/home/teacherHome.dart';
import 'package:se2/services/database.dart';

import '../screens/wrapper.dart';

//i want to change it to AuthTeacher but that would cause alot of mess
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isTeacher = false;
  bool isStudent = false;
  String role="Student";

  String? getEmail() {
    final User? user = _auth.currentUser;
    return user?.email;
  }
  String? getUid() {
    final User? user = _auth.currentUser;
    return user?.uid;
  }

  //create user obj based on firebase user
  Users? _userFromFirebaseUser(User? user) {
    if (user != null) {
      return Users(uid: user.uid, role: role);
    } else {
      return null;
    }
  }

  //auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future TeahcerSignIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      var collectionRef = FirebaseFirestore.instance.collection('teachers');
      var query = collectionRef.where('email', isEqualTo: email).limit(1);
      var querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        // Access the document data using documentSnapshot.data()
        isTeacher = true;
        role = "Teacher";
      }

      print("Teacher: $isTeacher");
      if (isTeacher) {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeacherHome(),
        ),
      );
        return _userFromFirebaseUser(user);
      } else {
        throw("You do not have permission to access this app as a teacher.");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email and password
  Future TeacherSignUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      isTeacher = true;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  /////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////Student////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  Future StudentSignIn(context,String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      var collectionRef = FirebaseFirestore.instance.collection('students');
      var query = collectionRef.where('email', isEqualTo: email).limit(1);
      var querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        // Access the document data using documentSnapshot.data()
        isStudent = true;
        role = "Student";
      }

      print("student : $isStudent");
      if (isStudent) {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
        return _userFromFirebaseUser(user);
      } else {
        throw("You do not have permission to access this app as a student.");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //register email and password
  Future StudentSignUp(String email,String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  //sign out
  Future signOut(context) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Choose(),
        ),
      );
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
