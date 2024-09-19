import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/checkout%20screens/pickup_checkout_screen.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/splash_screen.dart';
import 'package:eggventure/store_screen/wf_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarBrightness: Brightness.dark));
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
      home: WfScreen(),
    );
  }
}
