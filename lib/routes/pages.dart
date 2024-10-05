import 'package:eggventure/overlay_screens/buy%20now/buy_now_screen.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/chat_screen.dart';
import 'package:eggventure/screens/checkout%20screens/delivery_checkout_screen.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/screens/order_screen.dart';
import 'package:eggventure/screens/profile_screen.dart';
import 'package:eggventure/screens/profile_screen_review.dart';
import 'package:eggventure/screens/signup_screen.dart';
import 'package:eggventure/screens/tray_screen.dart';
import 'package:eggventure/screens/verification_screen.dart';
import 'package:eggventure/screens_farmer/start_selling_screens/business_information_screen.dart';
import 'package:eggventure/screens_farmer/start_selling_screens/shop_information_screen.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.SIGNIN: (context) => SignupScreen(),
      AppRoutes.SIGNUP: (context) => SignupScreen(),
      AppRoutes.VERIFICATIONSCREEN: (context) => VerificationScreen(),
      AppRoutes.CHATSCREEN: (context) => ChatScreen(),
      AppRoutes.HOMESCREEN: (context) => HomeScreen(),
      AppRoutes.ORDERSCREEN: (context) => OrderScreen(),
      AppRoutes.TRAYSCREEN: (context) => TrayScreen(),
      AppRoutes.PROFILESCREEN: (context) => ProfileScreen(),
      AppRoutes.BUSINESSINFO: (context) => BusinessInformationScreen(),
      AppRoutes.DELIVERYCHECKOUT: (context) => DeliveryCheckoutScreen(),
      AppRoutes.SHOPINFO: (context) => ShopInformationScreen(),
      AppRoutes.PROFILESCREENREVIEW: (context) => ProfileScreenReview(),
      
    };
  }
}
