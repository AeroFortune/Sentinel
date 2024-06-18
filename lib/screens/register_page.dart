import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/login_page.dart';

import '../helpers/auth.dart';
import '../models/generic_inputs/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerVerifyPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  // Widgets y Metodos

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)
    );

    if (picked != null){
      setState(() {
        _controllerDate.text = picked.toString().split(" ")[0];
      });
    }

  }

  Future<void> addUserDetails(String uid, String nombre, String email, String fechaNac) async {
    FirebaseFirestore.instance.collection('users').add({
      'fechaNac': fechaNac,
      'email': email,
      'nombre': nombre,
      'uid': uid
    });
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      if (_controllerPassword.text.trim() !=
          _controllerVerifyPassword.text.trim()) {
        Fluttertoast.showToast(
            msg: "Las contraseñas no coinciden, intentelo otra vez.",
            toastLength: Toast.LENGTH_LONG,
            fontSize: 23);
      }
      await FirebaseAuthServices().createUserWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
      addUserDetails(
          FirebaseAuth.instance.currentUser!.uid,
          _controllerName.text.trim(),
          _controllerEmail.text.trim(),
          _controllerDate.text.trim()
      ).whenComplete(
            () =>
        const SnackBar(
            content: Text(
                "Se ha registrado la cuenta con éxito! Por favor continua con los pasos indicados.")),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        Fluttertoast.showToast(
            msg: "Algo ha salido mal!",
            toastLength: Toast.LENGTH_LONG);
        var errorMessage = e.message;
      });
    }
  }

  bool spoilerPass = true;
  bool spoilerPassC = true;

  // Main

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFB8D),
      appBar: AppBar(
        backgroundColor: Color(0xFF044389),
        leading: const BackButton(
            color: Colors.white
        ),
        centerTitle: true,
        title: Text("Registro de Cuenta", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AnimatedSwitcher(
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            duration: const Duration(milliseconds: 900),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Registrarse", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), ),
                    const SizedBox(height: 10,),
                    SentinelTextfield(hintText: "Nombre", obscureText: false, icon: Icons.font_download, controller: _controllerName,
                      suffixButton: IconButton(
                      onPressed: _controllerName.clear,
                      icon: Icon(Icons.clear),
                    ),),
                    SentinelTextfield(hintText: "Email", obscureText: false, icon: Icons.person, controller: _controllerEmail,
                      suffixButton: IconButton(
                      onPressed: _controllerEmail.clear,
                      icon: Icon(Icons.clear),
                    ),),
                    SentinelTextfield(hintText: "Contraseña", obscureText: spoilerPass, icon: Icons.key, controller: _controllerPassword,
                      suffixButton: IconButton(
                          onPressed: () {
                            setState(() {
                              spoilerPass = !spoilerPass;
                            });
                          },

                          icon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                    SentinelTextfield(
                        hintText: "Verificar contraseña",
                        obscureText: spoilerPassC,
                        icon: Icons.vpn_key_outlined,
                        controller: _controllerVerifyPassword,
                        suffixButton: IconButton(
                          onPressed: () {
                            setState(() {
                              spoilerPassC = !spoilerPassC;
                            });
                          },
                          icon: Icon(Icons.remove_red_eye),
                        ),
                    ),
                    SentinelTextfield(
                      hintText: "Fecha de nacimiento",
                      obscureText: false,
                      icon: Icons.font_download,
                      controller: _controllerDate,
                      readOnly: true,
                      onTap: (){
                        _selectDate();
                      },
                      suffixButton: IconButton(
                        onPressed: _controllerDate.clear,
                        icon: Icon(Icons.clear),
                      ),
                    ),

                    const SizedBox(height: 20,),

                    Container(
                      width: 322,
                      child: MyButton(
                          direction: Axis.horizontal,
                          buttonIcon: Icons.app_registration,
                          buttonIconSize: 40,
                          textSize: 28,
                          onTap: () {

                            // Agregar verificaciones de campos

                            createUserWithEmailAndPassword();
                          },
                          insertText: "Registrarse",
                      ),
                    ),
                    const SizedBox(height: 3,),

                  ],
                )
            ),
        ),
      ),
    );
  }
}
