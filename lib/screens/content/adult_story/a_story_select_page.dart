import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

import '../../home_page.dart';
import 'content_A_introduction_page.dart';

class AdultStorySelectPage extends StatelessWidget {
  const AdultStorySelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: const HomePage(),
                  type: PageTransitionType.fade
              ),
                  (route) => false,
            );
          },
        ),
        title: const Text("Selección de Historia", textAlign: TextAlign.center, style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),),
      ),
      backgroundColor: const Color(0xFF044389),
      body: ListView(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 150.0),
        children: [
          _buildLargeButton(context, "Historia 1: Fácil", () {
            Navigator.pushReplacement(context, PageTransition(child: const ACIntroductionPage(), type: PageTransitionType.bottomToTop,));
          }),
          const SizedBox(height: 16), // Espaciado entre botones
          _buildLargeButton(context, "Historia 2: Intermedio", () {
            toastification.show(

              context: context,
              title: const Text("Disculpa!", style: TextStyle(fontWeight: FontWeight.bold)),
              autoCloseDuration: const Duration(seconds: 10),
              description: const Text("Todavia no tenemos esta historia, disculpa...", style: TextStyle(fontWeight: FontWeight.bold)),
              type: ToastificationType.warning,
              style: ToastificationStyle.flatColored,
            );
          }),
          const SizedBox(height: 16),
          _buildLargeButton(context, "Historia 3: Díficil", () {
            toastification.show(
              context: context,
              title: const Text("Disculpa!", style: TextStyle(fontWeight: FontWeight.bold)),
              autoCloseDuration: const Duration(seconds: 10),
              description: const Text("Todavia no tenemos esta historia, disculpa...", style: TextStyle(fontWeight: FontWeight.bold)),
              type: ToastificationType.warning,
              style: ToastificationStyle.flatColored,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLargeButton(BuildContext context, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          color: const Color(0xFF044389),
          borderRadius: BorderRadius.circular(5),
          image: const DecorationImage(
            image: AssetImage("assets/banner2.png"), // Ruta de la imagen
            fit: BoxFit.cover, // Ajuste de la imagen
          ),
          border: Border.all(width: 2.0, color: Colors.transparent),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
