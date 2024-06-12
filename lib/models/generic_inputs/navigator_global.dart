import 'package:flutter/material.dart';
import 'navigator_key.dart';

class GlobalNavigator {
  static showAlertDialog(String text) {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('OK', textAlign: TextAlign.center,),
            ),
          ],
        );
      },
    );
  }
}
