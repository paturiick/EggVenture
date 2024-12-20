import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:flutter/material.dart';

class RevenueScreen extends StatefulWidget {
  final String businessId;

  RevenueScreen({required this.businessId});

  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  late Future<List<Map<String, dynamic>>> _revenueDataFuture;

  @override
  void initState() {
    super.initState();
    _revenueDataFuture = _fetchRevenueData();
  }

  Future<List<Map<String, dynamic>>> _fetchRevenueData() async {
    List<Map<String, dynamic>> revenueList = [];

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(
              'transactions')
          .where('businessId', isEqualTo: widget.businessId)
          .get();

      for (var doc in querySnapshot.docs) {
        revenueList.add({
          'total': doc[
              'total'],
          'timestamp':
              doc['timestamp'].toDate(),
        });
      }
    } catch (e) {
      print('Error fetching revenue data: $e');
    }

    return revenueList;
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
                child: FutureBuilder<List<Map<String, dynamic>>>(
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
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No revenue data available.',
                          style: TextStyle(color: AppColors.BLUE),
                        ),
                      );
                    }

                    final revenueData = snapshot.data!;
                    return ListView.builder(
                      itemCount: revenueData.length,
                      itemBuilder: (context, index) {
                        final item = revenueData[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            title: Text(
                              'Total: ${item['total']}',
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
