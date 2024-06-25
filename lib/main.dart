import 'package:flutter/material.dart';
import 'package:sentinel/screens/introduction_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helpers/firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  final prefs = await SharedPreferences.getInstance();
  final isStarted = prefs.getBool("first_time_started") ?? false;
  final isAgeVerificated = prefs.getBool("age_verificated") ?? false;


  runApp(MyApp( isStarted: isStarted, isAgeVerificated: isAgeVerificated ));
}

class MyApp extends StatelessWidget {

  final bool isStarted;
  final bool isAgeVerificated;

  const MyApp({super.key, this.isStarted = false, this.isAgeVerificated = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sentinel',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
      ),
      home: isStarted && isAgeVerificated ? ShowCaseWidget(builder: (context) => const WidgetTree()) : ShowCaseWidget(builder: (context) => const IntroductionPage()),
    );
  }
}
