import 'package:flutter/material.dart';
import 'package:kulan_app/screens/fixture_screen.dart';
import 'package:kulan_app/screens/horyaal_screen.dart';
import 'package:kulan_app/screens/news_screen.dart';

class BottomNav1 extends StatefulWidget {
  const BottomNav1({Key? key}) : super(key: key);

  @override
  State<BottomNav1> createState() => _BottomNav1State();
}

class _BottomNav1State extends State<BottomNav1> {
  int _selectedIndex = 0;

  List screes = [
    PostListScreen(),
    CategoryListScreen(),
    FixtureScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String hexColor = "#2A3A68";
    Color color = Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
    // Color lighterColor = Color(0xFF333333)
    return Scaffold(
      body: Center(
        child: screes.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: color,
            icon: Icon(Icons.newspaper),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_football),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_football),
            label: 'Home',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
