import 'package:flutter/material.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:sentinel/screens/home_page.dart';
import 'package:sentinel/screens/login_register_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuthServices().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginRegisterPage();
          }
        },
    );
  }
}
