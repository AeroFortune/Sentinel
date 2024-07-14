import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/content/adult_story/content_A_introduction_page.dart';
import 'package:sentinel/screens/content/adult_story/content_A_part2_selection_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ACIntermissionPage2 extends StatefulWidget {
  const ACIntermissionPage2({super.key});

  @override
  State<ACIntermissionPage2> createState() => _ACIntermissionPage2State();
}

class _ACIntermissionPage2State extends State<ACIntermissionPage2> {

  final FlutterTts _flutterTts = FlutterTts();
  Future<void> _speakText() async {
    await _flutterTts.setLanguage("es-ES"); // Establecer el idioma
    await _flutterTts.setPitch(1.0); // Ajustar el tono
    await _flutterTts.speak("Don Ramón decide no hacer clic en el enlace y revisa el correo con más atención. Nota que hay algunas faltas de ortografía y que la dirección del remitente parece sospechosa. Entonces, decide eliminar el correo sospechoso y no toma ninguna otra acción.",);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFB8D),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _speakText();
            },
            icon: const Icon(Icons.volume_up_outlined),
            color: Colors.black,
            tooltip: "Activar narrador",
          )
        ],
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.confirm,
              title: "Advertencia",
              text: "Estás seguro que deseas salir del juego? Perderás tu progreso!",
              confirmBtnColor: const Color(0xFF044389),
              confirmBtnText: "OK",
              cancelBtnText: "Cancelar",
              onConfirmBtnTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const ACIntroductionPage(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            );
          },
        ),
        title: const Text(
          "Historia",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
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
                  heightPercentages: [-0.3, 0.002],
                ),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const Text(
                    "Don Ramón decide no hacer clic en el enlace y revisa el correo con más atención. Nota que hay algunas faltas de ortografía y que la dirección del remitente parece sospechosa. Entonces, decide eliminar el correo sospechoso y no toma ninguna otra acción.",
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
                  child: MyButton(
                    direction: Axis.horizontal,
                    textColor: Colors.black,
                    buttonColor: const Color(0xFFFFFB8D),
                    buttonIconColor: Colors.black,
                    buttonIcon: Icons.navigate_next_sharp,
                    onTap: () => {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const ACSelectionPage2(),
                          type: PageTransitionType.rightToLeftJoined,
                          childCurrent: widget,
                        ),
                      )
                    },
                    insertText: "OK",
                  ),
                ),
              ],
            ),
          ),
          // Animación de "Correcto"

        ],
      ),
    );
  }
}
