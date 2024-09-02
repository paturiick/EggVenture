import 'package:eggventure/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // To enable scrolling if content overflows
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/Eggventure.png',
                      width: 50,
                    ),
                    SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'E',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: Color(0xFFF9B514),
                            ),
                          ),
                          TextSpan(
                            text: 'GG',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Color(0xFF353E55),
                            ),
                          ),
                          TextSpan(
                            text: 'V',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: Color(0xFFF9B514),
                            ),
                          ),
                          TextSpan(
                            text: 'ENTURE',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(AntDesign.search_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Popular',
                style: TextStyle(
                  fontFamily: 'AvenirNextCyr',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF353E55),
                ),
              ),
            ),
            // Popular section (2 items in a row)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStoreItem(context, 'assets/stores/white_feathers.jpg',
                      'White Feathers Farm', '8am - 5pm', 'Mon - Sat'),
                  _buildStoreItem(context, 'assets/stores/pabilona_duck.jpg',
                      'Pabilona Duck Farm', '8am - 5pm', 'Mon - Sat'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Suggested Stores',
                style: TextStyle(
                  fontFamily: 'AvenirNextCyr',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF353E55),
                ),
              ),
            ),
            // Suggested Stores section (2 items in a row)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStoreItem(context, 'assets/stores/vista.jpg',
                          'Vista', '8am - 5pm', 'Mon - Sat'),
                      _buildStoreItem(context, 'assets/stores/pelonio.png',
                          'Pelonio', '8am - 5pm', 'Mon - Sat'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStoreItem(context, 'assets/stores/daily_fresh.jpg',
                          'Daily Fresh', '8am - 5pm', 'Mon - Sat'),
                      _buildStoreItem(context, 'assets/stores/sundo.png',
                          'Sundo', '8am - 5pm', 'Mon - Sat'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStoreItem(context, 'assets/stores/pabilona.jpg',
                          'Pabilona', '8am - 5pm', 'Mon - Sat'),
                      // Add more stores here if needed
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarWidget(currentIndex: 0),
    );
  }

  // Helper method to build each store item with rounded edges and opening times
  Widget  _buildStoreItem(BuildContext context, String imagePath, String title,
      String time, String days) {
    return GestureDetector(
      onTap: () {
        // Navigate to other screen
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black
                  )
                ),
              
              // child: Image.asset(
              //   imagePath,
              //   width: 150,
              //   height: 150,
              //   fit: BoxFit.cover,
              // ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF353E55),
              ),
            ),
            SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF707070),
              ),
            ),
            Text(
              days,
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF707070),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
