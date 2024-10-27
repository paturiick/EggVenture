import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/consumer_screens/chat_consumer/user_chat_screen.dart';
import 'package:eggventure/screens/consumer_screens/chat_consumer/chat_screen.dart';
import 'package:eggventure/screens/address%20edit/delivery_edit_address_screen.dart';
import 'package:eggventure/screens/address%20edit/pickup_edit_address_screen.dart';
import 'package:eggventure/screens/checkout_consumer/delivery_checkout_screen.dart';
import 'package:eggventure/screens/checkout_consumer/pickup_checkout_screen.dart';
import 'package:eggventure/screens/consumer_screens/login/welcome_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/home_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/order_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/profile_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/profile_screen_review.dart';
import 'package:eggventure/screens/consumer_screens/login/signup_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/tray_screen.dart';
import 'package:eggventure/screens/consumer_screens/login/verification_screen.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/add_product_screen_farmer.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/chat_screen/farmer_chat_messages_screen.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/chat_screen/farmer_chat_screen.dart';
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
import 'package:eggventure/widgets/add%20to%20tray%20widgets/clear_tray_items.dart';
import 'package:eggventure/widgets/terms%20&%20conditions/terms_conditions.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.SIGNIN: (context) => SignupScreen(),
      AppRoutes.SIGNUP: (context) => SignupScreen(),
      AppRoutes.VERIFICATIONSCREEN: (context) => VerificationScreen(),
      AppRoutes.CHATSCREEN: (context) => ChatScreen(),
      AppRoutes.USERCHAT: (context) => UserChatScreen(),
      AppRoutes.HOMESCREEN: (context) => HomeScreen(),
      AppRoutes.ORDERSCREEN: (context) => OrderScreen(),
      AppRoutes.TRAYSCREEN: (context) => TrayScreen(),
      AppRoutes.PROFILESCREEN: (context) => ProfileScreen(),
      AppRoutes.BUSINESSINFO: (context) => BusinessInformationScreen(address: "address", email: "email", phoneNumber: 69, shopName: "shopName"),
      AppRoutes.SHOPINFO: (context) => ShopInformationScreen(),
      AppRoutes.DELIVERYCHECKOUT: (context) => DeliveryCheckoutScreen(),
      AppRoutes.PICKUPCHECKOUT: (context) => PickupCheckoutScreen(),
      AppRoutes.PROFILESCREENREVIEW: (context) => ProfileScreenReview(),
      AppRoutes.DAILYFRESH: (context) => DailyFreshScreen(),
      AppRoutes.PABILONA: (context) => PabilonaScreen(),
      AppRoutes.PELONIO: (context) => PelonioScreen(),
      AppRoutes.SUNDO: (context) => SundoScreen(),
      AppRoutes.VISTA: (context) => VistaScreen(),
      AppRoutes.WHITEFEATHERS: (context) => WhiteFeathersScreen(),
      AppRoutes.ADDPRODUCTFARMER: (context) => AddProductScreenFarmer(),
      AppRoutes.HOMEFARMER: (context) => HomeScreenFarmer(),
      AppRoutes.ORDERFARMER: (context) => OrderScreenFarmer(),
      AppRoutes.PROFILEFARMER: (context) => ProfileScreenFarmer(),
      AppRoutes.PICKUPEDITADDRESS: (context) => PickupEditAddressScreen(),
      AppRoutes.FARMERCHATMESSAGES: (context) => FarmerChatMessagesScreen(),
      AppRoutes.FARMERCHAT: (context) => FarmerChatScreen(),
      AppRoutes.WELCOME: (context) => WelcomeScreen(),
      AppRoutes.DELIVERYEDITADDRESS: (context) => DeliveryEditAddressScreen(),
    };
  }
}
