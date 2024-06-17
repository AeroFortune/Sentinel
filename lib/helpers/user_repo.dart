
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sentinel/models/user_data.dart';

class UserRepo extends GetxController {

  static UserRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<UserData> getUserDetails(String uid) async {

    final snapshot = await _db.collection("users").where("uid", isEqualTo: uid).get();
    final userData = snapshot.docs.map((e) => UserData.fromSnapshot(e)).single;
    return userData;


  }


}