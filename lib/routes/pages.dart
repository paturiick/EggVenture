import 'package:eggventure/pages/consumer_screens/main_consumer/profile%20screens/edit_profile_screen.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/profile%20screens/processing_screen.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/profile%20screens/to_pay_screen.dart';
import 'package:eggventure/pages/search%20screens/home_search_screen.dart';
import 'package:eggventure/pages/search%20screens/tray_search_screen.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/pages/consumer_screens/chat_consumer/user_chat_screen.dart';
import 'package:eggventure/pages/consumer_screens/chat_consumer/chat_screen.dart';
import 'package:eggventure/pages/address%20edit%20screens/delivery_edit_info_screen.dart';
import 'package:eggventure/pages/address%20edit%20screens/pickup_edit_address_screen.dart';
import 'package:eggventure/pages/checkout%20consumer%20screens/delivery_checkout_screen.dart';
import 'package:eggventure/pages/checkout%20consumer%20screens/pickup_checkout_screen.dart';
import 'package:eggventure/pages/consumer_screens/login/forgot_password_screen.dart';
import 'package:eggventure/pages/consumer_screens/login/welcome_screen.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/home_screen.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/order_screen.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/profile%20screens/profile_screen.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/profile%20screens/profile_screen_review.dart';
import 'package:eggventure/pages/consumer_screens/login/signup_screen.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/tray_screen.dart';
import 'package:eggventure/pages/consumer_screens/login/verification_screen.dart';
import 'package:eggventure/pages/farmer%20screens/main_farmer/add_product_screen_farmer.dart';
import 'package:eggventure/pages/farmer%20screens/main_farmer/chat_screen/farmer_chat_messages_screen.dart';
import 'package:eggventure/pages/farmer%20screens/main_farmer/chat_screen/farmer_chat_screen.dart';
import 'package:eggventure/pages/farmer%20screens/main_farmer/home_screen_farmer.dart';
import 'package:eggventure/pages/farmer%20screens/main_farmer/order_screen_farmer.dart';
import 'package:eggventure/pages/farmer%20screens/start_selling_farmer/business_information_screen.dart';
import 'package:eggventure/pages/farmer%20screens/start_selling_farmer/shop_information_screen.dart';
import 'package:eggventure/pages/store%20screens/daily_fresh_screen.dart';
import 'package:eggventure/pages/store%20screens/pabilona_screen.dart';
import 'package:eggventure/pages/store%20screens/pelonio_screen.dart';
import 'package:eggventure/pages/store%20screens/sundo_screen.dart';
import 'package:eggventure/pages/store%20screens/vista_screen.dart';
import 'package:eggventure/pages/store%20screens/white_feathers_screen.dart';
import 'package:flutter/material.dart';

import '../pages/farmer screens/main_farmer/farmer profile/farmer_edit_profile_screen.dart';
import '../pages/farmer screens/main_farmer/farmer profile/profile_screen_farmer.dart';

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
      AppRoutes.SHOPINFO: (context) => ShopInformationScreen(
            shopInformationId: 'shopInformationId',),
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
      AppRoutes.PICKUPEDITINFO: (context) => PickupEditInfoScreen(),
      AppRoutes.FARMERCHATMESSAGES: (context) => FarmerChatMessagesScreen(),
      AppRoutes.FARMERCHAT: (context) => FarmerChatScreen(),
      AppRoutes.WELCOME: (context) => WelcomeScreen(),
      AppRoutes.DELIVERYEDITINFO: (context) => DeliveryEditInfoScreen(),
      AppRoutes.FORGOTPASSWORD: (context) => ForgotPasswordScreen(),
      AppRoutes.HOMESEARCH: (context) => HomeSearchScreen(),
      AppRoutes.TRAYSEARCH: (context) => TraySearchScreen(),
      AppRoutes.EDITPROFILE: (context) => EditProfileScreen(),
      AppRoutes.PROCESSING: (context) => ProcessingScreen(),
      AppRoutes.PAYMENT: (context) => ToPayScreen(),
      AppRoutes.REVIEW: (context) => ProfileScreenReview(),
      AppRoutes.EDITFARMER: (context) => FarmerEditProfileScreen(),
    };
  }
}
