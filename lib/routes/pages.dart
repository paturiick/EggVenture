import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/chat%20screens/white_feathers_chat_screen.dart';
import 'package:eggventure/screens/chat%20screens/chat_screen.dart';
import 'package:eggventure/screens/checkout%20screens/address%20edit/edit_address_screen.dart';
import 'package:eggventure/screens/checkout%20screens/delivery_checkout_screen.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/screens/order_screen.dart';
import 'package:eggventure/screens/profile_screen.dart';
import 'package:eggventure/screens/profile_screen_review.dart';
import 'package:eggventure/screens/login%20screens/signup_screen.dart';
import 'package:eggventure/screens/tray_screen.dart';
import 'package:eggventure/screens/verification_screen.dart';
import 'package:eggventure/screens_farmer/add_product_screen_farmer.dart';
import 'package:eggventure/screens_farmer/chat_screen_farmer.dart';
import 'package:eggventure/screens_farmer/home_screen_farmer.dart';
import 'package:eggventure/screens_farmer/order_screen_farmer.dart';
import 'package:eggventure/screens_farmer/profile_screen_farmer.dart';
import 'package:eggventure/screens_farmer/start_selling_screens/business_information_screen.dart';
import 'package:eggventure/screens_farmer/start_selling_screens/shop_information_screen.dart';
import 'package:eggventure/store_screen/daily_fresh_screen.dart';
import 'package:eggventure/store_screen/pabilona_screen.dart';
import 'package:eggventure/store_screen/pelonio_screen.dart';
import 'package:eggventure/store_screen/sundo_screen.dart';
import 'package:eggventure/store_screen/vista_screen.dart';
import 'package:eggventure/store_screen/white_feathers_screen.dart';
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
