import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:flutter/services.dart'; // Import this for SystemUiOverlayStyle
import 'package:eggventure/pages/store%20screens/daily_fresh_screen.dart';
import 'package:eggventure/pages/store%20screens/pabilona_screen.dart';
import 'package:eggventure/pages/store%20screens/pelonio_screen.dart';
import 'package:eggventure/pages/store%20screens/sundo_screen.dart';
import 'package:eggventure/pages/store%20screens/vista_screen.dart';
import 'package:eggventure/pages/store%20screens/white_feathers_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirestoreService _service = FirestoreService();
  late QuerySnapshot businessDetails;
  @override
  void initState() {
    super.initState();
    getBusinessDetails();
  }

  Future<List<Map<String, dynamic>>> getBusinessDetails() async {
    businessDetails = await _service.getBusinessDetails();
    stores = businessDetails.docs.map((doc) {
      return {
        'image': 'assets/stores/vista.jpg',
        'name': doc['shopName'],
        'hours': '8AM - 5PM',
        'days': 'Mon - Sat',
        'screen': VistaScreen(),
      };
    }).toList();
    print("Stores2: $stores");
    return stores;
  }

  List<Map<String, dynamic>> stores = [];

  final List<Map<String, dynamic>> populars = [
    {
      'image': 'assets/stores/white_feathers.jpg',
      'name': 'White Feathers Farm',
      'hours': '8AM - 5PM',
      'days': 'Mon - Sat',
      'screen': WhiteFeathersScreen(),
    },
    {
      'image': 'assets/stores/pabilona_duck.jpg',
      'name': 'Pabilona Duck Farm',
      'hours': '8AM - 5PM',
      'days': 'Mon - Sat',
      'screen': PabilonaScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    MediaQuery.textScaleFactorOf(context);

    return GestureDetector(
      // Detects taps outside the text field
      onTap: () {
        // Unfocus the text field and optionally clear its content
        FocusScope.of(context).unfocus();
        _searchController.clear();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/Eggventure.png',
                          width: size.width * 0.15,
                        ),
                        SizedBox(width: size.width * 0.02),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'E',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.09,
                                color: AppColors.YELLOW,
                              ),
                            ),
                            Text(
                              'GG',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.06,
                                color: AppColors.BLUE,
                              ),
                            ),
                            Text(
                              'V',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.09,
                                color: AppColors.YELLOW,
                              ),
                            ),
                            Text(
                              'ENTURE',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.06,
                                color: AppColors.BLUE,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.HOMESEARCH);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors
                              .YELLOW, // Add border color for focus effect
                          width: 1.0, // Border width
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.height * 0.015,
                      ),
                      child: Row(
                        children: [
                          Icon(AntDesign.search_outline, color: AppColors.BLUE),
                          SizedBox(width: size.width * 0.03),
                          Text(
                            'Search for stores',
                            style: TextStyle(
                              color: AppColors.BLUE,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: Text(
                    'Popular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.06,
                      color: AppColors.BLUE,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  height: size.height * 0.3,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: populars.length,
                    itemBuilder: (context, index) {
                      final popular = populars[index];
                      return _buildStoreItem(
                        context,
                        popular['image']!,
                        popular['name']!,
                        popular['hours']!,
                        popular['days']!,
                        popular['screen'],
                        size,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(
                    'Suggested Stores',
                    style: TextStyle(
                      fontFamily: 'AvenirNextCyr',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.045,
                      color: AppColors.BLUE,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                FutureBuilder(
                  future:
                      getBusinessDetails(), // Assuming this is the function that fetches the data
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child:
                              CircularProgressIndicator()); // Show a loading indicator while waiting for data
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasData) {
                        stores = snapshot.data!; // Assign the fetched data to the stores variable
                        return SizedBox(
                          height: size.height * 1.1,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: stores.length,
                            itemBuilder: (context, index) {
                              final store = stores[index];
                              print('Store: $stores');
                              return _buildStoreItem(
                                context,
                                store['image'] ?? '',
                                store['name'] ?? '',
                                store['hours'] ?? '',
                                store['days'] ?? '',
                                store['screen'] ?? VistaScreen(),
                                size,
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                            child: Text(
                                'No data available')); // Handle the case where no data is available
                      }
                    } else {
                      return Center(
                          child: Text(
                              'Error fetching data')); // Handle the case where an error occurs while fetching data
                    }
                  },
                )
              ],
            ),
          ),
          bottomNavigationBar: NavigationBarWidget(currentIndex: 0),
        ),
      ),
    );
  }

  @override
  Widget _buildStoreItem(BuildContext context, String imagePath, String title,
      String time, String days, Widget screen, Size size) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        },
        child: ClipRect(
          child: Container(
            margin: EdgeInsets.all(size.width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: AppColors.YELLOW, width: size.width * 0.001),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 4),
                  blurRadius: 5,
                ),
              ],
            ),
            height: size.height * 0.45, // Adjusted height
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: size.height * 0.1, // Adjusted image height
                      fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.039,
                        color: AppColors.BLUE,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2, // Allow title to span two lines if necessary
                      overflow: TextOverflow.ellipsis, // Handle long titles
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Icon(
                        Icons.timelapse_outlined,
                        color: AppColors.YELLOW,
                      ),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        time,
                        style: TextStyle(
                          color: AppColors.BLUE,
                          fontSize: size.width * 0.025,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Icon(
                        AntDesign.calendar_outline,
                        color: AppColors.YELLOW,
                      ),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        days,
                        style: TextStyle(
                          color: AppColors.BLUE,
                          fontSize: size.width * 0.025,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01), // Reduced size
                ],
              ),
            ),
          ),
        ));
  }
}
