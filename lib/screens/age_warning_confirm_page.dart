import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'login_page.dart';

class AgeWarningConfirmPage extends StatefulWidget {
  const AgeWarningConfirmPage({super.key});

  @override
  State<AgeWarningConfirmPage> createState() => _AgeWarningConfirmPageState();
}

class _AgeWarningConfirmPageState extends State<AgeWarningConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        title: const Text("Aviso", textAlign: TextAlign.center, style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFFFFB8D),
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
          Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Como eres un niño, es importante que estes acompañado de un adulto al usar esta aplicación. Ten cuidado! \nY si eres un adulto y seleccionaste esta opción, no te preocupes! Es solo un aviso, no afecta en ninguna forma lo que hagas después de esto.",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.justify,),
                  const SizedBox(height: 170,),
                  // Boton de edad: adulto
                  SizedBox(
                    width: 300,
                    height: 200,
                    child: MyButton(
                      buttonIcon: Icons.check,
                      buttonIconSize: 90,
                      onTap: () async {
                        final pres = await SharedPreferences.getInstance();
                        pres.setBool("age_verificated", true);
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: ShowCaseWidget(builder: (context) => const LoginPage()),
                              type: PageTransitionType.bottomToTop,
                            )
                        );
                      },
                      insertText: "Confirmar",
                      textSize: 39,

                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Container(
      //       child: MyButton(
      //         onTap: () async {
      //           final pres = await SharedPreferences.getInstance();
      //           pres.setBool("age_verificated", true);
      //           Navigator.pushReplacement(
      //               context,
      //               PageTransition(
      //                 child: ShowCaseWidget(builder: (context) => const LoginPage()),
      //                 type: PageTransitionType.bottomToTop,
      //               )
      //           );
      //         },
      //         insertText: "",
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
