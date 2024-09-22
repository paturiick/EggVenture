import 'package:eggventure/overlay_screens/add%20to%20tray/add_to_tray_screen.dart';
import 'package:eggventure/overlay_screens/buy%20now/buy_now_screen.dart';
import 'package:eggventure/screens/tray_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class WfScreen extends StatefulWidget {
  const WfScreen({super.key});

  @override
  State<WfScreen> createState() => _WfScreenState();
}

class _WfScreenState extends State<WfScreen> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  final List<String> imagePaths = [
    "assets/browse store/small_eggs.jpg",
    "assets/browse store/medium_eggs.jpg",
    "assets/browse store/large_eggs.jpeg",
    "assets/browse store/xl_eggs.jpg"
  ];

  final Map<String, Map<String, String>> productDetails = {
    "assets/browse store/small_eggs.jpg": {
      "price": "P 140",
      "name": "Small Egg Tray",
    },
    "assets/browse store/medium_eggs.jpg": {
      "price": "P 180",
      "name": "Medium Egg Tray",
    },
    "assets/browse store/large_eggs.jpeg": {
      "price": "P 220",
      "name": "Large Egg Tray",
    },
    "assets/browse store/xl_eggs.jpg": {
      "price": "P 250",
      "name": "XL Egg Tray",
    },
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF353E55)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(AntDesign.inbox_outline, color: Color(0xFF353E55)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TrayScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: Color(0xFF353E55)),
              onPressed: () {
                // Some action for the vertical dots
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: imagePaths.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              imagePaths[index],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 8,
                        right: 16,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${currentPageIndex + 1} / ${imagePaths.length}', // Image number indicator
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Text(
                  "4 Variations Available",
                  style: TextStyle(
                    color: Color(0xFF353E55),
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductVariation(
                        "assets/browse store/small_eggs.jpg"),
                    _buildProductVariation(
                        "assets/browse store/medium_eggs.jpg"),
                    _buildProductVariation(
                        "assets/browse store/large_eggs.jpeg"),
                    _buildProductVariation("assets/browse store/xl_eggs.jpg"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Text(
                  productDetails[imagePaths[currentPageIndex]]!["price"]!,
                  style: TextStyle(
                    fontFamily: "AvernirNextCyr",
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9B514),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productDetails[imagePaths[currentPageIndex]]!["name"]!,
                      style: TextStyle(
                        fontFamily: "AvernirNextCyr",
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF353E55),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Add product rating below product name
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Product Ratings",
                        style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF353E55),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03, vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        "5/5 (Total Reviews)",
                        style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF353E55)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined, color: Color(0xFF353E55)),
                    SizedBox(width: 5),
                    Text("25 - 40 MINS",
                        style: TextStyle(
                            color: Color(0xFF353E55),
                            fontFamily: 'AvenirNextCyr')),
                    SizedBox(width: 15),
                    Icon(Icons.pedal_bike, color: Color(0xFF353E55)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/stores/white_feathers.jpg"),
                  ),
                  title: Text(
                    "White Feathers Farm",
                    style: TextStyle(
                      fontFamily: "AvenirNextCyr",
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                      color: Color(0xFF353E55),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 10), // Add extra spacing at the bottom
            ],
          ),
        ),

        // gi container lng nako sha instead of bottomAppBar kay naay padding daan ang bottomAppBar
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Color(0xFF353E55)),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  child: TextButton(
                    onPressed: null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(AntDesign.message_outline,
                            color: Colors.white, size: 17),
                        SizedBox(height: 5),
                        Flexible(
                          child: Text(
                            "Chat Now",
                            style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 1, color: Colors.white))),
                  child: TextButton(
                    onPressed: () {
                      AddToTrayScreen.showAddToTrayScreen(context);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AntDesign.inbox_outline,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(height: 5),
                        Flexible(
                          child: Text(
                            "Add to Tray",
                            style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF9B514),
                  ),
                  child: TextButton(
                    onPressed: () {
                      BuyNowScreen.showBuyNowScreen(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "Buy Now",
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF353E55),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductVariation(String imagePath) {
    bool isSelected = imagePaths[currentPageIndex] == imagePath;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          int newIndex = imagePaths.indexOf(imagePath);
          setState(() {
            currentPageIndex = newIndex;
          });
          _pageController.jumpToPage(newIndex);
        },
        child: Container(
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: Color(0xFFF9B514), width: 2)
                : Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath, width: 80, height: 80),
          ),
        ),
      ),
    );
  }
}
