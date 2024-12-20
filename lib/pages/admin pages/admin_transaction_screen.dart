import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_admin.dart';

class AdminTransactionScreen extends StatefulWidget {
  @override
  _AdminTransactionScreenState createState() => _AdminTransactionScreenState();
}

class _AdminTransactionScreenState extends State<AdminTransactionScreen> {
  int _transactionCount = 0;
  late Future<List<Map<String, dynamic>>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _fetchTransactions();
  }

  Future<List<Map<String, dynamic>>> _fetchTransactions() async {
    List<Map<String, dynamic>> transactions = [];
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('transactions').get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        transactions.add({
          'transactionId': doc.id,
          'userName': data['userName'] ?? 'N/A',
          'amount': double.tryParse(data['total'] ?? '0.0') ?? 0.0,
          'timestamp':
              data.containsKey('timestamp') ? data['timestamp'].toDate() : null,
        });
      }
      setState(() {
        _transactionCount = transactions.length;
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
    return transactions;
  }

  void _refreshTransactions() {
    setState(() {
      _transactionsFuture = _fetchTransactions();
    });
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
                  color: AppColors.YELLOW,
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
                  backgroundColor: AppColors.YELLOW,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BLUE,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.refresh, color: AppColors.BLUE),
                      onPressed: _refreshTransactions,
                    ),
                  ],
                ),
              ),
              // Total Transaction Count Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Transactions",
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: AppColors.BLUE,
                        ),
                      ),
                      Text(
                        "$_transactionCount",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: AppColors.YELLOW,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Transactions List
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _transactionsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error fetching transactions.',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No transactions found.',
                          style: TextStyle(color: AppColors.BLUE),
                        ),
                      );
                    }

                    final transactions = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.receipt_long,
                                        color: AppColors.BLUE,
                                        size: 22,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Transaction ID: ${transaction['transactionId']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth * 0.03,
                                            color: AppColors.BLUE,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'User: ${transaction['userName']}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.025,
                                      color: Colors.grey[700],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Amount: P${transaction['amount'].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.BLUE,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Timestamp: ${transaction['timestamp'] ?? 'N/A'}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.025,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
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
        bottomNavigationBar: NavigationBarAdmin(currentIndex: 1),
      ),
    );
  }
}
