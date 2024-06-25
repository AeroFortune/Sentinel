import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/age_warning_confirm_page.dart';
import 'package:sentinel/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AgeWarningPage extends StatefulWidget {
  const AgeWarningPage({super.key});

  @override
  State<AgeWarningPage> createState() => _AgeWarningPageState();
}

class _AgeWarningPageState extends State<AgeWarningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        title: const Text("Aviso", textAlign: TextAlign.center, style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFFFB8D),
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
          margin: const EdgeInsets.only(top: 40, bottom: 0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Esta aplicación puede ser compleja de navegar. Por favor lee cuidadosamente. Esta página es solo un aviso! \nLo que escojas aqui no importará o afectará el usaje general de la aplicación.",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
                softWrap: true,
                textAlign: TextAlign.justify,),
              const SizedBox(height: 150,),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Boton de edad: niño
                    SizedBox(
                      width: 150,
                      height: 250,
                      child: MyButton(
                        buttonIcon: Icons.person,
                        buttonIconSize: 90,
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                child: const AgeWarningConfirmPage(),
                                type: PageTransitionType.bottomToTop,
                              )
                          );
                        },
                        insertText: "Niño",
                        textSize: 39,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    // Boton de edad: adulto
                    SizedBox(
                      width: 150,
                      height: 250,
                      child: MyButton(
                            buttonIcon: Icons.person,
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
                            insertText: "Adulto",
                            textSize: 39,

                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]
      ),
    );
  }
}
