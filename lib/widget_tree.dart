import 'package:flutter/material.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:sentinel/screens/home_page.dart';
import 'package:sentinel/screens/login_page.dart';
import 'package:showcaseview/showcaseview.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {


    bool? status = FirebaseAuthServices().currentUser?.emailVerified;

    return StreamBuilder(
        stream: FirebaseAuthServices().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            if (status == false) {
              return ShowCaseWidget(builder: (context) => const LoginPage());
            }

            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
    );
  }
}
