// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  static const routeName = 'onBoarding';
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late List<BoardingModel> boarding;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    boarding = [
      BoardingModel(
        image: 'assets/images/food1.json',
        title: getLang(context, "drawerName"),
        body: getLang(context, "onboardTitle1"),
      ),
      BoardingModel(
        image: 'assets/images/food2.json',
        title: getLang(context, "drawerName"),
        body: getLang(context, "onboardTitle2"),
      ),
      BoardingModel(
        image: 'assets/images/food3.json',
        title: getLang(context, "drawerName"),
        body: getLang(context, "onboardTitle3"),
      ),
    ];
  }

  var boardingController = PageController();
  bool isMove = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              sender();
            },
            child: Text(
              'SKIP',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isMove = true;
                    });
                  } else {
                    setState(() {
                      isMove = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoarding(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.amber,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isMove) {
                      sender();
                    } else {
                      boardingController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoarding(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Lottie.asset(
              '${model.image}',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          TextLiquidFill(
            text: '${model.title}',
            waveColor: Colors.amber,
            boxHeight: 59.0,
            boxWidth: 171.0,
            boxBackgroundColor: Theme.of(context).canvasColor,
            loadDuration: Duration(seconds: 11),
            waveDuration: Duration(seconds: 9),
            textStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(
                    .43,
                  ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      );

  Future<void> sender() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("onBoarding", true).then((bool? value) {
      if (value!) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TabsScreen(),
          ),
        );
      }
    });
  }
}
