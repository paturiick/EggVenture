import 'package:eggventure/screens_farmer/start_selling_screens/shop_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/overlay_screens/menu_screen.dart';
import 'package:eggventure/widgets/navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFFFB612),
            title: Text(
              'MANAGE PROFILE',
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06, // Responsive font size
                color: Color(0xFF353E55),
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.menu, color: Color(0xFF353E55)),
                onPressed: () {
                  MenuScreen.showMenu(context);
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned(
                top: screenHeight * 0.01,
                right: screenWidth * 0.05,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopInformationScreen()),
                    );
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/start_selling.svg",
                    height: screenHeight * 0.02,
                  ),
                  label: Text(
                    'Start Selling',
                    style: TextStyle(
                      fontFamily: 'AvenirNextCyr',
                      fontSize: screenWidth * 0.03,
                      color: Color(0xFF353E55),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.005,
                    ),
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: screenHeight * 0.1,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle add new picture action here
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Colors.grey[200],
                              padding: EdgeInsets.all(screenWidth * 0.1),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Color(0xFF353E55),
                              size: screenWidth * 0.1, // Responsive icon size
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '', // Empty string for name
                                  style: TextStyle(
                                    fontFamily: 'AvenirNextCyr',
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.05, // Responsive
                                    color: Color(0xFF353E55),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star_border,
                                      color: Colors.grey,
                                      size:
                                          screenWidth * 0.06, // Responsive size
                                    );
                                  }),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Row(
                                  children: [
                                    _buildStatusColumn(
                                        'Followers', '0', screenWidth),
                                    SizedBox(width: screenWidth * 0.1),
                                    _buildStatusColumn(
                                        'Following', '0', screenWidth),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildProfileOption(
                              context, 'Edit Profile', screenWidth),
                          _buildProfileOption(
                              context, 'Share Profile', screenWidth),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.grey, thickness: 1),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconOption(
                              context, Icons.payment, 'To Pay', screenWidth),
                          _buildIconOption(context, AntDesign.sync_outline,
                              'Processing', screenWidth),
                          _buildIconOption(context, Icons.rate_review, 'Review',
                              screenWidth),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.grey, thickness: 1),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        height: screenHeight * 0.5,
                        child: ListView.builder(
                          itemCount: 0,
                          itemBuilder: (context, index) {
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: NavigationBarWidget(currentIndex: 4),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      BuildContext context, String text, double screenWidth) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press action here
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFF353E55),
        backgroundColor: Color(0xFFFFB612),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.07,
          vertical: screenWidth * 0.03,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'AvenirNextCyr',
          fontSize: screenWidth * 0.04,
          color: Color(0xFF353E55),
        ),
      ),
    );
  }

  Widget _buildIconOption(
      BuildContext context, IconData icon, String text, double screenWidth) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press action here
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFF353E55),
        backgroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.03,
          horizontal: screenWidth * 0.02,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: screenWidth * 0.1,
            color: Color(0xFF353E55),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'AvenirNextCyr',
              fontSize: screenWidth * 0.035,
              color: Color(0xFF353E55),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusColumn(String label, String value, double screenWidth) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'AvenirNextCyr',
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
            color: Color(0xFF353E55),
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'AvenirNextCyr',
            fontSize: screenWidth * 0.035,
            color: Color(0xFF353E55),
          ),
        ),
      ],
    );
  }
}
