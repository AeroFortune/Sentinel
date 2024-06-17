
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sentinel/helpers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentinel/models/generic_inputs/my_textfield.dart';


class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

  // TODO: Probablemente separar registro en su propia pantalla? Si le puedo poner una animación a esta entonces no
  // TODO: Importa though.

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerVerifyPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuthServices().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)
    );

    if (picked != null){
      setState(() {
        _controllerDate.text = picked.toString().split(" ")[0];
      });
    }

  }

  Future<void> addUserDetails(String uid, String nombre, String email, String fechaNac) async {
    FirebaseFirestore.instance.collection('users').add({
      'fechaNac': fechaNac,
      'email': email,
      'nombre': nombre,
      'uid': uid
    });
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      if (_controllerPassword.text.trim() != _controllerVerifyPassword.text.trim()) {
          Fluttertoast.showToast(
              msg: "Las contraseñas no coinciden, intentelo otra vez.",
              toastLength: Toast.LENGTH_LONG,
              fontSize: 23);
      }
      await FirebaseAuthServices().createUserWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim(),
      );
      addUserDetails(
          FirebaseAuth.instance.currentUser!.uid,
          _controllerName.text.trim(),
          _controllerEmail.text.trim(),
          _controllerDate.text.trim()
      ).whenComplete(
        () => const SnackBar(
            content: Text("Se ha registrado la cuenta con éxito! Por favor continua con los pasos indicados.")),
      );


    } on FirebaseAuthException catch (e) {
      setState(() {
        Fluttertoast.showToast(
            msg: "Algo ha salido mal!",
            toastLength: Toast.LENGTH_LONG);
        errorMessage = e.message;
      });
    }
  }

  Widget _title(){
    return const Text('Firebase Auth Test');
  }

  Widget _submitButton(){
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * .075,
      child: ElevatedButton(
        onPressed: isLogin ? signInWithEmailAndPassword  : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Iniciar Sesión' : 'Registrarse', style: const TextStyle( fontSize: 24),),
      ),
    );
  }

  Widget _loginOrRegisterButton(){
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * .075,
      child: ElevatedButton(
          onPressed: (){
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(isLogin ? 'No tienes cuenta?' : 'Ya tienes cuenta?', style: const TextStyle( fontSize: 24),)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFB8D),
      appBar: AppBar(
          backgroundColor: Color(0xFF044389),
        title: Text("Menú Principal", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          duration: const Duration(milliseconds: 900),
          child: isLogin ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Iniciar Sesión", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), ),
                const SizedBox(height: 10,),
                SentinelTextfield(hintText: "Usuario", obscureText: false, icon: Icons.person, controller: _controllerEmail),
                SentinelTextfield(hintText: "Contraseña", obscureText: true, icon: Icons.key, controller: _controllerPassword),
                const SizedBox(height: 10,),
                _submitButton(),
                const SizedBox(height: 10,),
                _loginOrRegisterButton(),
              ],
          )
          ) : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Registrarse", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), ),
                  const SizedBox(height: 10,),
                  SentinelTextfield(hintText: "Nombre", obscureText: false, icon: Icons.font_download, controller: _controllerName),
                  SentinelTextfield(hintText: "Email", obscureText: false, icon: Icons.person, controller: _controllerEmail,),
                  SentinelTextfield(hintText: "Contraseña", obscureText: true, icon: Icons.key, controller: _controllerPassword),
                  SentinelTextfield(hintText: "Verificar contraseña", obscureText: true, icon: Icons.vpn_key_outlined, controller: _controllerVerifyPassword),
                  SentinelTextfield(
                      hintText: "Fecha de nacimiento",
                      obscureText: false,
                      icon: Icons.font_download,
                      controller: _controllerDate,
                      readOnly: true,
                      onTap: (){
                        _selectDate();
                      },
                  ),

                  const SizedBox(height: 3,),
                  _submitButton(),
                  const SizedBox(height: 3,),
                  _loginOrRegisterButton(),
                ],
              )
          ),
          ),
      ),
    );
    
    
    
  }
}
