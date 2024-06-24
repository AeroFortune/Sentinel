import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

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
      backgroundColor: Colors.yellow,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Como eres un niño, es importante que estes acompañado de un adulto al usar esta aplicación. Ten cuidado! \nY si eres un adulto y seleccionaste esta opción, no te preocupes! Es solo un aviso, no afecta en ninguna forma lo que hagas después de esto.", softWrap: true, textAlign: TextAlign.justify,),
          Container(
            child: MyButton(
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
              insertText: "",
            ),
          )
        ],
      ),
    );
  }
}
