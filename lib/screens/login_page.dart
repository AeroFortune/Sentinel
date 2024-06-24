
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentinel/models/generic_inputs/my_textfield.dart';
import 'package:sentinel/models/showcase_widget.dart';
import 'package:sentinel/screens/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:toastification/toastification.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter/scheduler.dart';

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



  Future<void> signInWithEmailAndPassword() async {
    try {


      await FirebaseAuthServices().signInWithEmailAndPassword(
          context: context,
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim()
      );

      // Verificar AQUI si el usuario esta verificado -- Si esto no sirve, probar en homepage


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



  Future<void> getShowcaseStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final showcaseDone = prefs.getBool("login_showcase_is_passed") ?? false;

    if (showcaseDone == false){
      ShowCaseWidget.of(context).startShowCase([_zeroLogin, _oneLogin, _twoLogin, _threeLogin]);
      prefs.setBool("login_showcase_is_passed", true);
    }
  }

  static final GlobalKey _zeroLogin = GlobalKey();
  static final GlobalKey _oneLogin = GlobalKey();
  static final GlobalKey _twoLogin = GlobalKey();
  static final GlobalKey _threeLogin = GlobalKey();
  static final GlobalKey _fourLogin = GlobalKey();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () => WidgetsBinding.instance.addPostFrameCallback((_) {
      getShowcaseStatus();
    }));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    Future.delayed(Duration.zero, () => WidgetsBinding.instance.addPostFrameCallback((_) {
      getShowcaseStatus();
    }));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFFB8D),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF044389),
        actions: [
          CustomShowcaseWidget(
              globalKey: _fourLogin,
              description: "Si te perdiste o necesitas que te diga esto otra vez, solo presiona aqui!",
              child: IconButton(
                  onPressed: () => ShowCaseWidget.of(context).startShowCase([
                    _LoginPageState._zeroLogin,
                    _LoginPageState._oneLogin,
                    _LoginPageState._twoLogin,
                    _LoginPageState._threeLogin]),
                  icon: Icon(Icons.help), color: Colors.white))
        ],
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
                  heightPercentages: [-0.3, 0.36]),
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  CustomShowcaseWidget(
                      globalKey: _LoginPageState._zeroLogin,
                      title: "Bienvenido!",
                      description: "Hola, soy Will, woof! Para empezar, te estaré mostrando brevemente varias partes de esta pantalla!",
                      child: const Image(
                        image: AssetImage('assets/ssi_logo.png'),
                        width: 130,
                      ),),

                  const Text("Sentinel", textAlign: TextAlign.center, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white), ),
                  const Text("Bienvenido, por favor inicia sesión.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), ),
                  const SizedBox(height: 10,),

                  CustomShowcaseWidget(
                    title: "Datos de sesión",
                    globalKey: _LoginPageState._oneLogin,
                    description: "Bienvenido a la aplicación! Si previamente ya tenias una cuenta, por favor ingresa los datos.",
                    child: Container(
                      child: SentinelTextfield(hintText: "Usuario", obscureText: false, icon: Icons.person, controller: _controllerEmail,
                        suffixButton: IconButton(
                        onPressed: _controllerEmail.clear,
                        icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  SentinelTextfield(hintText: "Contraseña", obscureText: true, icon: Icons.key, controller: _controllerPassword,
                    suffixButton: IconButton(
                      onPressed: _controllerPassword.clear,
                      icon: const Icon(Icons.clear),
                    ),),

                  const SizedBox(height: 10,),

                  CustomShowcaseWidget(
                    globalKey: _LoginPageState._twoLogin,
                    description: "Al ingresar tus datos, presiona en inicia sesión.",
                    child: SizedBox(
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
                  ),

                  const SizedBox(height: 10,),


                  CustomShowcaseWidget(
                    globalKey: _LoginPageState._threeLogin,
                    description: "Si no tienes cuenta, presiona aqui!",
                    child: SizedBox(
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
                                child: ShowCaseWidget(builder: (context) => const RegisterPage()),
                                type: PageTransitionType.fade,
                              )
                          );
                        },
                        insertText: "¿No tienes cuenta?",
                      ),
                    ),
                  ),

                ],
            )
            ),
                    ),

      ]
      ),
    );

    
    
  }
}
