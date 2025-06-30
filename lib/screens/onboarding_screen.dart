import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/slide_data.dart';
import '../screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int nextPage = _controller.page!.toInt() + 1;

      _controller.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFF211C12),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: Color(0xff473D24),
              child: PageView.builder(
                controller: _controller,
                itemCount: slides.length + 1,
                onPageChanged: (index) {
                  if (index == slides.length) {
                    Future.delayed(Duration(milliseconds: 300), () {
                      _controller.jumpToPage(0);
                    });
                    setState(() {
                      _currentIndex = 0;
                    });
                  } else {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  int displayIndex = index == slides.length ? 0 : index;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          slides[displayIndex]['image']!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            SmoothPageIndicator(
              controller: _controller,
              count: slides.length,
              effect: ScrollingDotsEffect(
                activeDotColor: Color(0xffF5C754),
                dotColor: Color(0xff473D24),
                dotHeight: 7,
                dotWidth: 7,
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    slides[_currentIndex]['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    slides[_currentIndex]['description']!,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('seenOnboarding', true);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
