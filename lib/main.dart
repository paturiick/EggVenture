import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:eggventure/providers/edit_profile_provider.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firebase_options.dart';
import 'package:eggventure/providers/buy_now_provider.dart';
import 'package:eggventure/providers/user_info_provider.dart';
import 'package:eggventure/routes/pages.dart';
import 'package:eggventure/pages/consumer_screens/login/signin_screen.dart';
import 'package:eggventure/widgets/loading_screen.dart/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
      
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase Initialized Successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddToTrayProvider()),
        ChangeNotifierProvider(create: (_) => BuyNowProvider()),
        ChangeNotifierProvider(create: (_) => UserInfoProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider())
      ],
      child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppPages.getRoutes(), // Define app routes
      theme: ThemeData(
        fontFamily: 'AvenirNextCyr',
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.YELLOW,
          cursorColor: AppColors.YELLOW,
          selectionHandleColor: AppColors.YELLOW
        )
      ),
      home: SplashScreen()
    );
  }
}
