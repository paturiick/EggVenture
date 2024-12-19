import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_admin.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _userCount = 0;
  int _businessCount = 0;
  int _dailyLogins = 0;
  double _monthlyGrowth = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    setState(() => _isLoading = true);
    try {
      // Fetch total users
      FirebaseFirestore.instance
          .collection('userDetails')
          .snapshots()
          .listen((userSnapshot) {
        setState(() {
          _userCount = userSnapshot.docs.length;
        });
      });

      // Fetch total businesses
      FirebaseFirestore.instance
          .collection('businessDetails')
          .snapshots()
          .listen((businessSnapshot) {
        setState(() {
          _businessCount = businessSnapshot.docs.length;
        });
      });
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      FirebaseFirestore.instance
          .collection('logins')
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .snapshots()
          .listen((loginSnapshot) {
        setState(() {
          _dailyLogins = loginSnapshot.docs.length;
        });
      });
      final startOfMonth = DateTime(today.year, today.month, 1);
      final lastMonth = DateTime(today.year, today.month - 1, 1);
      FirebaseFirestore.instance
          .collection('userDetails')
          .where('createdAt', isGreaterThanOrEqualTo: lastMonth)
          .snapshots()
          .listen((userSnapshot) {
        final lastMonthCount = userSnapshot.docs
            .where((doc) =>
                (doc['createdAt'] as Timestamp).toDate().isBefore(startOfMonth))
            .length;
        final currentMonthCount = userSnapshot.docs
            .where((doc) =>
                (doc['createdAt'] as Timestamp).toDate().isAfter(startOfMonth))
            .length;

        setState(() {
          _monthlyGrowth = lastMonthCount == 0
              ? 0.0
              : ((currentMonthCount - lastMonthCount) / lastMonthCount * 100)
                  .clamp(0, 100);
          _isLoading = false;
        });
      });
    } catch (error) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch data: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // AppBar Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.BLUE.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: AppColors.BLUE,
                  ),
                ),
                centerTitle: true,
              ),
            ),

            // Main Content
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // System Overview Header
                            Text(
                              'System Overview',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: AppColors.BLUE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Total Users Card
                            Card(
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading:
                                    Icon(Icons.group, color: Colors.blueAccent),
                                title: Text(
                                  'Total Users',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: AppColors.BLUE,
                                  ),
                                ),
                                trailing: Text(
                                  '$_userCount',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    color: AppColors.BLUE,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Total Businesses Card
                            Card(
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading:
                                    Icon(Icons.business, color: Colors.orange),
                                title: Text(
                                  'Total Businesses',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: AppColors.BLUE,
                                  ),
                                ),
                                trailing: Text(
                                  '$_businessCount',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    color: AppColors.BLUE,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            // Trends Section
                            Text(
                              'Trends & Insights',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: AppColors.BLUE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Monthly Growth and Daily Activity
                            Card(
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.trending_up,
                                        color: Colors.green),
                                    title: Text(
                                      'Monthly Growth',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: AppColors.BLUE,
                                      ),
                                    ),
                                    trailing: Text(
                                      '${_monthlyGrowth.toStringAsFixed(1)}%',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(Icons.bar_chart,
                                        color: Colors.blueAccent),
                                    title: Text(
                                      'Daily Activity',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: AppColors.BLUE,
                                      ),
                                    ),
                                    trailing: Text(
                                      '$_dailyLogins logins',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        color: AppColors.BLUE,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),

                            // Refresh Button
                            ElevatedButton.icon(
                              onPressed: _fetchCounts,
                              icon: Icon(
                                Icons.refresh,
                                color: AppColors.BLUE,
                              ),
                              label: Text(
                                'Refresh Data',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  color: AppColors.BLUE,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.YELLOW,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: NavigationBarAdmin(currentIndex: 0),
      ),
    );
  }
}
