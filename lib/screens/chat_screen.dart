import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.YELLOW,
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
            child: GestureDetector(
              onTap: () {
                //search here for people
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.BLUE),
                ),
                child: Row(
                  children: [
                    Icon(AntDesign.search_outline, color: AppColors.BLUE),
                    SizedBox(width: 10),
                    Text(
                      "Search",
                      style: TextStyle(color: AppColors.BLUE),
                    )
                  ],
                ),
              ),
            )),
        bottomNavigationBar: NavigationBarWidget(currentIndex: 2),
      ),
    );
  }
}
