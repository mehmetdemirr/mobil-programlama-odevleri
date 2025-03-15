import 'package:flutter/material.dart';
import 'package:project3/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 123, 111, 131),
              Color.fromARGB(255, 146, 94, 156),
              Color.fromARGB(255, 161, 72, 177),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Hero(
                    tag: 'app-logo',
                    child: Image.asset(
                      'assets/images/app_logo.png', // Logo yolunu güncelleyin
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _animation.value,
                duration: const Duration(seconds: 1),
                child: const Text(
                  'Yükleniyor...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
