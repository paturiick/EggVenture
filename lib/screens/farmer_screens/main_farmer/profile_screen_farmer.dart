import 'package:eggventure/controller/image_picker_controller.dart';
import 'package:eggventure/firebase/firestore_service.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/profile_screen.dart';
import 'package:eggventure/widgets/image%20picker%20widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/widgets/overlay%20widgets/menu.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_farmer.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenFarmer extends StatefulWidget {
  @override
  _ProfileScreenFarmerState createState() => _ProfileScreenFarmerState();
}

class _ProfileScreenFarmerState extends State<ProfileScreenFarmer> {
  final FirestoreService _service = FirestoreService();
  String? shopName;
  final ImagePickerController _imagePickerController = ImagePickerController();
  XFile? imageFile;

  void imageSelection(ImageSource source) async{
    final XFile? pickedFile = await _imagePickerController.pickImage(source);
    setState(() {
      imageFile = pickedFile;
    });
  }

  @override
    void initState(){
      super.initState();
      getShopName();
  }

   Future<void> getShopName() async {
    try {
      final uid = _service.getCurrentUserId();
      final shopDetails = await _service.getBasedOnId('businessDetails', uid);
      
      final shopNameDb = shopDetails['shopName'];
      setState(() {
        shopName = '$shopNameDb';
      });
    } catch (e) {
      return null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    
    return Scaffold(
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
                Navigator.pushReplacementNamed(context, AppRoutes.PROFILESCREEN);
              },
              icon: Icon(Icons.local_mall,
                  size: screenWidth * 0.04, color: Color(0xFF353E55)),
              label: Text(
                'Back to Buying',
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
                        onPressed: () => ImagePickerWidget.showMenu(context),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Colors.grey[200],
                          padding: EdgeInsets.all(screenWidth * 0.1),
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          color: Color(0xFF353E55),
                          size: screenWidth * 0.1,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shopName ?? '',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.05, // Responsive size
                                color: Color(0xFF353E55),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                  size: screenWidth * 0.06,
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
                      _buildProfileOption(context, 'Edit Profile', screenWidth),
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
                          context, Icons.rate_review, 'Review', screenWidth),
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
      bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 4),
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
