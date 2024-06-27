import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/login_page.dart';
import 'package:sentinel/screens/register_verification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:toastification/toastification.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'package:sentinel/models/showcase_widget.dart';
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
        lastDate: DateTime(2017)
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
            description: const Text("Te has registrado con éxito. Por favor lea los siguientes pasos."),
            type: ToastificationType.success,
            style: ToastificationStyle.flatColored,
            autoCloseDuration: const Duration(seconds: 10)
        );
        Navigator.push(
            context,
            PageTransition(
              child: const RegisterVerificationPage(),
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

  Future<void> getShowcaseStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final showcaseDone = prefs.getBool("register_showcase_is_passed") ?? false;

    if (showcaseDone == false){
      ShowCaseWidget.of(context).startShowCase([
        _zeroRegisterKey,
        _oneRegisterKey,
        _twoRegisterKey,
        _threeRegisterKey,
        _fourRegisterKey,
        _fiveRegisterKey,
        _sixRegisterKey,
        _sevenRegisterKey]);
      prefs.setBool("register_showcase_is_passed", true);
    }
  }

  bool spoilerPass = true;
  bool spoilerPassC = true;

  static final GlobalKey _zeroRegisterKey = GlobalKey();
  static final GlobalKey _oneRegisterKey = GlobalKey();
  static final GlobalKey _twoRegisterKey = GlobalKey();
  static final GlobalKey _threeRegisterKey = GlobalKey();
  static final GlobalKey _fourRegisterKey = GlobalKey();
  static final GlobalKey _fiveRegisterKey = GlobalKey();
  static final GlobalKey _sixRegisterKey = GlobalKey();
  static final GlobalKey _sevenRegisterKey = GlobalKey();
  static final GlobalKey _loopRegisterKey = GlobalKey();

  // Main

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () => WidgetsBinding.instance.addPostFrameCallback((_) {
      getShowcaseStatus();
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: const Color(0xFFFFFB8D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        centerTitle: true,
        actions: [
          CustomShowcaseWidget(
              globalKey: _RegisterPageState._loopRegisterKey,
              description: "Si te perdiste o necesitas que te diga esto otra vez, solo presiona aqui!",
              child: IconButton(
                  onPressed: () => ShowCaseWidget.of(context).startShowCase([
                    _RegisterPageState._zeroRegisterKey,
                    _RegisterPageState._oneRegisterKey,
                    _RegisterPageState._twoRegisterKey,
                    _RegisterPageState._threeRegisterKey,
                    _RegisterPageState._fourRegisterKey,
                    _RegisterPageState._fiveRegisterKey,
                    _RegisterPageState._sixRegisterKey,
                    _RegisterPageState._sevenRegisterKey,
                    _RegisterPageState._loopRegisterKey
                  ]),
                  icon: const Icon(Icons.help), color: Colors.white,))
        ],
        //title: Text("Registro de Cuenta", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              color: const Color(0xFF044389),
              child: WaveWidget(
                config: CustomConfig(
                    colors: [const Color(0xFF044389), const Color(0xFFFFFB8D)],
                    durations: [5000, 5000],
                    heightPercentages: [-0.3, 0.66]),
                size: Size(MediaQuery.sizeOf(context).height, MediaQuery.sizeOf(context).width),
                backgroundColor: const Color(0xFFFFFB8D),
                waveFrequency: 1,
                waveAmplitude: 1,
                wavePhase: 1000,

              ),
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

                  CustomShowcaseWidget(
                    globalKey:  _RegisterPageState._zeroRegisterKey,
                      description: "Esta es la pantalla de registro! Necesitaras crear una cuenta para acceder a las funciones principales, woof!",
                      child: const Text("Registrarse", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white), )
                  ),


                  const SizedBox(height: 10,),


                  CustomShowcaseWidget(
                    globalKey:  _RegisterPageState._oneRegisterKey,
                    description: "Deberas poner tu nombre aqui, woof!",
                    child: SentinelTextfield(hintText: "Nombre", obscureText: false, icon: Icons.person, controller: _controllerName,
                      suffixButton: IconButton(
                      onPressed: _controllerName.clear,
                      icon: const Icon(Icons.clear),
                    ),),
                  ),


                  CustomShowcaseWidget(
                    globalKey:  _RegisterPageState._twoRegisterKey,
                    description: "Después va tu email! Este es super importante ya que es lo que usaras para ingresar después, asi que recuerdalo bien! Woof!",
                    child: SentinelTextfield(hintText: "E-mail", obscureText: false, icon: Icons.mail, controller: _controllerEmail,
                      suffixButton: IconButton(
                      onPressed: _controllerEmail.clear,
                      icon: const Icon(Icons.clear),
                    ),),
                  ),


                  CustomShowcaseWidget(
                    globalKey:  _RegisterPageState._threeRegisterKey,
                    description: "Aqui va tu credencial principal, tu contraseña! Asegurate de hacerla muy segura! Woof!",
                    child: SentinelTextfield(hintText: "Contraseña", obscureText: spoilerPass, icon: Icons.key, controller: _controllerPassword,
                      suffixButton: CustomShowcaseWidget(
                        globalKey:  _RegisterPageState._fourRegisterKey,
                        description: "Y si quieres revisar que tu contraseña sea lo que escribiste, presiona aqui para revelarla! Cuidado alguien te mira, woof!",
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                spoilerPass = !spoilerPass;
                              });
                            },

                            icon: const Icon(Icons.remove_red_eye),
                        ),
                      ),
                    ),
                  ),


                  CustomShowcaseWidget(
                    globalKey:  _RegisterPageState._fiveRegisterKey,
                    description: "Es importante que verifiques tu contraseña! Esto para saber si las estas escribiendo bien! Woof!",
                    child: SentinelTextfield(
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
                  ),


                  CustomShowcaseWidget(
                    globalKey:  _RegisterPageState._sixRegisterKey,
                    description: "Finalmente, escoge tu fecha de nacimiento! Esto es importante, ya que afectará el contenido que veas! Escoge bien!",
                    child: SentinelTextfield(
                      hintText: "Fecha de nacimiento",
                      obscureText: false,
                      icon: Icons.date_range,
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
                  ),

                  const SizedBox(height: 20,),

                  CustomShowcaseWidget(
                    globalKey:  _RegisterPageState._sevenRegisterKey,
                    description: "Finalmente, presiona aqui para enviar tu solicitud de registro, woof!",
                    child: SizedBox(
                      width: 322,
                      child: MyButton(
                          direction: Axis.horizontal,
                          buttonIcon: Icons.app_registration,
                          buttonIconSize: 40,
                          textSize: 24,
                          onTap: () {

                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              title: "Advertencia",
                              text: "Asegurate que tus datos esten correctos. Tu fecha de nacimiento afectará el contenido que veas. Deseas continuar?",
                              confirmBtnColor: const Color(0xFF044389),
                              confirmBtnText: "Continuar",
                              cancelBtnText: "Cancelar",
                              onConfirmBtnTap: () => createUserWithEmailAndPassword()
                            );


                          },
                          insertText: "Registrarse",
                      ),
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
                              child: ShowCaseWidget(builder: (context) => const LoginPage()),
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
