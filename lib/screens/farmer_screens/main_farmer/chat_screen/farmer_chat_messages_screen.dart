import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';

class FarmerChatMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      )
    );
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.YELLOW,
          title: Text(
            'CHATS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.07, // Responsive font size
              color: AppColors.BLUE,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
              child: GestureDetector(
                onTap: () {
                  // Search functionality
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenWidth * 0.025,
                  ), // Responsive padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        screenWidth * 0.03), // Responsive radius
                    border: Border.all(color: AppColors.BLUE),
                  ),
                  child: Row(
                    children: [
                      Icon(AntDesign.search_outline, color: AppColors.BLUE),
                      SizedBox(width: screenWidth * 0.03), // Responsive spacing
                      Text(
                        "Search",
                        style: TextStyle(
                          color: AppColors.BLUE,
                          fontSize: screenWidth * 0.04, // Responsive font size
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey[600],
              thickness: 1.5,
              indent: 0,
              endIndent: 0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.FARMERCHAT);
              },
              child: Padding(
                padding:
                    EdgeInsets.all(screenWidth * 0.03), // Responsive padding
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.06,
                      backgroundImage:
                          AssetImage("assets/stores/white_feathers.jpg"),
                      backgroundColor: Colors.grey[200],
                    ),
                    SizedBox(
                      width: screenWidth * 0.04, // Responsive spacing
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: screenWidth * 0.02),
                          child: Text(
                            "White Feathers Farm",
                            style: TextStyle(
                              color: AppColors.BLUE,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Last Message should pop up here",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: screenWidth *
                                0.035, // Smaller font for subtitle
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey[600],
              thickness: 1.5,
              indent: 0,
              endIndent: 0,
            ),
          ],
        ),
        bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 3),
      ),
    );
  }
}
