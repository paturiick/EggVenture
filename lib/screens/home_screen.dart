import 'package:flutter/services.dart'; // Import this for SystemUiOverlayStyle
import 'package:eggventure/store_screen/daily_fresh_screen.dart';
import 'package:eggventure/store_screen/pabilona_screen.dart';
import 'package:eggventure/store_screen/pelonio_screen.dart';
import 'package:eggventure/store_screen/sundo_screen.dart';
import 'package:eggventure/store_screen/vista_screen.dart';
import 'package:eggventure/store_screen/wf_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // FocusNode and TextEditingController added for TextField
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> stores = [
    {
      'image': 'assets/stores/vista.jpg',
      'name': 'Vista',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat',
      'screen': VistaScreen(),
    },
    {
      'image': 'assets/stores/pelonio.png',
      'name': 'Pelonio',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat',
      'screen': PelonioScreen(),
    },
    {
      'image': 'assets/stores/daily_fresh.jpg',
      'name': 'Daily Fresh',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat',
      'screen': DailyFreshScreen(),
    },
    {
      'image': 'assets/stores/sundo.png',
      'name': 'Sundo',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat',
      'screen': SundoScreen(),
    },
    {
      'image': 'assets/stores/pabilona.jpg',
      'name': 'Pabilona',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat',
      'screen': PabilonaScreen(),
    },
  ];

  final List<Map<String, dynamic>> populars = [
    {
      'image': 'assets/stores/white_feathers.jpg',
      'name': 'White Feathers Farm',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat',
      'screen': WfScreen(),
    },
    {
      'image': 'assets/stores/pabilona_duck.jpg',
      'name': 'Pabilona Duck Farm',
      'hours': '8am - 5pm',
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
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'E',
                                style: TextStyle(
                                  fontFamily: 'AvenirNextCyr',
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.09,
                                  color: Color(0xFFF9B514),
                                ),
                              ),
                              TextSpan(
                                text: 'GG',
                                style: TextStyle(
                                  fontFamily: 'AvenirNextCyr',
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.06,
                                  color: Color(0xFF353E55),
                                ),
                              ),
                              TextSpan(
                                text: 'V',
                                style: TextStyle(
                                  fontFamily: 'AvenirNextCyr',
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.09,
                                  color: Color(0xFFF9B514),
                                ),
                              ),
                              TextSpan(
                                text: 'ENTURE',
                                style: TextStyle(
                                  fontFamily: 'AvenirNextCyr',
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.06,
                                  color: Color(0xFF353E55),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02,
                  ),
                  child: TextField(
                    cursorColor: Color(0xFFF9B514),
                    focusNode: _searchFocusNode, // Assign FocusNode
                    controller: _searchController, // Assign Controller
                    decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(AntDesign.search_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFFF9B514)))),
                    style: TextStyle(color: Color(0xFF353E55)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(
                    'Popular',
                    style: TextStyle(
                      fontFamily: 'AvenirNextCyr',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.06,
                      color: Color(0xFF353E55),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  height: size.height * 0.25,
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
                      color: Color(0xFF353E55),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  height: size.height * 1.1,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: stores.length,
                    itemBuilder: (context, index) {
                      final store = stores[index];
                      return _buildStoreItem(
                        context,
                        store['image']!,
                        store['name']!,
                        store['hours']!,
                        store['days']!,
                        store['screen'],
                        size,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBarWidget(currentIndex: 0),
        ),
      ),
    );
  }

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
      child: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.33,
              height: size.height * 0.12,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFFF9B514)),
                borderRadius: BorderRadius.circular(size.width * 0.03),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: Color(0xFF353E55),
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              time,
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontSize: size.width * 0.035,
                color: Colors.grey[600],
              ),
            ),
            Text(
              days,
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontSize: size.width * 0.035,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
