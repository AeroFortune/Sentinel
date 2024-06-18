import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class AgeVerificationConfirmPage extends StatefulWidget {
  const AgeVerificationConfirmPage({super.key});

  @override
  State<AgeVerificationConfirmPage> createState() => _AgeVerificationConfirmPageState();
}

class _AgeVerificationConfirmPageState extends State<AgeVerificationConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.yellow,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("warning descripcion a x y z", textAlign: TextAlign.justify,),
          Container(
            child: MyButton(
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
              insertText: "",
            ),
          )
        ],
      ),
    );
  }
}
