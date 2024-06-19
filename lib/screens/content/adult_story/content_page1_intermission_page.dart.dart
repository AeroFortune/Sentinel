import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/models/content_data.dart';
import 'package:sentinel/models/generic_inputs/my_button.dart';
import 'package:age_calculator/age_calculator.dart';

class ContentIntermissionPage extends StatelessWidget {
  const ContentIntermissionPage({super.key, this.contentData});

  final ContentData? contentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF044389),
        centerTitle: true,
        title: Text("Historia", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      backgroundColor: const Color(0xFFFFFB8D),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              contentData?.adultStories?.adultPart1?.storyIntermissionDesc ?? "Datos no encontrados, por favor contactar a un administrador.",
              textAlign: TextAlign.justify,
              softWrap: true,
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: -1
              ),
            ),
          ),
          Container(
            width: 30,
            child:
            MyButton(
                buttonIcon: Icons.navigate_next_outlined,
                onTap: () => {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //       child: ContentSelectionPage(),
                  //       type: PageTransitionType.fade,
                  //     )
                  // )
                },
                insertText: ""
            ),
          )
        ],
      ),
    );
  }
}
