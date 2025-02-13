import 'package:flutter/material.dart';
import 'package:hafta1/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/logo.jpeg"),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: const BoxDecoration(
            // color: Colors.amber,
            ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "by mehmet",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ),
    );
  }
}
