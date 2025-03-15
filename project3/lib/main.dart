import 'package:flutter/material.dart';
import 'package:project3/cache/shared_pref.dart';
import 'package:project3/screens/onboarding/onboarding_screen.dart';
import 'package:project3/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isFirstOpen = await AppPreferences.isFirstOpen;

  runApp(MyApp(isFirstOpen: isFirstOpen));
}

class MyApp extends StatelessWidget {
  final bool isFirstOpen;
  const MyApp({super.key, required this.isFirstOpen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: true ? OnboardingScreen() : SplashScreen(),
    );
  }
}
