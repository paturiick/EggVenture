import 'package:eggventure/screens/tray_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class WfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TrayScreen();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Color(0xFF353E55)),
            onPressed: () {
              // Something function for vertical dots
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
                height: 150,
                width: 250,
                child: Image.asset(
                  "assets/browse store/Egg_S.jpg",
                  fit: BoxFit.cover,
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
                color: Colors.white, // Changed color to white
                child: TextButton(
                  onPressed: () {
                    // Handle Chat Now action
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        AntDesign.message_outline,
                        color: Color(0xFF353E55), // Darker color for contrast
                      ),
                      SizedBox(height: 5), // Space between icon and text
                      Text(
                        "Chat Now",
                        style: TextStyle(color: Color(0xFF353E55)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            VerticalDivider(
              width: 1,
              color: Color(0xFF353E55), // Darker color for the divider
            ),
            Expanded(
              child: Container(
                color: Colors.white, // Changed color to white
                child: TextButton(
                  onPressed: () {
                    // Handle Add to Tray action
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        AntDesign.inbox_outline,
                        color: Color(0xFF353E55), // Darker color for contrast
                      ),
                      SizedBox(height: 5), // Space between icon and text
                      Text(
                        "Add to Tray",
                        style: TextStyle(color: Color(0xFF353E55)),
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
                          fontSize: 20,
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
    );
  }
}
