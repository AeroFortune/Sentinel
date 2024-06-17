import 'package:flutter/material.dart';
import 'package:sentinel/screens/introduction_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
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


  runApp(MyApp( isStarted: isStarted ));
}

class MyApp extends StatelessWidget {

  final bool isStarted;

  const MyApp({super.key, this.isStarted = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sentinel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
        useMaterial3: true,
      ),
      home: isStarted? const WidgetTree() : const IntroductionPage(),
    );
  }
}
