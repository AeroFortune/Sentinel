import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:sentinel/helpers/user_repo.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/models/user_data.dart';
import 'package:sentinel/screens/content/adult_story/content_A_introduction_page.dart';
import 'package:sentinel/screens/login_page.dart';
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

  var age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        title: const Text("Menú Principal", textAlign: TextAlign.center, style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
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
          Column(
            children: <Widget>[
              const SizedBox(height: 50),
              // Botones en azul
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: MyButton(
                        outlineButtonColor: Colors.white        ,
                        buttonIcon: Icons.play_circle,
                        buttonIconSize: 90,
                        onTap: () => {
                          // Verificar edad aqui
                          if (age < 18) {
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //       child: KCIntroductionPage(),
                            //       type: PageTransitionType.bottomToTop,
                            //     )
                            // )
                            print("Llevar al usuario a pantalla de niños")
                          } else {
                            Navigator.push(
                                context,
                                PageTransition(
                                  child: ACIntroductionPage(),
                                  type: PageTransitionType.bottomToTop,
                                )
                            )
                          }

                        },
                        insertText: "Empezar",
                        textSize: 30,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 180),
              // Botones en amarillo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 89,
                        height: 140,
                        // OPCIONES
                        child: MyButton(
                            buttonIcon: Icons.settings,
                            onTap: () => {  },
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
                      MyButton(
                          onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())) },
                          insertText: "Acerca De"
                      ),
                      const SizedBox(height: 1),
                      MyButton(
                          buttonIcon: Icons.group,
                          onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())) },
                          insertText: "Créditos"
                      )
                    ],
                  ),
                  //
                  const SizedBox(width: 1),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 89,
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

                        return Text("Bienvenido, ${userData.nombre}! Y de edad de $age", softWrap: true, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                      } else {
                        return Text(snapshot.error.toString());
                      }
                    } else {
                      return Text(snapshot.error.toString());
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
