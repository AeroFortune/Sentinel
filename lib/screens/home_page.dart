import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/models/generic_inputs/my_textfield.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid(){
    return Text(user?.email ?? 'User email');
  }

  Widget _title(){
    return const Text('Firebase Auth');
  }

  Widget _signOutButton(){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100,40)
        ),
        onPressed: signOut,
        child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(),
            MyTextField(hintText: "aaa", obscureText: true, icon: Icons.ice_skating),
            MyButton(onTap: () => {

            }, insertText: "insertText")
          ],
        ),

      ),
    );
  }
}
