import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/screens/age_warning_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/generic_inputs/my_button.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class IntroPageInfo{
  final String title;
  final String description;
  final String image;

  IntroPageInfo({
    required this.title,
    required this.description,
    required this.image
  });
}

class IntroPageItems{
  List<IntroPageInfo> itemPages = [
    IntroPageInfo(
        title: "Bienvenido!",
        description: "Bienvenido a Sentinel! Este aplicación podras encontrar actividades educativas que te enseñaran sobre lecciones de seguridad de información.",
        image: "assets/content/introduction/int_security.png"
    ),
    IntroPageInfo(
        title: "Para todas las edades",
        description: "Sentinel te proveerá diferente contenido dado tu edad. Así podras entender algo que le pasaría a alguien de tu edad.",
        image: "assets/content/introduction/int_family.png"
    ),
    IntroPageInfo(
        title: "No estas solo!",
        description: "Conoce a Will! El te guiará en la aplicación! Pero Will necesitará que prestes atención a sus consejos, woof!",
        image: "assets/content/introduction/int_will_dog.png"
    ),
    IntroPageInfo(
        title: "Recuerda",
        description: "Sigue lo que te dicen! Este mensaje y el siguiente solo aparecen una vez.",
        image: "assets/content/introduction/int_reminder.png"
    ),
  ];
}

class _IntroductionPageState extends State<IntroductionPage> {

  final _itemController = IntroPageItems();
  final _pageController = PageController();
  bool isLastPage = false;
  bool isAdult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF044389),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: ()=>_pageController.jumpToPage(_itemController.itemPages.length-1,),
                child: const Text("Saltar")
            ),

            SmoothPageIndicator(
                controller: _pageController,
                count: _itemController.itemPages.length,
                onDotClicked: (index)=> _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn
                  ),
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Color(0xFF044389)
                ),
            ),

            TextButton(
                onPressed: ()=>_pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn),
                child: const Text("Adelante")
            ),
          ],
        ),
      ),
      body: PageView.builder(
          onPageChanged: (index) => setState(()=> isLastPage = _itemController.itemPages.length-1  == index),
          itemCount: _itemController.itemPages.length,
          controller: _pageController,
          itemBuilder: (context, index){
            return Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 90, bottom: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(_itemController.itemPages[index].image),
                  const SizedBox(height: 10,),
                  Text(_itemController.itemPages[index].title,
                    style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  const SizedBox(height: 10,),
                  Text(_itemController.itemPages[index].description,
                    style: const TextStyle(fontSize: 19, color: Colors.white), textAlign: TextAlign.justify,
                      ),

                ],
                          ),
            );
        }
            )
    );
  }

  Widget getStarted(){
    return SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        height: 48,
        child: MyButton(
          onTap: () async {
            final pres = await SharedPreferences.getInstance();
            pres.setBool("first_time_started", true);
            if(!mounted)return;
            Navigator.pushReplacement(context, PageTransition(child: const AgeWarningPage(), type: PageTransitionType.fade ) );
          },
          insertText: "Continuar",
        ),
    );
  }


  

}
