import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {

  final String? id;
  final String email;
  final String fechaNac;
  final String nombre;
  final String uid;


  UserData({this.id, required this.uid, required this.nombre, required this.email, required this.fechaNac});

  toJson(){
    return {
      "uid": uid,
      "nombre": nombre,
      "email": email,
      "fechaNac": fechaNac
    };
  }

  factory UserData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){

    final data = document.data()!;



    return UserData(
        id: document.id,
        email: data["email"],
        fechaNac: data["fechaNac"],
        nombre: data["nombre"],
        uid: data["uid"]
    );
    
  }

}