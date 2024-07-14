import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:sentinel/helpers/user_repo.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/models/user_data.dart';
import 'package:sentinel/screens/about_page.dart';
import 'package:sentinel/screens/content/adult_story/a_story_select_page.dart';
import 'package:sentinel/screens/register_verification_page.dart';
import 'package:toastification/toastification.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> signOut() async {
    await FirebaseAuthServices().signOut();
  }

  Future<void> checkVerificationStatus() async {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified == false){
      toastification.show(
          context: context,
          title: const Text("Error!", style: TextStyle(fontWeight: FontWeight.bold)),
          autoCloseDuration: const Duration(seconds: 10),
          description: const Text("Cuenta no verificada, por favor seguir los pasos para activarla.", style: TextStyle(fontWeight: FontWeight.bold),),
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored
      );
      Navigator.pushReplacement(
          context,
          PageTransition(
            child: const RegisterVerificationPage(),
            type: PageTransitionType.fade,
          )
      );
    } else {
      return;
    }
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }





  var age;

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkVerificationStatus();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        title: const Text("Menú Principal", textAlign: TextAlign.center, style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: null,

      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
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
                    heightPercentages: [-0.3, 0.86]),
                size: Size(MediaQuery.sizeOf(context).height, MediaQuery.sizeOf(context).width),
                backgroundColor: const Color(0xFFFFFB8D),
                waveFrequency: 1,
                waveAmplitude: 1,
                wavePhase: 1000,

              ),
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: 80),
              // Botones en azul
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: MyButton(
                        outlineButtonColor: Colors.white        ,
                        buttonIcon: Icons.play_circle,
                        buttonIconSize: 130,
                        onTap: () {
                          // Verificar edad aqui


                          if (age > 7) {
                            Navigator.pushReplacement(context, PageTransition(child: const AdultStorySelectPage(), type: PageTransitionType.bottomToTop,));
                          } if (age > 18) {
                            Navigator.pushReplacement(context, PageTransition(child: const AdultStorySelectPage(), type: PageTransitionType.bottomToTop,));
                          } else {
                            toastification.show(
                                context: context,
                                title: const Text("Error!", style: TextStyle(fontWeight: FontWeight.bold)),
                                autoCloseDuration: const Duration(seconds: 10),
                                description: const Text("Creo que tu edad no es la adecuada para esta aplicación, por favor sal.", style: TextStyle(fontWeight: FontWeight.bold),),
                                type: ToastificationType.error,
                                style: ToastificationStyle.flatColored
                            );
                          }

                        },
                        insertText: "Entrar",
                        textSize: 26,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 130),
              // Botones en amarillo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 140,
                        // OPCIONES
                        child: MyButton(
                            buttonIcon: Icons.settings,
                            onTap: () => {
                            toastification.show(
                            context: context,
                            title: const Text("Mantenimiento", style: TextStyle(fontWeight: FontWeight.bold)),
                            autoCloseDuration: const Duration(seconds: 10),
                            description: const Text("Todavía no hay nada que hacer una opcion, pero pronto lo habrá, es bueno tener opciones. :)", style: TextStyle(fontWeight: FontWeight.bold),),
                            type: ToastificationType.info,
                            style: ToastificationStyle.flatColored
                            )
                            },
                            insertText: "Opciones"
                        ),
                      ),
                      const SizedBox(width: 1),

                    ],
                  ),
                  const SizedBox(width: 1,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      const SizedBox(height: 1),
                      SizedBox(
                        height: 140,
                        width: 110,
                        child: MyButton(
                            onTap: () => {
                            Navigator.push(context, PageTransition(child: const AboutPage(), type: PageTransitionType.bottomToTop,))
                            },
                            insertText: "Acerca De"
                        ),
                      ),


                    ],
                  ),
                  //
                  const SizedBox(width: 1),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 140,
                        child: MyButton(
                            buttonIcon: Icons.logout_outlined,
                            buttonColor: Colors.red,
                            onTap: () => { signOut() },
                            insertText: "Cerrar\nSesión"
                        ),
                      ),
                      const SizedBox(width: 1.5),

                    ],
                  ),

                ],
              ),
              const SizedBox(height: 10,),

              FutureBuilder(
                  future: UserRepo().getUserDetails(FirebaseAuthServices().currentUser!.uid),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        UserData userData = snapshot.data as UserData;
                        age = DateTime.now().year - DateTime.parse(userData.fechaNac).year;
                        return Text("Bienvenido, ${userData.nombre}!", softWrap: true, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), );
                      } else {
                        return const CircularProgressIndicator();
                        //return Text(snapshot.error.toString());
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
              )
                      // UserRepo().getUserDetails(FirebaseAuthServices().currentUser!.uid.toString()).toString()
            ],
          ),
      ]
      ),
    );
  }
}
