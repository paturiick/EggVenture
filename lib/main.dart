import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:eggventure/firebase/firebase_options.dart';
import 'package:eggventure/providers/buy_now_provider.dart';
import 'package:eggventure/routes/pages.dart';
import 'package:eggventure/screens/consumer_screens/login/splash_screen.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/home_screen.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/home_screen_farmer.dart';
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
        ChangeNotifierProvider(create: (_) => BuyNowProvider())
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
      ),
      home: SplashScreen()
    );
  }
}
