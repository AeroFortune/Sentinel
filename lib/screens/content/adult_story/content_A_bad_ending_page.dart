import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/screens/content/adult_story/content_A_introduction_page.dart';

import '../../../models/generic_inputs/my_button.dart';

class ACBadEndingPage1 extends StatelessWidget {
  const ACBadEndingPage1({super.key, required this.gameOverReason});

  final String gameOverReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Game Over", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Ten más cuidado!",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: -1
              ),
            ).animate().scale(delay: 100.ms).fadeIn(duration: 1200.ms),
            const SizedBox(height: 50),
            Text(
              gameOverReason,
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: -1
              ),
            ).animate().fadeIn(duration: 3000.ms),
            const SizedBox(height: 50),

            SizedBox(
              width: 300,
              child:
              MyButton(
                  direction: Axis.horizontal,
                  buttonIcon: Icons.warning_amber,
                  onTap: () => {
                    Navigator.pop(context)
                  },
                  insertText: "Volver al último punto"
              ),
            ).animate().slide(duration: 100.ms).fadeIn(duration: 4000.ms),

            const SizedBox(height: 30),

            SizedBox(
              width: 300,
              child:
              MyButton(
                  direction: Axis.horizontal,
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
    );
  }
}
