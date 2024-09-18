import 'package:eggventure/screens_farmer/start_selling_screens/shop_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/overlay_screens/menu_screen.dart';
import 'package:eggventure/widgets/navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set the status bar color and icon brightness here
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set your desired status bar color
      statusBarIconBrightness:
          Brightness.dark, // Dark icons for light status bar
    ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white, // White status bar color
        statusBarIconBrightness: Brightness.dark, // Dark icons
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
                fontSize: 20,
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
                top: 10,
                right: 10,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopInformationScreen()),
                    );
                  },
                  icon: Icon(Icons.local_mall,
                      size: 16, color: Color(0xFF353E55)),
                  label: Text(
                    'Start Selling',
                    style: TextStyle(
                      fontFamily: 'AvenirNextCyr',
                      fontSize: 12,
                      color: Color(0xFF353E55),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 80,
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                              padding: EdgeInsets.all(40),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Color(0xFF353E55),
                              size: 40,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '', // Empty string for name
                                  style: TextStyle(
                                    fontFamily: 'AvenirNextCyr',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF353E55),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star_border,
                                      color: Colors.grey,
                                    );
                                  }),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    _buildStatusColumn('Followers', '0'),
                                    SizedBox(width: 40),
                                    _buildStatusColumn('Following', '0'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildProfileOption(context, 'Edit Profile'),
                          _buildProfileOption(context, 'Share Profile'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.grey, thickness: 1),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconOption(context, Icons.payment, 'To Pay'),
                          _buildIconOption(
                              context, AntDesign.sync_outline, 'Processing'),
                          _buildIconOption(
                              context, Icons.rate_review, 'Review'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.grey, thickness: 1),
                      SizedBox(height: 20),
                      Container(
                        height: 400,
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

  Widget _buildProfileOption(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press action here
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFF353E55),
        backgroundColor: Color(0xFFFFB612),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'AvenirNextCyr',
          fontSize: 14,
          color: Color(0xFF353E55),
        ),
      ),
    );
  }

  Widget _buildIconOption(BuildContext context, IconData icon, String text) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press action here
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFF353E55),
        backgroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Color(0xFF353E55),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'AvenirNextCyr',
              fontSize: 14,
              color: Color(0xFF353E55),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'AvenirNextCyr',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF353E55),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'AvenirNextCyr',
            fontSize: 14,
            color: Color(0xFF353E55),
          ),
        ),
      ],
    );
  }
}
