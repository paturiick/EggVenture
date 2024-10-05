import 'package:eggventure/firebase_options.dart';
import 'package:eggventure/routes/pages.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/screens/order_screen.dart';
import 'package:eggventure/screens/profile_screen.dart';
import 'package:eggventure/screens/signup_screen.dart';
import 'package:eggventure/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; // Ensure to include this for Facebook login

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase before the app starts
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Set the status bar color to white
    statusBarIconBrightness:
        Brightness.dark, // Set the status bar icon color to dark
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppPages.getRoutes(),
      theme: ThemeData(
        fontFamily: 'AvenirNextCyr', // Set custom font
        scaffoldBackgroundColor: Colors.white, // Set background color to white
      ),
      home: ProfileScreen(), // Show splash screen on startup
    );
  }
}
