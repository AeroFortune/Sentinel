import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/home_page.dart';
import 'package:sentinel/screens/login_page.dart';
import 'package:toastification/toastification.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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

  late DateTime fecha = DateTime.now();

  // Widgets y Metodos

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000, 1, 1),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)
    );

    setState(() {
      fecha = picked!;
      _controllerDate.text = picked.toString().split(" ")[0];
    });
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

      if (_controllerPassword.text.trim() != _controllerVerifyPassword.text.trim()) {
        toastification.show(
            context: context,
            title: const Text("Error al registrarse!"),
            description: const Text("Las contraseñas no coinciden."),
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            autoCloseDuration: const Duration(seconds: 10)
        );
        return;
      } if (_controllerPassword.text.trim() == "" || _controllerVerifyPassword.text.trim() == "" || _controllerDate.text.trim() == "" || _controllerEmail.text.trim() == "" || _controllerName.text.trim() == ""){
        toastification.show(
            context: context,
            title: const Text("Error al registrarse!", style: TextStyle(fontWeight: FontWeight.bold)),
            autoCloseDuration: const Duration(seconds: 10),
            description: const Text("Uno o más campos no han sido llenados. \nPor favor llenarlos e re-intentar.", style: TextStyle(fontWeight: FontWeight.bold),),
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored
        );
        return;
      } else {
        await FirebaseAuthServices().createUserWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim(),
        );
        addUserDetails(
            FirebaseAuth.instance.currentUser!.uid,
            _controllerName.text.trim(),
            _controllerEmail.text.trim(),
            _controllerDate.text.trim()
        );
        toastification.show(
            context: context,
            title: const Text("Exito!"),
            description: const Text("Te has registrado con éxito. Bienvenido!"),
            type: ToastificationType.success,
            style: ToastificationStyle.flatColored,
            autoCloseDuration: const Duration(seconds: 10)
        );
        Navigator.pushReplacement(
            context,
            PageTransition(
              child: const HomePage(),
              type: PageTransitionType.fade,
            )
        );
      }

    } on FirebaseAuthException catch (e) {
      setState(() {



          // Agregar validación de contraseñas

        if (e.code == "weak-password"){
          toastification.show(
              context: context,
              title: const Text("Error al registrarse!", style: TextStyle(fontWeight: FontWeight.bold)),
              autoCloseDuration: const Duration(seconds: 10),
              description: const Text("Contraseña debil! Por favor introducir una contraseña mayor a 6 caracteres.", style: TextStyle(fontWeight: FontWeight.bold),),
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored
          );
          return;
        } if (e.code == "email-already-in-use") {
          toastification.show(
              context: context,
              title: const Text("Error al registrarse!", style: TextStyle(fontWeight: FontWeight.bold)),
              autoCloseDuration: const Duration(seconds: 10),
              description: const Text("Este e-mail no puede ser usado, por favor usar otro.", style: TextStyle(fontWeight: FontWeight.bold),),
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored
          );
          return;
        } if (e.code == "invalid-email") {
          toastification.show(
              context: context,
              title: const Text("Error al registrarse!", style: TextStyle(fontWeight: FontWeight.bold)),
              autoCloseDuration: const Duration(seconds: 10),
              description: const Text(
                "Este e-mail no es valido, por favor insertar otro.",
                style: TextStyle(fontWeight: FontWeight.bold),),
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored
          );
          return;
        }

        toastification.show(
            context: context,
            title: const Text("Error al registrarse!"),
            autoCloseDuration: const Duration(seconds: 10),
            description: Text("Error desconocido. Por favor contactar a un administrador. ${e.code.toString()}", style: const TextStyle(fontWeight: FontWeight.bold),),
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored
        );
        return;
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return const AlertDialog(
        //         title: Text("Error!"),
        //         content: Text("Algo ha salido mal, por favor reintentar en otra ocasión. Presiona fuera de esta pantalla para continuar."),
        //       );
        //     } );
      });
    }

  }

  bool spoilerPass = true;
  bool spoilerPassC = true;

  // Main

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFFB8D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),

        centerTitle: true,
        //title: Text("Registro de Cuenta", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: const Color(0xFF044389),
            child: WaveWidget(
              config: CustomConfig(
                  colors: [const Color(0xFF044389), const Color(0xFFFFFB8D)],
                  durations: [5000, 5000],
                  heightPercentages: [-0.3, 0.40]),
              size: const Size.fromHeight(double.infinity),
              backgroundColor: const Color(0xFFFFFB8D),
              waveFrequency: 1,
              waveAmplitude: 1,
              wavePhase: 1000,

            ),
          ),
          SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Registrarse", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white), ),
                  const SizedBox(height: 10,),
                  SentinelTextfield(hintText: "Nombre", obscureText: false, icon: Icons.font_download, controller: _controllerName,
                    suffixButton: IconButton(
                    onPressed: _controllerName.clear,
                    icon: const Icon(Icons.clear),
                  ),),
                  SentinelTextfield(hintText: "Email", obscureText: false, icon: Icons.person, controller: _controllerEmail,
                    suffixButton: IconButton(
                    onPressed: _controllerEmail.clear,
                    icon: const Icon(Icons.clear),
                  ),),
                  SentinelTextfield(hintText: "Contraseña", obscureText: spoilerPass, icon: Icons.key, controller: _controllerPassword,
                    suffixButton: IconButton(
                        onPressed: () {
                          setState(() {
                            spoilerPass = !spoilerPass;
                          });
                        },

                        icon: const Icon(Icons.remove_red_eye),
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
                        icon: const Icon(Icons.remove_red_eye),
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
                      icon: const Icon(Icons.clear),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  SizedBox(
                    width: 322,
                    child: MyButton(
                        direction: Axis.horizontal,
                        buttonIcon: Icons.app_registration,
                        buttonIconSize: 40,
                        textSize: 24,
                        onTap: () {
                          createUserWithEmailAndPassword();
                        },
                        insertText: "Registrarse",
                    ),
                  ),
                  const SizedBox(height: 3,),
                  SizedBox(
                    width: 322,
                    child: MyButton(
                      buttonIcon: Icons.supervised_user_circle_outlined,
                      buttonIconSize: 40,
                      textSize: 24,
                      direction: Axis.horizontal,
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const LoginPage(),
                              type: PageTransitionType.fade,
                            )
                        );
                      },
                      insertText: "¿Ya tienes cuenta?",
                    ),
                  )

                ],
              )
          ),
        ),
        ]
      ),
    );
  }
}
