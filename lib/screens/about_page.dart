import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        title: const Text("Menú Principal", textAlign: TextAlign.center, style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF044389),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset("assets/ssi_logo.png", width: 130,),
              const SizedBox(height: 20,),
              const Text("Sentinel es una aplicación educacional diseñada para aquellas personas menores y mayores de edad, para que"
                  " todos tengan un chance justo de poder aprender historias que enseñen sobre los riesgos de seguridad en el internet.",
                softWrap: true, style: TextStyle(color: Colors.white), textAlign: TextAlign.justify,),
              const SizedBox(height: 30,),
              const Text("Sentinel es un proyecto final de Sistemas de Seguridad de Información, hecho en 2024, presentado por el grupo 1LS142, con los integrantes:",
                softWrap: true, style: TextStyle(color: Colors.white), textAlign: TextAlign.justify,),
              const SizedBox(height: 10,),
              const Text("Diego Arroyo",
                softWrap: true, style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
              const Text("Darriel Alonso",
                softWrap: true, style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
              const Text("Jeremy Lamas",
                softWrap: true, style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
              const Text("Kevin Cerrud",
                softWrap: true, style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
              const Text("Elquin Hernandéz",
                softWrap: true, style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
              const Text("Esteban Ramirez",
                softWrap: true, style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
              const Text("Steven Espinoza",
                softWrap: true, style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
            ],

          ),
        ),
      ),
    );
  }
}
