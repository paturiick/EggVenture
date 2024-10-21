import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:badges/badges.dart' as badges;
import 'package:eggventure/screens/consumer_screens/main_consumer/home_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/order_screen.dart';
import 'package:eggventure/screens/consumer_screens/chat_consumer/chat_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/tray_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/profile_screen.dart';
import 'package:provider/provider.dart';

class NavigationBarWidget extends StatefulWidget {
  final int currentIndex;

  const NavigationBarWidget({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

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

    final routes = [
      HomeScreen(),
      OrderScreen(),
      ChatScreen(),
      TrayScreen(),
      ProfileScreen(),
    ];

    // Navigate without any transition effect
    Navigator.of(context).pushAndRemoveUntil(
      NoAnimationMaterialPageRoute(builder: (context) => routes[index]),
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    final trayProvider = Provider.of<AddToTrayProvider>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Ensure labels are always visible
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _selectedIndex == 0 ? Color(0xFFF9B514) : Color(0xFF353E55),
          ),
          label: 'Home', // This ensures the label is always displayed
        ),
        BottomNavigationBarItem(
          icon: Icon(
            AntDesign.calendar_outline,
            color: _selectedIndex == 1 ? Color(0xFFF9B514) : Color(0xFF353E55),
          ),
          label: 'Order', // This ensures the label is always displayed
        ),
        BottomNavigationBarItem(
          icon: Icon(
            AntDesign.message_outline,
            color: _selectedIndex == 2 ? Color(0xFFF9B514) : Color(0xFF353E55),
          ),
          label: 'Chats', // This ensures the label is always displayed
        ),
        BottomNavigationBarItem(
          icon: badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: AppColors.YELLOW),
            badgeContent: Text(
                '${trayProvider.trayItems.fold<int>(0, (totalQuantity, item) => totalQuantity + item.amount)}',
                style: TextStyle(
                    color: AppColors.BLUE)), // Correct usage of badgeContent
            child: Icon(
              AntDesign.inbox_outline,
              color:
                  _selectedIndex == 3 ? Color(0xFFF9B514) : Color(0xFF353E55),
            ),
          ),
          label: 'Tray', // Ensures the label is always displayed
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_rounded,
            color: _selectedIndex == 4 ? Color(0xFFF9B514) : Color(0xFF353E55),
          ),
          label: 'Profile', // This ensures the label is always displayed
        ),
      ],
      currentIndex: _selectedIndex, // Set the current index
      selectedItemColor: Color(0xFFF9B514),
      unselectedItemColor: Color(0xFF353E55),
      onTap: _onItemTapped, // Handle item taps
    );
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({required WidgetBuilder builder})
      : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child; // No animation effect
  }
}
