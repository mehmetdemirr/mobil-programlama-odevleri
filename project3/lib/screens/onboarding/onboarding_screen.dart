import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project3/screens/onboarding/onboarding_model.dart';
import 'package:project3/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: "Keşfet",
      description: "Yeni içerikleri keşfet ve ilham al",
      imagePath: "assets/svgs/onboarding1.svg",
    ),
    OnboardingItem(
      title: "Özelleştir",
      description: "Kişisel tercihlerine göre özelleştir",
      imagePath: "assets/svgs/onboarding2.svg",
    ),
    OnboardingItem(
      title: "Başla",
      description: "Harika deneyime hemen başla",
      imagePath: "assets/svgs/onboarding3.svg",
    ),
  ];

  void _onNextPressed() async {
    if (_currentPageIndex < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstOpen', false);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade800, Colors.deepPurple.shade200],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingItems.length,
                onPageChanged: (index) {
                  setState(() => _currentPageIndex = index);
                },
                itemBuilder: (context, index) {
                  final item = _onboardingItems[index];
                  return _OnboardingPage(item: item);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _BottomControls(
                currentIndex: _currentPageIndex,
                totalPages: _onboardingItems.length,
                onNextPressed: _onNextPressed,
                isLastPage: _currentPageIndex == _onboardingItems.length - 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const _OnboardingPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              width: MediaQuery.of(context).size.width * 0.9,
              item.imagePath,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class _BottomControls extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final VoidCallback onNextPressed;
  final bool isLastPage;

  const _BottomControls({
    required this.currentIndex,
    required this.totalPages,
    required this.onNextPressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalPages, (index) {
            return Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
              ),
            );
          }),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onNextPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              isLastPage ? "Hadi Başla!" : "İleri",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
