import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final String hintText;
  final bool obscureText;
  final IconData icon;

  const MyTextField({
    super.key,

    required this.hintText,
    required this.obscureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(

        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide(color: Colors.indigo, width: 2.5),
            ),
            fillColor: Colors.grey[100],
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 20)
        ),

      ),
    );
  }
}