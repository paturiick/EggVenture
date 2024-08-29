import 'package:eggventure/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}