import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:sentinel/screens/content/adult_story/content_A_bad_ending_page.dart';
import 'package:sentinel/screens/content/adult_story/content_A_part4_intermission_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '../../../models/generic_inputs/my_button.dart';
import 'content_A_introduction_page.dart';

class ACSelectionPage3 extends StatelessWidget {
  const ACSelectionPage3({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFB8D),
        centerTitle: true,
        leading:  BackButton(
          color: Colors.black,
          onPressed: () {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                title: "Advertencia",
                text: "Estás seguro que deseas salir del juego? Perderás tu progreso!",
                confirmBtnColor: const Color(0xFF044389),
                confirmBtnText: "Continuar",
                cancelBtnText: "Cancelar",
                onConfirmBtnTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const ACIntroductionPage(),
                          type: PageTransitionType.fade
                      )
                  );
                }
            );

          },
        ),
        title: const Text("Historia", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      backgroundColor: const Color(0xFFFFFB8D),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              color: const Color(0xFFFFFB8D),
              child: WaveWidget(
                config: CustomConfig(
                    colors: [const Color(0xFFFFFB8D), const Color(0xFF044389)],
                    durations: [5000, 5000],
                    heightPercentages: [-0.3, 0.002]),
                size: Size(MediaQuery.sizeOf(context).height, MediaQuery.sizeOf(context).width),
                backgroundColor: const Color(0xFF044389),
                waveFrequency: 1,
                waveAmplitude: 1,
                wavePhase: 1000,

              ),
            ),
          ),
          Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "'Hmmm... Que si quiera deberia hacer?' Don Ramón, mientras que está anuente de la situación, no sabe por donde empezar. Mientras que desciende más el sitio, se encuentrá con un particular anuncio que describe exactamente lo que necesita. ",
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "¿Qué hará Don Ramón?",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300,
                child:
                MyButton(
                    direction: Axis.horizontal,
                    textColor: Colors.black,
                    buttonColor: const Color(0xFFFFFB8D),
                    buttonIconColor: Colors.black,
                    buttonIcon: Icons.ads_click,
                    onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const ACBadEndingPage1(gameOverReason: "El conveniente anuncio era una trampa! Don Ramón terminó entrando en un link con muchas vulnerabilidades que robó sus datos... \nTal vez deberias dudar un poco más de las cosas, no?"),
                              type: PageTransitionType.fade
                          )
                      )
                    },
                    insertText: "Cliquea el anuncio \nsospechosamente preciso"
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child:
                MyButton(
                    direction: Axis.horizontal,
                    textColor: Colors.black,
                    buttonColor: const Color(0xFFFFFB8D),
                    buttonIconColor: Colors.black,
                    buttonIcon: Icons.warning_amber,
                    onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const ACIntermissionPage4(),
                              type: PageTransitionType.fade
                          )
                      )
                    },
                    insertText: "Sigue scrolleando en\n la página, hasta que..."
                ),
              ),


            ],
          ),
        ),
        ]
      ),
    );
  }
}
