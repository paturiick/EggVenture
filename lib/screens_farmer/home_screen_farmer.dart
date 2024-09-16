import 'package:eggventure/widgets/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreenFarmer extends StatefulWidget {
  const HomeScreenFarmer({Key? key}) : super(key: key);

  @override
  _HomeScreenFarmerState createState() => _HomeScreenFarmerState();
}

class _HomeScreenFarmerState extends State<HomeScreenFarmer> {
  int selectedRating = 0; // 0 for All, 1 for 1 star, 2 for 2 stars, etc.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
            // Filter Buttons (All, 1 star, 2 star, etc.)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  filterButton('All', 0),
                  filterButton('1 ★', 1),
                  filterButton('2 ★', 2),
                  filterButton('3 ★', 3),
                  filterButton('4 ★', 4),
                  filterButton('5 ★', 5),
                ],
              ),
            ),
            SizedBox(height: 20),
            // This space is intentionally left blank for now
            // Add your content or other widgets here in the future
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 400, // Empty space for future content
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    'Content will be displayed here',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 0),
    );
  }

  // Widget for the filter buttons
  Widget filterButton(String text, int rating) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRating = rating;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selectedRating == rating ? Color(0xFFF9B514) : Color(0xFFF5F5F5),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedRating == rating ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
