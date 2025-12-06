import 'package:flutter/material.dart';
import 'package:myapp/screens/favorites_screen.dart';
import 'package:myapp/screens/home_screen.dart';

class BottomNavHandler extends StatefulWidget {
  const BottomNavHandler({super.key});

  @override
  BottomNavHandlerState createState() => BottomNavHandlerState();
}

class BottomNavHandlerState extends State<BottomNavHandler> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'My List',
          ),
        ],
      ),
    );
  }
}
