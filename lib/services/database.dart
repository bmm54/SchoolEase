import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
/*
class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('usernames');

  Future updateUserData(String name) async {  // this is the function that has to edit the username
    return await userCollection.doc(uid).set({
      'name': name,
    });
  }

  Future uploadUserInfo(userMap) async {  // this function adds username and email to firestore
    return await userCollection.doc(uid).set(userMap);
  }

  List<Username> _usernameListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Username(
        name: doc.data()['name'] ?? '',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
    );
  }

  Stream<List<Username>> get usernames {
    return userCollection.snapshots().map(_usernameListFromSnapshot);
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}*/