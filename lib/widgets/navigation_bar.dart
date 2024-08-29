import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var selectedIndex = 0;
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Tray',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xFFF9B514),
        unselectedItemColor: Color(0xFF353E55),
        onTap: null,
      );
  }
}