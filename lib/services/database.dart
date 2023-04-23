import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  //upload a document function to firebase storage
  //takes in name of the class and create a folder className/documents/
  //if its a cour document, it will be stored in className/documents/cour
  //if its a tp document, it will be stored in className/documents/tp
  //if its a td document, it will be stored in className/documents/td
  ////fonction goes here
  //Future uploadDocument(String className, String documentType, String fileName, String filePath) async {
  //  final ref = FirebaseStorage.instance.ref().child('classes/$className/documents/$documentType/$fileName');
  //  await ref.putFile(filePath);
  //}
}
