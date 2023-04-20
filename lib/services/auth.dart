import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se2/models/user.dart';
import 'package:se2/services/database.dart';
class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  String? getEmail() {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    return user?.email;
  }
  //create user obj based on firebase user
  Users? _userFromFirebaseUser(User? user){
    if (user !=null) {
      return Users(uid: user.uid);
    } else {
      return null;
    }
  }
  //auth change user stream
  Stream<Users?> get user{
    return _auth.authStateChanges()
    .map(_userFromFirebaseUser);
  }
  //sign in annon
  Future signInAnon() async{
    try{
      UserCredential result=await _auth.signInAnonymously();
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in email and password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
    Future signInWithEmailAndPasswordTeacher(BuildContext context,String email,String password) async {
  try{
    UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user=result.user;
    
    List<QueryDocumentSnapshot<Map<String, dynamic>>> teachers = await getTeachers();
    bool isTeacher = false;
    for (var teacher in teachers) {
      if (teacher.data()['email'] == email) {
        isTeacher = true;
        break;
      }
    }
    print(isTeacher);
    if (isTeacher) {
      return _userFromFirebaseUser(user);
    } else {
      await _auth.signOut();
      return null;
    }
  } catch(e){
    print(e.toString());
    return null;
  }
}

  //function to get the teachers from the database
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getTeachers() async {
  QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('teachers').get();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> teachers =
      snapshot.docs.toList();
  return teachers;
}
  //register email and password
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future registerWithEmailAndPasswordTeacher(String email,String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      //await saveUser(user!);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future<void> saveUser(User user)async{
    await FirebaseFirestore.instance.collection('teachers').doc(user.uid).set({
        'email':user.email,
        'uid':user.uid,
      });
  }
  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}