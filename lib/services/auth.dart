import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se2/models/user.dart';
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