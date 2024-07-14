
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/home_page.dart';
import 'package:toastification/toastification.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../helpers/auth.dart';

class RegisterVerificationPage extends StatefulWidget {
  const RegisterVerificationPage({super.key});

  @override
  State<RegisterVerificationPage> createState() => _RegisterVerificationPageState();
}

class _RegisterVerificationPageState extends State<RegisterVerificationPage> {


  void sendVerificationEmail(){

    try {
      FirebaseAuthServices().currentUser?.sendEmailVerification();
    } catch (e) {
      toastification.show(
            context: context,
            title: const Text("Error!", style: TextStyle(fontWeight: FontWeight.bold)),
            autoCloseDuration: const Duration(seconds: 10),
            description: const Text("Ha sucedido un error al enviar la verificación, por favor contactar a un administrador.", style: TextStyle(fontWeight: FontWeight.bold),),
            type: ToastificationType.success,
            style: ToastificationStyle.flatColored
        );
    }

  }

  late Timer _timer;

  void setTimerForAutoRedirect(){
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified){
        timer.cancel();
        toastification.show(
            context: context,
            title: const Text("Exito!", style: TextStyle(fontWeight: FontWeight.bold)),
            autoCloseDuration: const Duration(seconds: 10),
            description: const Text("La verificación se ha completado, bienvenido!", style: TextStyle(fontWeight: FontWeight.bold),),
            type: ToastificationType.success,
            style: ToastificationStyle.flatColored
        );
        Navigator.pushReplacement(
            context,
            PageTransition(
              child: const HomePage(),
              type: PageTransitionType.fade,
            )
        );
      }
    });
  }

  void manuallyCheckVerificationStatus(){
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;

    if (user!.emailVerified){
      toastification.show(
          context: context,
          title: const Text("Exito!", style: TextStyle(fontWeight: FontWeight.bold)),
          autoCloseDuration: const Duration(seconds: 10),
          description: const Text("La verificación se ha completado, bienvenido!", style: TextStyle(fontWeight: FontWeight.bold),),
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored
      );
      Navigator.push(
          context,
          PageTransition(
            child: const HomePage(),
            type: PageTransitionType.fade,
          )
      );
    } else {
      toastification.show(
        context: context,
        title: const Text("Verificación pendiente", style: TextStyle(fontWeight: FontWeight.bold)),
        autoCloseDuration: const Duration(seconds: 10),
        description: const Text("Tu correo electrónico aún no ha sido verificado. Por favor revisa tu bandeja de entrada.", style: TextStyle(fontWeight: FontWeight.bold)),
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
      );
    }
  }


  // Widgets y Metodo

  @override
  void initState() {
    // TODO: implement initState
    sendVerificationEmail();
    setTimerForAutoRedirect();
    super.initState();
  }


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
          // Background
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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Verificación de Cuenta", softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), ),
                  const SizedBox(height: 10,),
                  const Text("A continuación, hemos enviado un email a tu correo electronico. Por favor verificalo e ingresa al enlace para poder activar tu cuenta.",
                  softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  const Text("La pantalla se refrescará automáticamente cuando confirmes tu e-mail. De no ser así, presiona el siguiente botón para re-intentar la verificación manualmente.",
                      softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 150,),
                  SizedBox(
                    width: 250,
                    child: MyButton(
                        onTap: () => manuallyCheckVerificationStatus(),
                        insertText: "Re-intentar Verificación",
                      direction: Axis.horizontal,
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
