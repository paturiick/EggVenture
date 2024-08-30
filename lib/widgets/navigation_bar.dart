import 'package:eggventure/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
// Import other screens as needed

class NavigationBarWidget extends StatefulWidget {
  final int currentIndex;
  
  const NavigationBarWidget({
    Key? key,
    required this.currentIndex
  });
  
  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {

  late int _selectedIndex;

  @override
  void initState(){
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
       _selectedIndex = index;
    });


     // Navigate based on the selected index
    final routes = [
      AppRoutes.HOMESCREEN,
      AppRoutes.ORDERSCREEN,
      AppRoutes.CHATSCREEN,
      AppRoutes.TRAYSCREEN,
      AppRoutes.PROFILESCREEN,
    ];

    Navigator.pushNamed(context, routes[index]);
    // // Handle navigation based on the selected index
    // switch (_selectedIndex) {
    //   case 0:
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => HomeScreen()),
    //     );
    //     break;
    //   case 1:
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => OrderScreen()),
    //     );
    //     break;

    //   case 2:
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => ChatScreen()),
    //     );
    //     break;

    //   case 3:
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => TrayScreen()),
    //     );
    //     break;

    //   case 4:
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => ProfileScreen()),
    //     );
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _selectedIndex == 0 ? Color(0xFFF9B514) : Color(0xFF353E55), // Change color based on selection
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            AntDesign.calendar_outline,
            color: _selectedIndex == 1 ? Color(0xFFF9B514) : Color(0xFF353E55), // Change color based on selection
          ),
          label: 'Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            AntDesign.message_outline,
            color: _selectedIndex == 2 ? Color(0xFFF9B514) : Color(0xFF353E55), // Change color based on selection
          ),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            AntDesign.inbox_outline,
            color: _selectedIndex == 3 ? Color(0xFFF9B514) : Color(0xFF353E55), // Change color based on selection
          ),
          label: 'Tray',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: _selectedIndex == 4 ? Color(0xFFF9B514) : Color(0xFF353E55), // Change color based on selection
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex, // Set the current index
      selectedItemColor: Color(0xFFF9B514),
      unselectedItemColor: Color(0xFF353E55),
      onTap: _onItemTapped, // Handle item taps
    );
  }
}