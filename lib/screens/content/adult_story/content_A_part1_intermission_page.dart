import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/content/adult_story/content_A_introduction_page.dart';
import 'package:sentinel/screens/content/adult_story/content_A_part1_selection_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ACIntermissionPage1 extends StatelessWidget {
  const ACIntermissionPage1({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFB8D),
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(
                context,
                PageTransition(child: const ACIntroductionPage(),
                    type: PageTransitionType.fade
                )
            );
          },
        ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "Don Ramón, un jubilado de 70 años, vive solo en su casa y disfruta de pasar el tiempo navegando por internet y leyendo correos electrónicos de sus amigos y familiares. Una mañana, mientras revisa su bandeja de entrada, recibe un correo inesperado.",
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child:
                MyButton(
                    direction: Axis.horizontal,
                    textColor: Colors.black,
                    buttonColor: const Color(0xFFFFFB8D),
                    buttonIconColor: Colors.black,
                    buttonIcon: Icons.navigate_next_sharp,
                    onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: const ACSelectionPage1(),
                            type: PageTransitionType.rightToLeftJoined, childCurrent: this
                          )
                      )
                    },
                    insertText: "Continuar"
                ),
              )
            ],
          ),
        ),]
      ),
    );
  }
}
