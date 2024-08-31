import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/chat_screen.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/screens/order_screen.dart';
import 'package:eggventure/screens/profile_screen.dart';
import 'package:eggventure/screens/tray_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class NavigationBarWidget extends StatefulWidget {
  final int currentIndex;

  const NavigationBarWidget({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Widget getScreen(int index) {
      switch (index) {
        case 0:
          return HomeScreen();
        case 1:
          return OrderScreen();
        case 2:
          return ChatScreen();
        case 3:
          return TrayScreen();
        case 4:
          return ProfileScreen();
        default:
          return HomeScreen();
      }
    }

    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => getScreen(index),
      transitionDuration: Duration.zero,  // No transition duration
      reverseTransitionDuration: Duration.zero,  // No reverse transition duration
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(), // Optional: add notch if using FloatingActionButton
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Color(0xFFF9B514) : Color(0xFF353E55),
            ),
            onPressed: () => _onItemTapped(0),
          ),
          IconButton(
            icon: Icon(
              AntDesign.calendar_outline,
              color: _selectedIndex == 1 ? Color(0xFFF9B514) : Color(0xFF353E55),
            ),
            onPressed: () => _onItemTapped(1),
          ),
          IconButton(
            icon: Icon(
              AntDesign.message_outline,
              color: _selectedIndex == 2 ? Color(0xFFF9B514) : Color(0xFF353E55),
            ),
            onPressed: () => _onItemTapped(2),
          ),
          IconButton(
            icon: Icon(
              AntDesign.inbox_outline,
              color: _selectedIndex == 3 ? Color(0xFFF9B514) : Color(0xFF353E55),
            ),
            onPressed: () => _onItemTapped(3),
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 4 ? Color(0xFFF9B514) : Color(0xFF353E55),
            ),
            onPressed: () => _onItemTapped(4),
          ),
        ],
      ),
    );
  }
}
