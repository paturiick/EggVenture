import 'package:eggventure/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
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
              'Order History',
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF353E55),
              ),
            ),
            SizedBox(height: 10), // Space between the text and the line
            Container(
              width: 500,
              height: 6,
              decoration: BoxDecoration(
                color: Color(0xFF353E55),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2), // Position of the shadow
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color(0xFFFFB612),
          unselectedLabelColor: Color(0xFF353E55),
          indicatorColor: Color(0xFFFFB612),
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Received'),
            Tab(text: 'Pending'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('No Transaction')),
          Center(child: Text('No Order Received Yet')),
          Center(child: Text('No Pending Orders')),
          Center(child: Text('No Cancelled Orders')),
        ],
      ),
      bottomNavigationBar: NavigationBarWidget(currentIndex: 1),
    );
  }
}
