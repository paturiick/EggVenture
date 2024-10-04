import 'package:eggventure/screens/chat_screen.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/screens/order_screen.dart';
import 'package:eggventure/screens/profile_screen.dart';
import 'package:eggventure/screens/signin_screen.dart';
import 'package:eggventure/screens/tray_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const SIGNIN = '/signin';
  static const SIGNUP = '/sigup';
  static const HOMESCREEN = '/home-screen';
  static const ORDERSCREEN = '/order-screen';
  static const CHATSCREEN = '/chat-screen';
  static const TRAYSCREEN = '/tray-screen';
  static const PROFILESCREEN  = '/profile-screen';

    static Map<String, WidgetBuilder> define() {
    return {
      SIGNIN: (context) => SigninScreen(),
      HOMESCREEN: (context) => HomeScreen(),
      ORDERSCREEN: (context) => OrderScreen(),
      CHATSCREEN: (context) => ChatScreen(),
      TRAYSCREEN: (context) => TrayScreen(),
      PROFILESCREEN: (context) => ProfileScreen(),
    };  
  }
}