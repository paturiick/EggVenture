import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens_farmer/order_screen_farmer.dart';
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
          fontFamily: 'AvenirNextCyr', scaffoldBackgroundColor: Colors.white,),
          
      home: OrderScreenFarmer(),
    );
  }
}
