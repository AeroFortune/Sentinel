import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../models/generic_inputs/my_button.dart';
import 'content_A_introduction_page.dart';

class ACSelectionPage1 extends StatelessWidget {
  const ACSelectionPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        centerTitle: true,
        leading:  BackButton(
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
                "El correo, supuestamente enviado por su banco, le informa que hay un problema con su cuenta y le pide que haga clic en un enlace para verificar su información.",
                textAlign: TextAlign.justify,
                softWrap: true,
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: -1
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Que hara Don Ramon?",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: -1
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child:
              MyButton(
                  direction: Axis.horizontal,
                  textSize: 25,
                  buttonIconSize: 40,
                  buttonIcon: Icons.ads_click,
                  onTap: () => {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const ACSelectionPage1(),
                            type: PageTransitionType.rightToLeftJoined, childCurrent: this
                        )
                    )
                  },
                  insertText: "Clic en el enlace"
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child:
              MyButton(
                  direction: Axis.horizontal,
                  textSize: 25,
                  buttonIconSize: 40,
                  buttonIcon: Icons.warning_amber,
                  onTap: () => {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const ACSelectionPage1(),
                            type: PageTransitionType.rightToLeftJoined, childCurrent: this
                        )
                    )
                  },
                  insertText: "Duda del correo"
              ),
            ),


          ],
        ),
      ),
    );
  }
}
