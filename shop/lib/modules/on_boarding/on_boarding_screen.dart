import 'package:flutter/material.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//================================================================================================================================

// Model class representing each onboarding item with image, title, and body
class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

//================================================================================================================================

// StatefulWidget representing the OnBoarding screen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

//================================================================================================================================

// State class managing the OnBoarding screen
class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardControlller = PageController();

  // List of onboarding items
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/R.png',
        title: 'On Boarding 1 Title',
        body: 'On Boarding 1 Body'),
    BoardingModel(
        image: 'assets/images/R.png',
        title: 'On Boarding 2 Title',
        body: 'On Boarding 2 Body'),
    BoardingModel(
        image: 'assets/images/R.png',
        title: 'On Boarding 3 Title',
        body: 'On Boarding 3 Body'),
  ];

  // Flag indicating if the last onboarding item is reached
  bool isLast = false;

  // Function to execute when skipping onboarding
  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(fun: submit, text: 'SKIP'), // Skip button
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  // Update isLast flag when reaching the last onboarding item
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardControlller,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]), // Build onboarding item
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardControlller,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    // Execute submit function if last item reached, otherwise, go to next item
                    if (isLast) {
                      submit();
                    } else {
                      boardControlller.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(
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
}

//================================================================================================================================

