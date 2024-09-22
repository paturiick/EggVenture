import 'package:eggventure/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
          padding: EdgeInsets.all(10.0),
          child: TextField(
            cursorColor: Color(0xFFF9B514),
            decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(AntDesign.search_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFF9B514)))),
            style: TextStyle(color: Color(0xFF353E55)),
          ),
        ),
        bottomNavigationBar: NavigationBarWidget(currentIndex: 2),
      ),
    );
  }
}
