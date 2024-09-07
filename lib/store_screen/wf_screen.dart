import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class WfScreen extends StatefulWidget {
  @override
  _WfScreenState createState() => _WfScreenState();
}

class _WfScreenState extends State<WfScreen> {
  String selectedImage = "assets/browse store/small_eggs.jpg";
  String selectedPrice = "P 140";
  String selectedName = "Small Egg Tray";

  final Map<String, Map<String, String>> productDetails = {
    "assets/browse store/small_eggs.jpg": {
      "price": "P 140",
      "name": "Small Egg Tray"
    },
    "assets/browse store/medium_eggs.jpg": {
      "price": "P 180",
      "name": "Medium Egg Tray"
    },
    "assets/browse store/large_eggs.jpeg": {
      "price": "P 220",
      "name": "Large Egg Tray"
    },
    "assets/browse store/xl_eggs.jpg": {
      "price": "P 250",
      "name": "XL Egg Tray"
    },
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
                // Navigate to TrayScreen
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
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  child: Image.asset(
                    selectedImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Text(
                  "4 Variations Available",
                  style: TextStyle(
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
                  selectedPrice,
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
                child: Text(
                  selectedName,
                  style: TextStyle(
                    fontFamily: "AvernirNextCyr",
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF353E55),
                  ),
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
                    Text(
                      "5/5 (Total Reviews)",
                      style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF353E55)),
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
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF353E55),
                  child: TextButton(
                    onPressed: () {
                      // Handle Chat Now action
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AntDesign.message_outline,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Chat Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              VerticalDivider(width: 1, color: Colors.white),
              Expanded(
                child: Container(
                  color: Color(0xFF353E55),
                  child: TextButton(
                    onPressed: () {
                      // Handle Add to Tray action
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AntDesign.inbox_outline,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Add to Tray",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0xFFF9B514),
                  child: TextButton(
                    onPressed: () {
                      // Handle Buy Now action
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
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
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = imagePath;
          selectedPrice = productDetails[imagePath]!["price"]!;
          selectedName = productDetails[imagePath]!["name"]!;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  selectedImage == imagePath ? Color(0xFFF9B514) : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
