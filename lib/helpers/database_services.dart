import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices{

  final String uid, name, email, fechaNac;

  DatabaseServices({
    required this.uid,
    required this.name,
    required this.email,
    required this.fechaNac
  });

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void getInstanceData() {

  }


  CollectionReference user = FirebaseFirestore.instance.collection('users');






}