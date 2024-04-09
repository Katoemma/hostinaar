import 'package:Hostinaar/screens/login/login.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: const [
          OnboardingPage(
            title: 'Explore Student-Friendly Spaces',
            description:
                'Discover a diverse range of student-friendly accommodations',
            image: 'images/onBoarding1.png',
            currentPage: 0,
            numPages: 3,
          ),
          OnboardingPage(
            title: 'Your Gateway to Boundless Choices',
            description:
                'Immerse yourself in a spectrum of accommodation options, empowering you to select the perfect stay for your every adventure',
            image: 'images/onboarding2.png',
            currentPage: 1,
            numPages: 3,
          ),
          OnboardingPage(
            title: 'Explore Student-Friendly Dwellings',
            description:
                'Embark on a journey to discover a wide array of student-friendly dwellings, each thoughtfully designed to cater to the unique needs and preferences of students like you.',
            image: 'images/onboarding3.png',
            currentPage: 2,
            numPages: 3,
          ),
        ],
      ),
      bottomSheet: currentPageIndex == 2
          ? BottomSheetWidget(
              onNextPressed: () {
                // Handle what to do when the "Next" button is pressed
                // For example, navigate to the next screen
                Navigator.pushReplacementNamed(context, '/next_screen');
              },
            )
          : null,
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int currentPage;
  final int numPages;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.currentPage,
    required this.numPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 280,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PTSerif',
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Divider(
                        height: 3,
                        color: kSecondaryColor,
                        endIndent: MediaQuery.of(context).size.width * 0.5,
                        indent: MediaQuery.of(context).size.width * 0.1,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: 280,
                        child: Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: kAdditionalColor,
                            height: 1.4,
                            fontFamily: 'Notosan',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          numPages,
                          (index) => Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index
                                  ? kPrimaryColor // Active dot color
                                  : Colors.grey, // Inactive dot color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  final VoidCallback onNextPressed;

  const BottomSheetWidget({super.key, required this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      color: Colors.white,
      child: GestureDetector(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setBool('isFirstTime', false);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Continue',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
