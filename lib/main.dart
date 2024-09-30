import 'package:eggventure/firebase_options.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/screens/order_screen.dart';
import 'package:eggventure/screens/signup_screen.dart';
import 'package:eggventure/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    debugPrint("Firebase initialized Successfully");
  } catch (e) {
    debugPrint("Failed to initialized: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.define(),
      theme: ThemeData(
        fontFamily: 'AvenirNextCyr',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
    );
  }
}
