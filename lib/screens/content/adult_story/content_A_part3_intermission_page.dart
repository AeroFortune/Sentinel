import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/content/adult_story/content_A_introduction_page.dart';
import 'package:sentinel/screens/content/adult_story/content_A_part1_selection_page.dart';

class ACIntermissionPage1 extends StatelessWidget {
  const ACIntermissionPage1({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        centerTitle: true,
        leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: const ACIntroductionPage(),
                      type: PageTransitionType.fade
                  )
              );
            },
        ),
        title: const Text("Historia", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      backgroundColor: const Color(0xFFFFFB8D),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 150,
              child: Placeholder(
                strokeWidth: 1,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Text(
                "Don Ramón, un jubilado de 70 años, vive solo en su casa y disfruta de pasar el tiempo navegando por internet y leyendo correos electrónicos de sus amigos y familiares. Una mañana, mientras revisa su bandeja de entrada, recibe un correo inesperado.",
                textAlign: TextAlign.justify,
                softWrap: true,
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: -1
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child:
              MyButton(
                  direction: Axis.horizontal,
                  textSize: 25,
                  buttonIconSize: 40,
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
      ),
    );
  }
}
