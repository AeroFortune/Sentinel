import 'package:flutter/material.dart';

class SentinelTextfield extends StatelessWidget {

  final String hintText;
  final bool obscureText;
  final IconData icon;
  final controller;
  final Function()? onTap;
  final bool? readOnly;

  const SentinelTextfield({
    super.key,

    required this.hintText,
    required this.obscureText,
    required this.icon,
    required this.controller,
    this.onTap,
    this.readOnly
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onTap: onTap,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.black, width: 1)
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.redAccent, width: 3),
            ),
            fillColor: Colors.blueGrey[50],
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])
        ),

      ),
    );
  }
}