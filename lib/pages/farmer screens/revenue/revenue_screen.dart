import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
          .where('businessId', isEqualTo: uid)
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.YELLOW.withOpacity(0.8), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // AppBar Section
              Container(
                child: AppBar(
                  backgroundColor: AppColors.YELLOW,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.PROFILEFARMER);
                    },
                  ),
                  title: Text(
                    "Revenue",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                      return Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.BLUE,
                          size: 50.0,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error fetching data.',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!['revenueList'].isEmpty) {
                      return Center(
                        child: Text(
                          'No revenue data available.',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.BLUE,
                          ),
                        ),
                      );
                    }

                    final revenueData = snapshot.data!['revenueList']
                        as List<Map<String, dynamic>>;
                    final totalRevenue =
                        snapshot.data!['totalRevenue'] as double;

                    return Column(
                      children: [
                        // Total Revenue Summary Card
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.YELLOW, AppColors.BLUE],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Total Revenue",
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "P${totalRevenue.toStringAsFixed(2)}",
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.06,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // List of Revenue Data
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                            itemCount: revenueData.length,
                            itemBuilder: (context, index) {
                              final item = revenueData[index];
                              return Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: AppColors.BLUE,
                                    size: 36,
                                  ),
                                  title: Text(
                                    'Price: P${item['price'].toStringAsFixed(2)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.BLUE,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Timestamp: ${item['timestamp']}',
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.grey[600],
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
