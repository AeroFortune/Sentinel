import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/age_verification_confirm_page.dart';
import 'package:sentinel/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgeVerificationPage extends StatefulWidget {
  const AgeVerificationPage({super.key});

  @override
  State<AgeVerificationPage> createState() => _AgeVerificationPageState();
}

class _AgeVerificationPageState extends State<AgeVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFB8D),
        title: Text("Verificación de Edad", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFFFFB8D),
      body: Container(
        margin: EdgeInsets.only(top: 40, bottom: 0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Por favor escoge tu edad dentro de este rango para continuar.",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              softWrap: true,
              textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Boton de edad: niño
                Container(
                  width: 300,
                  height: 200,
                  child: MyButton(
                    buttonIcon: Icons.person,
                    buttonIconSize: 90,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            child: AgeVerificationConfirmPage(),
                            type: PageTransitionType.bottomToTop,
                          )
                      );
                    },
                    insertText: "Niño",
                    textSize: 39,
                  ),
                ),
                SizedBox(height: 10,),
                // Boton de edad: adulto
                Container(
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
                                child: LoginPage(),
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
