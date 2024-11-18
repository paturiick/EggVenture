import 'dart:convert';

import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/providers/edit_profile_provider.dart';
import 'package:eggventure/services/facebook/facebook_auth_service.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firebase_auth_service.dart';
import 'package:eggventure/services/firebase/firebase%20storage/firebase_profile_picture.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/widgets/loading_screen.dart/shimmer_effect.dart';
import 'package:eggventure/widgets/profile%20widget/share_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/widgets/overlay%20widgets/menu.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirestoreService _service = FirestoreService();
  final ChangeProfilePicture _changeProfilePicture = ChangeProfilePicture();
  final ShimmerEffect _shimmerEffect = ShimmerEffect();
  final ShareProfile shareProfile = ShareProfile();
  final FacebookAuthService _facebookAuthService = FacebookAuthService();

  bool _isLoading = true;
  bool _hasFetchedData = false;
  bool _isFacebookLogin = false;

  String? userName;
  String? _uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    if (!_hasFetchedData) {
      _fetchUserProfile();
    }
  }

  Future<void> _fetchUserProfile() async {
    if (_hasFetchedData) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final isFacebookLogin = await _facebookAuthService.isFacebookLoggedIn();
    if (isFacebookLogin && !_isFacebookLogin) {
      final facebookData =
          await _facebookAuthService.loginWithFacebook(context);

      if (facebookData != null) {
        setState(() {
          _isFacebookLogin = true;
          userName = facebookData['name'];
          _uploadedImageUrl = facebookData['picture']['data']['url'];
        });
      }
    } else {
      await getUserName();
      await loadProfilePictureUrl();
    }

    setState(() {
      _isLoading = false; // Stop loading screen
      _hasFetchedData = true; // Set only after the fetch is complete
    });
  }

  Future<void> getUserName() async {
    try {
      final uid = _service.getCurrentUserId();
      final userDetails = await _service.getBasedOnId('userDetails', uid);
      final firstName = userDetails['firstName'];
      final lastName = userDetails['lastName'];
      userName = '$firstName $lastName';
    } catch (e) {
      print('$e');
    }
  }

  Future<void> saveUserImageUrl(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userImageUrl', imageUrl);
  }

  Future<String?> loadUserImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userImageUrl');
  }

  Future<void> saveProfilePictureUrl(String imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('profileImageUrl', imageUrl);
  }

  Future<void> loadProfilePictureUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _uploadedImageUrl = preferences.getString('profileImageUrl');
    });
  }

  Future<void> _updateProfilePicture() async {
    await _changeProfilePicture.changeProfilePicture(context);
    final newImageUrl = _changeProfilePicture.uploadedImageUrl;

    // Save and display the new profile picture if a new image is selected
    if (newImageUrl != null) {
      await saveUserImageUrl(newImageUrl); // Store the URL in SharedPreferences
      setState(() {
        _uploadedImageUrl =
            newImageUrl; // Update the UI to reflect the new image
      });
    } else {
      // Show error message if image upload fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.YELLOW,
          content: Text(
            "Failed to retrieve the new Profile Picture",
            style: TextStyle(color: AppColors.BLUE),
          ),
        ),
      );
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
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.YELLOW,
            title: Text(
              'MANAGE PROFILE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06,
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
          body: _isLoading
              ? _shimmerEffect.buildShimmerEffect(screenWidth, screenHeight)
              : _buildProfileContent(screenWidth, screenHeight),
          bottomNavigationBar: NavigationBarWidget(currentIndex: 4),
        ),
      ),
    );
  }

  Widget buildProfilePicture(double screenWidth) {
    return Consumer<EditProfileProvider>(
      builder: (context, userImageProvider, child) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            // Display the profile picture from the provider or a default icon
            CircleAvatar(
              radius: screenWidth * 0.15,
              backgroundImage: userImageProvider.imageUrl.isNotEmpty
                  ? NetworkImage(userImageProvider.imageUrl)
                  : null,
              backgroundColor: Colors.grey[200],
              child: userImageProvider.imageUrl.isEmpty
                  ? Icon(
                      Icons.person,
                      color: AppColors.BLUE,
                      size: screenWidth * 0.1,
                    )
                  : null,
            ),

            // Edit icon to trigger profile picture update
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  await _changeProfilePicture.changeProfilePicture(context);
                  final newImageUrl = _changeProfilePicture.uploadedImageUrl;

                  // Update both the provider and UI with the new image URL
                  if (newImageUrl != null) {
                    await saveProfilePictureUrl(newImageUrl);
                    userImageProvider
                        .updateImageUrl(newImageUrl); // Update provider
                    setState(() {
                      _uploadedImageUrl = newImageUrl;
                    });
                  } else {
                    // Show error message if image upload fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.YELLOW,
                        content: Text(
                          "Failed to retrieve the new Profile Picture",
                          style: TextStyle(color: AppColors.BLUE),
                        ),
                      ),
                    );
                  }
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.YELLOW,
                  radius: screenWidth * 0.05,
                  child: Icon(
                    Icons.edit,
                    color: AppColors.BLUE,
                    size: screenWidth * 0.04,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget _buildProfileContent(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.01,
          right: screenWidth * 0.05,
          child: ElevatedButton.icon(
            onPressed: () async {
              debugPrint('button clicked');
              final String uid = _service.getCurrentUserId();
              final userDetails = await _service.getBasedOnId('userDetails', uid);

              userDetails['isSeller'] ? Navigator.pushNamed(context, AppRoutes.HOMEFARMER) : Navigator.pushNamed(context, AppRoutes.SHOPINFO);
              
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
              side: BorderSide(color: AppColors.BLUE),
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
                    buildProfilePicture(screenWidth),
                    SizedBox(width: screenWidth * 0.05),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                              color: AppColors.BLUE,
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
                              _buildStatusColumn('Followers', '0', screenWidth),
                              SizedBox(width: screenWidth * 0.1),
                              _buildStatusColumn('Following', '0', screenWidth),
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
                    _buildProfileOption(context, 'Edit Profile', screenWidth,
                        () {
                      Navigator.pushNamed(context, AppRoutes.EDITPROFILE);
                    }),
                    _buildProfileOption(context, 'Share Profile', screenWidth,
                        () {
                      shareProfile.showShareProfileDialog(
                          context,
                          'https://www.exampledomain.com/${userName}',
                          getUserName);
                    }),
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
                      screenWidth,
                      () {
                        Navigator.pushNamed(
                            context, AppRoutes.PROFILESCREENREVIEW);
                      },
                    ),
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
    );
  }

  Widget _buildProfileOption(BuildContext context, String text,
      double screenWidth, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
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
          color: AppColors.BLUE,
        ),
      ),
    );
  }

  Widget _buildIconOption(
      BuildContext context, IconData icon, String text, double screenWidth,
      [VoidCallback? onPressed]) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
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