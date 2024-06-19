
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentinel/models/generic_inputs/my_textfield.dart';
import 'package:sentinel/screens/register_page.dart';
import 'package:toastification/toastification.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim()
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (_controllerPassword.text.trim() == "" || _controllerEmail.text.trim() == "" ){
          toastification.show(
              context: context,
              title: const Text("Error al iniciar sesión!", style: TextStyle(fontWeight: FontWeight.bold)),
              autoCloseDuration: const Duration(seconds: 10),
              description: const Text("Uno o más campos no han sido llenados. \nPor favor llenarlos e re-intentar.", style: TextStyle(fontWeight: FontWeight.bold),),
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored
          );
          return;
        } if (e.code == "invalid-credential") {
          toastification.show(
              context: context,
              title: const Text("Error al iniciar sesión!", style: TextStyle(fontWeight: FontWeight.bold)),
              autoCloseDuration: const Duration(seconds: 10),
              description: const Text("Credenciales incorrectas, por favor intentar otra vez.", style: TextStyle(fontWeight: FontWeight.bold),),
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored
          );
          return;
        } if (e.code == "invalid-email") {
          toastification.show(
              context: context,
              title: const Text("Error al iniciar sesión!",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              autoCloseDuration: const Duration(seconds: 10),
              description: const Text("El correo introducido no es valido.",
                style: TextStyle(fontWeight: FontWeight.bold),),
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored
          );
          return;
        } else {
          toastification.show(
              context: context,
              title: const Text("Error al inciar sesión!"),
              autoCloseDuration: const Duration(seconds: 10),
              description: Text("Error desconocido. Por favor contactar a un administrador. ${e.code.toString()}", style: const TextStyle(fontWeight: FontWeight.bold),),
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored
          );
          return;
        }
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
        child: const Text('Iniciar Sesión', style: TextStyle( fontSize: 24),),
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
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFFB8D),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF044389),
      ),
      body: Stack(
        children: [
          // Waves background
          Container(
            height: double.infinity,
            color: const Color(0xFF044389),
            child: WaveWidget(
              config: CustomConfig(
                  colors: [const Color(0xFF044389), const Color(0xFFFFFB8D)],
                  durations: [5000, 5000],
                  heightPercentages: [-0.3, 0.30]),
              size: const Size.fromHeight(double.infinity),
              backgroundColor: const Color(0xFFFFFB8D),
              waveFrequency: 1,
              waveAmplitude: 1,
              wavePhase: 1000,

            ),
          ),
          // Contenido
          SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Iniciar Sesión", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white), ),
                const SizedBox(height: 50,),
                SentinelTextfield(hintText: "Usuario", obscureText: false, icon: Icons.person, controller: _controllerEmail,
                  suffixButton: IconButton(
                  onPressed: _controllerEmail.clear,
                  icon: const Icon(Icons.clear),
                  ),
                ),
                SentinelTextfield(hintText: "Contraseña", obscureText: true, icon: Icons.key, controller: _controllerPassword,
                  suffixButton: IconButton(
                    onPressed: _controllerPassword.clear,
                    icon: const Icon(Icons.clear),
                  ),),

                const SizedBox(height: 10,),
                SizedBox(
                  width: 322,
                  child: MyButton(
                    buttonIcon: Icons.login,
                    buttonIconSize: 40,
                    textSize: 24,
                    direction: Axis.horizontal,
                    onTap: () {
                      signInWithEmailAndPassword();
                    },
                    insertText: "Iniciar Sesión",
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 322,
                  child: MyButton(
                    buttonIcon: Icons.add_reaction_outlined,
                    buttonIconSize: 40,
                    textSize: 24,
                    direction: Axis.horizontal,
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: const RegisterPage(),
                            type: PageTransitionType.fade,
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
      ]
      ),
    );
    
    
    
  }
}
