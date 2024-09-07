
import 'package:flutter/material.dart';
import 'package:eggventure/widgets/navigation_bar_farmer.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatScreenFarmer extends StatefulWidget {
  @override
  _ChatScreenFarmerState createState() => _ChatScreenFarmerState();
}

class _ChatScreenFarmerState extends State<ChatScreenFarmer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Chats',
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                height: 1.2,
                color: Color(0xFF353E55),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                color: Color(0xFF353E55),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3, // Corrected typo here
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Color(0xFFF5F5F5),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 0),
    );
  }
}
