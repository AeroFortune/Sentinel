import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sentinel/screens/age_verification_page.dart';
import 'package:sentinel/widget_tree.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        title: "Bienvenido",
        description: "En esta aplicación podras encontrar actividades cortas que te enseñaran sobre lecciones de seguridad en linea.",
        image: "image"
    ),
    IntroPageInfo(
        title: "wea",
        description: "asdasd",
        image: "image"
    ),
    IntroPageInfo(
        title: "wea",
        description: "a",
        image: "image"
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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: PageView.builder(
            onPageChanged: (index) => setState(()=> isLastPage = _itemController.itemPages.length-1  == index),
            itemCount: _itemController.itemPages.length,
            controller: _pageController,
            itemBuilder: (context, index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(_itemController.itemPages[index].image),
                  Text(_itemController.itemPages[index].title),
                  Text(_itemController.itemPages[index].description,
                        style: const TextStyle(fontSize: 19, color: Colors.grey), textAlign: TextAlign.center,
                      ),

                ],
            );
          }
      ),
    )
    );
  }

  Widget getStarted(){
    return SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFFB8D)
          ),
          onPressed: ()async{
            final pres = await SharedPreferences.getInstance();
            pres.setBool("first_time_started", true);
            if(!mounted)return;
            Navigator.pushReplacement(context, PageTransition(child: AgeVerificationPage(), type: PageTransitionType.fade ) );
          },
          child: const Text("Continuar"),
        ),
    );
  }


  

}
