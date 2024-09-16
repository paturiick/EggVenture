import 'package:eggventure/routes/routes.dart';
<<<<<<< HEAD
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/splash_screen.dart';
import 'package:eggventure/store_screen/wf_screen.dart';
import 'package:eggventure/welcome_screen.dart';
=======
import 'package:eggventure/screens_farmer/order_screen_farmer.dart';
>>>>>>> fddf08861841baa5c1b80c8f777b4178187c1e2e
import 'package:flutter/material.dart';

void main() {
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
<<<<<<< HEAD
        fontFamily: 'AvenirNextCyr',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
=======
          fontFamily: 'AvenirNextCyr', scaffoldBackgroundColor: Colors.white,),
          
      home: OrderScreenFarmer(),
>>>>>>> fddf08861841baa5c1b80c8f777b4178187c1e2e
    );
  }
}
