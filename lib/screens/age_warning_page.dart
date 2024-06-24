import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/age_warning_confirm_page.dart';
import 'package:sentinel/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

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
      body: Container(
        margin: const EdgeInsets.only(top: 40, bottom: 0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Esta aplicación puede ser compleja de navegar. Por favor lee cuidadosamente. Esta página es solo un aviso! \nLo que escojas aqui no importará o afectará el usaje general de la aplicación.",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              softWrap: true,
              textAlign: TextAlign.justify,),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Boton de edad: niño
                SizedBox(
                  width: 300,
                  height: 200,
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
                  width: 300,
                  height: 200,
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
            )
          ],
        ),
      ),
    );
  }
}
