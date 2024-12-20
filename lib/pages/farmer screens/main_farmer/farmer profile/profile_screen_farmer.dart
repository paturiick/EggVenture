import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/image_picker_controller.dart';
import 'package:eggventure/providers/edit_profile_provider.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/services/firebase/firebase%20storage/firebase_farmer_profile_picture.dart';
import 'package:eggventure/widgets/image%20picker%20widget/image_picker_widget.dart';
import 'package:eggventure/widgets/loading_screen.dart/shimmer_effect.dart';
import 'package:eggventure/widgets/profile%20widget/share_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/widgets/overlay%20widgets/menu.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_farmer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenFarmer extends StatefulWidget {
  @override
  _ProfileScreenFarmerState createState() => _ProfileScreenFarmerState();
}

class _ProfileScreenFarmerState extends State<ProfileScreenFarmer> {
  final FirestoreService _service = FirestoreService();
  final ImagePickerController _imagePickerController = ImagePickerController();
  final ShareProfile shareProfile = ShareProfile();
  final ShimmerEffect _shimmerEffect = ShimmerEffect();
  final ChangeFarmerProfilePicture _changeFarmerProfilePicture =
      ChangeFarmerProfilePicture();

  String? shopName;
  String? _uploadedImageUrl;

  bool _isLoading = true;

  XFile? imageFile;

  void imageSelection(ImageSource source) async {
    final XFile? pickedFile = await _imagePickerController.pickImage(source);
    setState(() {
      imageFile = pickedFile;
    });
  }

  Future<void> getTotal() async {
    final uid = _service.getCurrentUserId();
    final sales = await _service.dbFirestore
        .collection('transactions')
        .where('businessId', isEqualTo: uid)
        .get();
    sales.docs.forEach((doc) {
      print(doc.data());
    });
  }

  @override
  void initState() {
    super.initState();
    getShopName();
    getTotal();
  }

  Future<void> getShopName() async {
    try {
      final uid = _service.getCurrentUserId();
      final shopDetails = await _service.getBasedOnId('businessDetails', uid);

      final shopNameDb = shopDetails['shopName'];
      setState(() {
        shopName = '$shopNameDb';
        _isLoading = false;
      });
    } catch (e) {
      return null;
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

  Future<void> getUserName() async {
    try {
      final uid = _service.getCurrentUserId();
      final userDetails = await _service.getBasedOnId('userDetails', uid);
      var shopName = userDetails['shopName'];
      shopName = '$shopName';
    } catch (e) {
      print('$e');
    }
  }

  Future<void> _updateProfilePicture() async {
    await _changeFarmerProfilePicture.changeFarmerProfilePicture(context);
    final newImageUrl = _changeFarmerProfilePicture.uploadedImageUrl;
    if (newImageUrl != null) {
      await saveUserImageUrl(newImageUrl);
      setState(() {
        _uploadedImageUrl = newImageUrl;
      });
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
          bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 4),
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

            // Edit icon to trigger profile picture update
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  await _changeFarmerProfilePicture
                      .changeFarmerProfilePicture(context);
                  final newImageUrl =
                      _changeFarmerProfilePicture.uploadedImageUrl;

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
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.PROFILESCREEN);
            },
            icon: Icon(AntDesign.shopping_fill,
                size: screenWidth * 0.04, color: AppColors.BLUE),
            label: Text(
              'Back to Buying',
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
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
                            shopName ?? '',
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
                      Navigator.pushNamed(context, AppRoutes.EDITFARMER);
                    }),
                    _buildProfileOption(context, 'Share Profile', screenWidth,
                        () {
                      shareProfile.showShareProfileDialog(
                          context,
                          'https://www.exampledomain.com/${shopName}',
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
                        context,
                        FontAwesome.money_bill_transfer_solid,
                        'Revenue',
                        screenWidth, () {
                      Navigator.pushNamed(context, AppRoutes.REVENUE);
                    }),
                    _buildIconOption(
                        context, BoxIcons.bx_sync, 'Processing', screenWidth),
                    _buildIconOption(
                      context,
                      Icons.thumb_up_off_alt_outlined,
                      'Feedback',
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
