
import 'package:flutter/material.dart';
import 'package:eggventure/widgets/navigation_bar_farmer.dart';

class ChatScreenFarmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Color(0xFFF9B514),
      title: Text(
        'CHATS',
        style: TextStyle(
          fontFamily: 'AvenirNextCyr',
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Color(0xFF353E55),
        ),
      ),
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )
        ),
      ),
    ),
    bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 3),
    );
  }
}   
  
