import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/content/adult_story/page_imports.dart';

class ContentBranchPage extends StatelessWidget {
  const ContentBranchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFB8D),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text("Historia", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      backgroundColor: const Color(0xFFFFFB8D),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "Parte 1: E-mail",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: -1
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.chrome_reader_mode_outlined,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACIntermissionPage1(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Intermisión"
                    ),
                  ),

                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.select_all,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACSelectionPage1(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Selección "
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "Parte 2: Preguntas",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: -1
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.chrome_reader_mode_outlined,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACIntermissionPage2(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Intermisión"
                    ),
                  ),

                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.select_all,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACSelectionPage2(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Selección "
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "Parte 3: Respuestas",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: -1
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.chrome_reader_mode_outlined,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACIntermissionPage3(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Intermisión"
                    ),
                  ),

                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.select_all,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACSelectionPage3(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Selección"
                    ),
                  )
                ],
              ),


              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "Parte 4: Táctica",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: -1
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.chrome_reader_mode_outlined,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACIntermissionPage4(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Intermisión"
                    ),
                  ),

                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.select_all,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACSelectionPage4(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Selección "
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "Parte 5: Final",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: -1
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.security,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACIntermissionPageEpilogue(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Epilogo"
                    ),
                  ),

                  SizedBox(
                    width: 160,
                    height: 100,
                    child:
                    MyButton(
                        direction: Axis.vertical,
                        textSize: 25,
                        buttonIconSize: 40,
                        buttonIcon: Icons.flag,
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const ACEndingPage(),
                                  type: PageTransitionType.rightToLeftJoined, childCurrent: this
                              )
                          )
                        },
                        insertText: "Final"
                    ),
                  )
                ],
              ),





            ].animate(interval: 100.ms).fadeIn(duration: 100.ms).slideX(duration: 50.ms),
          ),
        ),
      ),
    );
  }
}
