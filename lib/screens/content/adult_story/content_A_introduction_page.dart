
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:sentinel/screens/content/adult_story/content_A_part1_intermission_page.dart';
import 'package:sentinel/screens/content/content_branch_page.dart';
import 'package:sentinel/screens/home_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';


class ACIntroductionPage extends StatefulWidget {

  const ACIntroductionPage({super.key});

  @override
  State<ACIntroductionPage> createState() => _ACIntroductionPageState();
}

class _ACIntroductionPageState extends State<ACIntroductionPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFFFB8D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        title: const Text("Introducción", textAlign: TextAlign.center, style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const HomePage(),
                    type: PageTransitionType.fade
                )
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.volume_up_outlined),
            color: Colors.white,
            tooltip: "Activar narrador",
          )
        ],
      ), // titulo
      body: Stack(
        children:
        [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              color: const Color(0xFF044389),
              child: WaveWidget(
                config: CustomConfig(
                    colors: [const Color(0xFF044389), const Color(0xFFFFFB8D)],
                    durations: [5000, 5000],
                    heightPercentages: [-0.3, 0.33]),
                size: Size(MediaQuery.sizeOf(context).height, MediaQuery.sizeOf(context).width),
                backgroundColor: const Color(0xFFFFFB8D),
                waveFrequency: 1,
                waveAmplitude: 1,
                wavePhase: 1000,

              ),
            ),
          ),
          Container(
          margin: const EdgeInsets.only(top: 0, bottom: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/content/content_banner.png")),
              // const SizedBox(
              //   height: 150,
              //   child: Placeholder(
              //     strokeWidth: 1,
              //   ),
              // ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: const SizedBox(
                        child:
                        Text("Adentrate en la historia de Don Ramon, un ciudadano promedio de la vida cotidiana, que se involucra en una historia que lo pone en las manos de los riesgos de ciber-seguridad...",
                          style: TextStyle(
                              fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                          softWrap: true,)
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: const SizedBox(
                        child:
                        Text("¿Podras llevarlo a la seguridad?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify,
                          softWrap: true,)
                    ),
                  ),
                ],
              ), // descripcion
              const SizedBox(height: 20,),
              // image
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly    ,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 180,
                        child: MyButton(
                            buttonIcon: Icons.timeline,
                            buttonIconSize: 80,
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: const ContentBranchPage(),
                                      type: PageTransitionType.fade
                                  )
                              )

                            },
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
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: const ACIntermissionPage1(),
                                  type: PageTransitionType.leftToRightJoined, childCurrent: widget
                                )
                            );
                            },
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
        ]
      ),
    );
  }
}
