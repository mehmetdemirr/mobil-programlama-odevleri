import 'package:flutter/material.dart';
import 'package:project2/screens/company/home/view/company_home_screen.dart';
import 'package:project2/screens/company/profile/view/profile_screen.dart';

class CompanyBottomNavigationScreen extends StatefulWidget {
  const CompanyBottomNavigationScreen({super.key});
  @override
  State<CompanyBottomNavigationScreen> createState() =>
      _CompanyBottomNavigationScreenState();
}

class _CompanyBottomNavigationScreenState
    extends State<CompanyBottomNavigationScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    CompanyHomeScreen(),
    CompanyProfileScreen(),
    Center(
      child: Icon(Icons.add),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 60,
        color: Colors.cyan.shade200,
        notchMargin: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
              color: Colors.cyan.shade500,
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
