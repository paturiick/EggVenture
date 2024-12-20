import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/providers/edit_profile_provider.dart';
import 'package:eggventure/services/firebase/firebase%20storage/firebase_profile_picture.dart';
import 'package:eggventure/widgets/confirmation/logout_confirmation.dart';
import 'package:eggventure/widgets/loading_screen.dart/shimmer_effect.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_admin.dart';
import 'package:eggventure/widgets/overlay%20widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AdminProfileScreen extends StatefulWidget {
  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  final ChangeProfilePicture _changeProfilePicture = ChangeProfilePicture();
  final ShimmerEffect _shimmerEffect = ShimmerEffect();

  bool _isLoading = true;
  String? _uploadedImageUrl;
  String? _role = "Administrator";
  String? _lastLogin = "";

  @override
  void initState() {
    super.initState();
    loadProfilePictureUrl();
    loadLastLogin();
  }

  Future<void> saveProfilePictureUrl(String imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('profileImageUrl', imageUrl);
  }

  Future<void> loadProfilePictureUrl() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        _uploadedImageUrl = preferences.getString('profileImageUrl');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.YELLOW,
          content: Text(
            "Error loading profile picture.",
            style: TextStyle(color: AppColors.BLUE),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> loadLastLogin() async {
    // Mock data: Replace with real last login retrieval logic.
    setState(() {
      _lastLogin = DateFormat.yMd().add_jm().format(DateTime.now());
    });
  }

  Future<void> _updateProfilePicture() async {
    setState(() => _isLoading = true);
    await _changeProfilePicture.changeProfilePicture(context);
    final newImageUrl = _changeProfilePicture.uploadedImageUrl;
    if (newImageUrl != null) {
      await saveProfilePictureUrl(newImageUrl);
      setState(() {
        _uploadedImageUrl = newImageUrl;
      });
      Provider.of<EditProfileProvider>(context, listen: false)
          .updateImageUrl(newImageUrl);
    } else {
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
    setState(() => _isLoading = false);
  }

  Future<void> _logout() async {
    // Implement logout functionality here.
    LogoutConfirmation.showLogOutConfirmation(context);
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
              'ADMIN PROFILE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06,
                color: AppColors.BLUE,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.YELLOW.withOpacity(0.8),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: _isLoading
                ? _shimmerEffect.buildShimmerEffect(screenWidth, screenHeight)
                : Center(
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildProfileCard(screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.03),
                          _buildProfileOption(
                            context,
                            'Edit Profile',
                            screenWidth,
                            () {
                              // Navigate to edit profile screen
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildProfileOption(
                            context,
                            'Logout',
                            screenWidth,
                            _logout,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          bottomNavigationBar: NavigationBarAdmin(currentIndex: 2),
        ),
      ),
    );
  }

  Widget buildProfileCard(double screenWidth, double screenHeight) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            buildProfilePicture(screenWidth),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'admin',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                color: AppColors.BLUE,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'Role: $_role',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: AppColors.BLUE,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'Last Login: $_lastLogin',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.grey[600],
              ),
            ),
          ],
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
            Positioned(
              bottom: 0,
              right: 0,
              child: Tooltip(
                message: 'Edit Profile Picture',
                child: GestureDetector(
                  onTap: _updateProfilePicture,
                  child: CircleAvatar(
                    backgroundColor: AppColors.YELLOW,
                    radius: screenWidth * 0.05,
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: AppColors.BLUE, strokeWidth: 2)
                        : Icon(
                            Icons.edit,
                            color: AppColors.BLUE,
                            size: screenWidth * 0.04,
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileOption(BuildContext context, String text,
      double screenWidth, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 8,
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
}
