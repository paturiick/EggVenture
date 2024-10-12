import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/firebase/firestore_service.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/widgets/overlay/menu.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar.dart';
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  final FirestoreService _service = FirestoreService();
  String? userName;

   @override
    void initState() {
      super.initState();
      fetchUser();
    }

    Future<void> fetchUser() async{
      try {
        final userDetails = await _service.getUserName(); // Fetch user details as a map
        final lastName = userDetails?['lastName'];
        final firstName = userDetails?['firstName'];

        if (firstName != null && lastName != null) {
          setState(() {
            userName = '$firstName $lastName'; // Set userName in setState to update the UI
          });
        }
      } catch (e) {
        print('Error fetching user name: $e');
      }
    }

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
            backgroundColor: AppColors.YELLOW,
            title: Text(
              'MANAGE PROFILE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06, // Responsive font size
                color: AppColors.BLUE,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.menu, color: AppColors.BLUE),
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
                    Navigator.pushNamed(
                      context, AppRoutes.SHOPINFO
                    );
                  },
                  icon: Image.asset(
                    "assets/icons/start_selling.png",
                    height: screenHeight * 0.03,
                  ),
                  label: Text(
                    'Start Selling',
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: AppColors.BLUE,
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
                              color: AppColors.BLUE,
                              size: screenWidth * 0.1,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName ?? '', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.05, // Responsive
                                    color: AppColors.BLUE,
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
                          _buildIconOption(
                              context,
                              Icons.rate_review,
                              'Review',
                              screenWidth, () {
                            Navigator.pushNamed(context, AppRoutes.PROFILESCREENREVIEW);
                          }),
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
        foregroundColor: AppColors.BLUE,
        backgroundColor: AppColors.YELLOW,
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
          fontSize: screenWidth * 0.04,
          color: Color(0xFF353E55),
        ),
      ),
    );
  }

  Widget _buildIconOption(BuildContext context, IconData icon, String text,
      double screenWidth, [VoidCallback? onPressed]) {
    return ElevatedButton(
      onPressed: onPressed ??
          () {
            // Default action if no onPressed is provided
          },
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.BLUE,
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
            color: AppColors.BLUE,
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: AppColors.BLUE,
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
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
            color: AppColors.BLUE,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: AppColors.BLUE,
          ),
        ),
      ],
    );
  }
}
