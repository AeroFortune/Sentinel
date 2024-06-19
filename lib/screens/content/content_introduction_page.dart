import 'package:flutter/material.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';


class ContentIntroductionPage extends StatefulWidget {
  const ContentIntroductionPage({super.key});

  @override
  State<ContentIntroductionPage> createState() => _ContentIntroductionPageState();
}

class _ContentIntroductionPageState extends State<ContentIntroductionPage> {

  String textDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFB8D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        title: const Text("Introducción", textAlign: TextAlign.center, style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.white
        ),
        actions: [
          IconButton(
            onPressed: () => print("Testing if this works."),
            icon: const Icon(Icons.volume_up_outlined),
            color: Colors.white,
            tooltip: "Activar narrador",
          )
        ],
      ), // titulo
      body: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
              child: Placeholder(
                strokeWidth: 1,
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
                child: Text(textDescription,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,

                  ),
                  textAlign: TextAlign.justify,
                  softWrap: true,)), // descripcion
            const SizedBox(height: 20,),
            // image
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 180,
                      child: MyButton(
                          buttonIcon: Icons.timeline,
                          buttonIconSize: 80,
                          onTap: () => print("Funcionalidad aqui"),
                          insertText: "Timeline",
                          textSize: 29,
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: MyButton(
                          buttonIcon: Icons.gamepad,
                          buttonIconSize: 80,
                          buttonColor: Colors.green,
                          onTap: () => print("Insertar navegación aqui."),
                          insertText: "Iniciar",
                          textSize: 29,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
              ],
            ) // botones de abajo
          ],
        ),
      ),
    );
  }
}
