import 'package:flutter/material.dart';
import 'package:project4/screens/statistic/statistic_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ana sayfa")),
      body: Column(children: const []),
    );
  }
}
