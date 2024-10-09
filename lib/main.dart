import 'package:eggventure/farmer%20interface/home_screen.dart';
import 'package:eggventure/firebase/firebase_options.dart';
import 'package:eggventure/routes/pages.dart';
import 'package:eggventure/screens/chat%20screens/chat_screen.dart';
import 'package:eggventure/screens/login%20screens/signin_screen.dart';
import 'package:eggventure/screens_farmer/home_screen_farmer.dart';
import 'package:eggventure/screens/login%20screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  runApp(const MyApp());
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
      home: ChatScreen(), // Show splash screen on startup
    );
  }
}
