import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/pages/admin%20pages/admin_home_screen.dart';
import 'package:eggventure/pages/admin%20pages/admin_profile_screen.dart';
import 'package:eggventure/pages/admin%20pages/admin_transaction_screen.dart';
import 'package:flutter/material.dart';
class NavigationBarAdmin extends StatefulWidget {
  final int currentIndex;

  const NavigationBarAdmin({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _NavigationBarWidgetFarmerState createState() =>
      _NavigationBarWidgetFarmerState();
}

class _NavigationBarWidgetFarmerState extends State<NavigationBarAdmin> {
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
      AdminHomeScreen(),
      AdminTransactionScreen(),
      AdminProfileScreen()
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
            color: _selectedIndex == 0 ? AppColors.YELLOW : AppColors.BLUE,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt,
            color: _selectedIndex == 1 ? AppColors.YELLOW : AppColors.BLUE,
          ),
          label: 'Transactions',
        ),

        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_rounded,
            color: _selectedIndex == 2 ? AppColors.YELLOW : AppColors.BLUE,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColors.YELLOW,
      unselectedItemColor: AppColors.BLUE,
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
