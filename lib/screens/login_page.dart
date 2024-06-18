
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentinel/models/generic_inputs/my_textfield.dart';
import 'package:sentinel/screens/register_page.dart';

import '../models/generic_inputs/my_button.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  // TODO: Probablemente separar registro en su propia pantalla? Si le puedo poner una animación a esta entonces no
  // TODO: Importa though.

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuthServices().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }


  Widget _title(){
    return const Text('Firebase Auth Test');
  }


  // quitar esto
  Widget _submitButton(){
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * .075,
      child: ElevatedButton(
        onPressed: signInWithEmailAndPassword, // estructurar esto para mostrar snackbars
        child: Text('Iniciar Sesión', style: const TextStyle( fontSize: 24),),
      ),
    );
  }

  Widget _loginOrRegisterButton(){
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * .075,
      child: ElevatedButton(
          onPressed: (){
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(isLogin ? 'No tienes cuenta?' : 'Ya tienes cuenta?', style: const TextStyle( fontSize: 24),)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFB8D),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF044389),
        title: Text("Menú Principal", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          duration: const Duration(milliseconds: 900),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Iniciar Sesión", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), ),
                const SizedBox(height: 10,),
                SentinelTextfield(hintText: "Usuario", obscureText: false, icon: Icons.person, controller: _controllerEmail,
                  suffixButton: IconButton(
                  onPressed: _controllerEmail.clear,
                  icon: Icon(Icons.clear),
                  ),
                ),
                SentinelTextfield(hintText: "Contraseña", obscureText: true, icon: Icons.key, controller: _controllerPassword,
                  suffixButton: IconButton(
                    onPressed: _controllerEmail.clear,
                    icon: Icon(Icons.clear),
                  ),),

                const SizedBox(height: 10,),
                Container(
                  width: 330,
                  child: MyButton(
                    direction: Axis.horizontal,
                    onTap: () {
                      signInWithEmailAndPassword();
                    },
                    insertText: "Registrarse",
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: 330,
                  child: MyButton(
                    direction: Axis.horizontal,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            child: RegisterPage(),
                            type: PageTransitionType.bottomToTop,
                          )
                      );
                    },
                    insertText: "¿No tienes cuenta?",
                  ),
                )
              ],
          )
          ),
          ),
      ),
    );
    
    
    
  }
}
