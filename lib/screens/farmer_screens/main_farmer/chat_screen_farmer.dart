import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatScreenFarmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.YELLOW,
          title: Text(
            'CHATS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: AppColors.BLUE,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: (){
              //search here for people 
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.BLUE),
              ),
              child: Row(
                children: [
                  Icon(AntDesign.search_outline, color: AppColors.BLUE),
                  SizedBox(width: 10),
                  Text("Search",style: TextStyle(
                    color: AppColors.BLUE
                  ),)
                ],
              ),
            ),
          )
          ),
        bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 3),
      ),
    );
  }
}
