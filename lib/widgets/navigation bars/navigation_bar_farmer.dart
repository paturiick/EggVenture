import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/home_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/order_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/chat_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/add_product_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/profile_screen_farmer.dart';


class NavigationBarWidgetFarmer extends StatefulWidget {
  final int currentIndex;

  const NavigationBarWidgetFarmer({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _NavigationBarWidgetFarmerState createState() => _NavigationBarWidgetFarmerState();
}

class _NavigationBarWidgetFarmerState extends State<NavigationBarWidgetFarmer> {
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
      HomeScreenFarmer(),
      OrderScreenFarmer(),
      AddProductScreenFarmer(),
      ChatScreenFarmer(),
      ProfileScreenFarmer(),
    ];

    Navigator.of(context).pushAndRemoveUntil(
      NoAnimationMaterialPageRoute(builder: (context) => routes[index]),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _selectedIndex == 0 ? Color(0xFFF9B514) : Color(0xFF353E55),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            AntDesign.calendar_outline,
            color: _selectedIndex == 1 ? Color(0xFFF9B514) : Color(0xFF353E55),
          ),
          label: 'Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box_rounded,
            color: _selectedIndex == 2 ? Color(0xFFF9B514) : Color(0xFF353E55),
            size: 50,
          ),
          label: '',  
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message_outlined, 
            color: _selectedIndex == 3 ? Color(0xFFF9B514) : Color(0xFF353E55),
          ),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_rounded,  
            color: _selectedIndex == 4 ? Color(0xFFF9B514) : Color(0xFF353E55),
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,  
      selectedItemColor: Color(0xFFF9B514),
      unselectedItemColor: Color(0xFF353E55),
      onTap: _onItemTapped,
    );
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({required WidgetBuilder builder})
      : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;  
  }
}
