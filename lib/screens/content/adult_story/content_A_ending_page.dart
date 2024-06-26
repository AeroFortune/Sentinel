import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';

import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/content/adult_story/content_A_introduction_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ACEndingPage extends StatelessWidget {
  const ACEndingPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFB8D),
        centerTitle: true,
        leading: null,
        title: const Text("Historia", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      backgroundColor: const Color(0xFF044389),

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
                  const SizedBox(height: 10),
                  const Text(
                    "Bien hecho!",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: -1
                    ),
                  ).animate().scale(delay: 100.ms).fadeIn(duration: 1200.ms),
                  const SizedBox(height: 50),
                  const Text(
                    "Guiaste a Don Ramón a que no pierda sus datos y aprendiera lecciones sobre la seguridad! \nEn un mar de peligros, es importante que tu también apliques estas lecciones!",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: -1
                    ),
                  ).animate().fadeIn(duration: 3000.ms),
                  const SizedBox(height: 50),


                  const SizedBox(height: 30),

                  SizedBox(
                    width: 300,
                    child:
                    MyButton(
                        direction: Axis.horizontal,
                        buttonColor: const Color(0xFFFFFB8D),
                        textColor: Colors.black,
                        buttonIconColor: Colors.black,
                        buttonIcon: Icons.ads_click,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACIntroductionPage(),
                                  type: PageTransitionType.fade
                              )
                          )
                        },
                        insertText: "Volver al inicio"
                    ),
                  ).animate().slide(duration: 100.ms).fadeIn(duration: 5000.ms),
                  const SizedBox(height: 10),


                ],
              ),
            ),
          ]
      ),
    );
  }
}
