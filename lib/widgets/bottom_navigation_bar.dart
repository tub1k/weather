import 'package:flutter/material.dart';
import 'package:weather/constants/routes.dart';

class MainNavigationBar extends StatelessWidget {
  final int currentIndex;
  final VoidCallback? onReturn;

  const MainNavigationBar({super.key, required this.currentIndex, this.onReturn});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false, 
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) return; 

        if (index == 0) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false).then((_) {onReturn?.call();});
        } else if (index == 1) {
          Navigator.pushNamed(context, searchRoute).then((_) {onReturn?.call();});
        } else if (index == 2) {
          Navigator.pushNamed(context, settingsRoute);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}