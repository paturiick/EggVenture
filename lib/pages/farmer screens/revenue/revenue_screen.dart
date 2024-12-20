import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:flutter/material.dart';

class RevenueScreen extends StatefulWidget {
  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  late Future<Map<String, dynamic>> _revenueDataFuture;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _revenueDataFuture = _fetchRevenueData();
  }

  Future<Map<String, dynamic>> _fetchRevenueData() async {
    List<Map<String, dynamic>> revenueList = [];
    double totalRevenue = 0.0;
    final uid = await _firestoreService.getCurrentUserId();
    if (uid == null) {
      print('User ID is null. User might not be logged in.');
      return {'revenueList': [], 'totalRevenue': 0.0};
    }

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .where('userId', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No documents found for userId: $uid');
      }

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        double price = double.parse(data['total']);
        totalRevenue += price;
        revenueList.add({
          'price': price,
          'timestamp':
              data.containsKey('timestamp') ? data['timestamp'].toDate() : null,
        });
      }
    } catch (e) {
      print('Error fetching revenue data: $e');
    }

    return {'revenueList': revenueList, 'totalRevenue': totalRevenue};
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
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
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.BLUE,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.PROFILEFARMER);
                    },
                  ),
                  title: Text(
                    "Revenue",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BLUE,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
              // Revenue Data Section
              Expanded(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: _revenueDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error fetching data.',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!['revenueList'].isEmpty) {
                      return Center(
                        child: Text(
                          'No revenue data available.',
                          style: TextStyle(color: AppColors.BLUE),
                        ),
                      );
                    }

                    final revenueData = snapshot.data!['revenueList'] as List<Map<String, dynamic>>;
                    final totalRevenue = snapshot.data!['totalRevenue'] as double;

                    return Column(
                      children: [
                        // Display Total Revenue
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Total Revenue: \ P${totalRevenue.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: AppColors.BLUE,
                            ),
                          ),
                        ),
                        // List of Revenue Data
                        Expanded(
                          child: ListView.builder(
                            itemCount: revenueData.length,
                            itemBuilder: (context, index) {
                              final item = revenueData[index];
                              return Card(
                                elevation: 3,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: ListTile(
                                  title: Text(
                                    'Price: \ P${item['price'].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      color: AppColors.BLUE,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Timestamp: ${item['timestamp']}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
