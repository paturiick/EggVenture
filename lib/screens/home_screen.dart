import 'package:eggventure/store_screen/wf_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> stores = [
    {
      'image': 'assets/stores/vista.jpg',
      'name': 'Vista',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat'
    },
    {
      'image': 'assets/stores/pelonio.png',
      'name': 'Pelonio',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat'
    },
    {
      'image': 'assets/stores/daily_fresh.jpg',
      'name': 'Daily Fresh',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat'
    },
    {
      'image': 'assets/stores/sundo.png',
      'name': 'Sundo',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat'
    },
    {
      'image': 'assets/stores/pabilona.jpg',
      'name': 'Pabilona',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat'
    },
    // Add more stores here if needed
  ];

  final List<Map<String, String>> populars = [
    {
      'image': 'assets/stores/white_feathers.jpg',
      'name': 'White Feathers Farm',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat'
    },
    {
      'image': 'assets/stores/pabilona_duck.jpg',
      'name': 'Pabilona Duck Farm',
      'hours': '8am - 5pm',
      'days': 'Mon - Sat'
    }
  ];

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
                  fontSize: 25,
                  color: Color(0xFF353E55),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250, // Define a height for the grid
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
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
                  );
                },
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
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.sizeOf(context).height *
                  1.1, // Define a height for the grid
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarWidget(currentIndex: 0),
    );
  }

  // Helper method to build each store item with rounded edges and opening times
  Widget _buildStoreItem(BuildContext context, String imagePath, String title,
      String time, String days) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WfScreen(),
          ),
        );
        // Add more navigation logic for other items if needed
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
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
