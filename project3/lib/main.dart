import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project3/cache/shared_pref.dart';
import 'package:project3/models/post_model.dart';
import 'package:project3/screens/home/post_viewmodel.dart';
import 'package:project3/screens/onboarding/onboarding_screen.dart';
import 'package:project3/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isFirstOpen = await AppPreferences.isFirstOpen;

  await Hive.initFlutter();
  //location cache
  Hive.openBox<PostModel>("posts");
  Hive.registerAdapter(PostModelAdapter());

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PostViewModel())],
      child: MyApp(isFirstOpen: isFirstOpen),
    ),
  );
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
      home: isFirstOpen ? OnboardingScreen() : SplashScreen(),
    );
  }
}
