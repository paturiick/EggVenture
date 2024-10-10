import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/consumer_screens/chat_consumer/white_feathers_chat_screen.dart';
import 'package:eggventure/screens/consumer_screens/chat_consumer/chat_screen.dart';
import 'package:eggventure/screens/consumer_screens/checkout_consumer/address%20edit/edit_address_screen.dart';
import 'package:eggventure/screens/consumer_screens/checkout_consumer/delivery_checkout_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/home_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/order_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/profile_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/profile_screen_review.dart';
import 'package:eggventure/screens/consumer_screens/login/signup_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/tray_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/verification_screen.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/add_product_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/chat_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/home_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/order_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/profile_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/start_selling_farmer/business_information_screen.dart';
import 'package:eggventure/screens/farmer_screens/start_selling_farmer/shop_information_screen.dart';
import 'package:eggventure/screens/store_screen/daily_fresh_screen.dart';
import 'package:eggventure/screens/store_screen/pabilona_screen.dart';
import 'package:eggventure/screens/store_screen/pelonio_screen.dart';
import 'package:eggventure/screens/store_screen/sundo_screen.dart';
import 'package:eggventure/screens/store_screen/vista_screen.dart';
import 'package:eggventure/screens/store_screen/white_feathers_screen.dart';
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
      AppRoutes.BUSINESSINFO: (context) => BusinessInformationScreen(address: "address", email: "email", phoneNumber: 69, shopName: "shopName"),
      AppRoutes.SHOPINFO: (context) => ShopInformationScreen(),
      AppRoutes.DELIVERYCHECKOUT: (context) => DeliveryCheckoutScreen(),
      AppRoutes.PROFILESCREENREVIEW: (context) => ProfileScreenReview(),
      AppRoutes.DAILYFRESH: (context) => DailyFreshScreen(),
      AppRoutes.PABILONA: (context) => PabilonaScreen(),
      AppRoutes.PELONIO: (context) => PelonioScreen(),
      AppRoutes.SUNDO: (context) => SundoScreen(),
      AppRoutes.VISTA: (context) => VistaScreen(),
      AppRoutes.WHITEFEATHERS: (context) => WhiteFeathersScreen(),
      AppRoutes.CHATFARMER: (context) => ChatScreenFarmer(),
      AppRoutes.ADDPRODUCTFARMER: (context) => AddProductScreenFarmer(),
      AppRoutes.HOMEFARMER: (context) => HomeScreenFarmer(),
      AppRoutes.ORDERFARMER: (context) => OrderScreenFarmer(),
      AppRoutes.PROFILEFARMER: (context) => ProfileScreenFarmer(),
      AppRoutes.EDITADDRESS: (context) => EditAddressScreen(),
      AppRoutes.WHITEFEATHERSCHATSCREEN: (context) => WhiteFeathersChatScreen(),
    };
  }
}
