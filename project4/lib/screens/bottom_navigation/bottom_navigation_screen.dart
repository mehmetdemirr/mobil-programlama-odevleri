import 'package:flutter/material.dart';
import 'package:project4/screens/bottom_navigation/navigation_viewmodel.dart';
import 'package:project4/screens/category/category_screen.dart';
import 'package:project4/screens/home/home_screen.dart';
import 'package:project4/screens/product/view/product_screen.dart';
import 'package:project4/screens/profile/profile_screen.dart';
import 'package:project4/screens/statistic/statistic_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatelessWidget {
  final List<Widget> pages = [
    StatsScreen(),
    ProductListScreen(),
    CategoryScreen(),
    ProfileScreen(),
  ];

  BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: pages[navigationProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.currentIndex,
        onTap: (index) => navigationProvider.setIndex(index),
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Ürünler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategoriler',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
