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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                'Order History',
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
                decoration: BoxDecoration(
                  color: Color(0xFF353E55),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30), // Reduced height of tab bar
            child: TabBar(
              controller: _tabController,
              labelColor: Color(0xFFFFB612),
              unselectedLabelColor: Color(0xFF353E55),
              indicatorColor: Color(0xFFFFB612),
              indicatorWeight: 1,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(
                  horizontal: 10), // Adjust this value to control gaps
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Received'),
                Tab(text: 'Pending'),
                Tab(text: 'Cancelled'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTabContent('No Transaction'),
            _buildTabContent('No Order Received Yet'),
            _buildTabContent('No Pending Orders'),
            _buildTabContent('No Cancelled Orders'),
          ],
        ),
        bottomNavigationBar: NavigationBarWidget(currentIndex: 1),
      ),
    );
  }

  Widget _buildTabContent(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 16, color: Color(0xFF353E55)),
      ),
    );
  }
}
