import 'package:eggventure/widgets/navigation%20bars/navigation_bar_admin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';

class AdminTransactionScreen extends StatefulWidget {
  @override
  _AdminTransactionScreenState createState() => _AdminTransactionScreenState();
}

class _AdminTransactionScreenState extends State<AdminTransactionScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    setState(() => _isLoading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .orderBy('date', descending: true)
          .get();

      setState(() {
        _transactions = snapshot.docs
            .map((doc) => {
                  'transactionId': doc.id,
                  ...doc.data(),
                })
            .toList();
        _isLoading = false;
      });
    } catch (error) {
      setState(() => _isLoading = false);
      _showErrorDialog('Failed to fetch transactions: $error');
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction ID: ${transaction['transactionId']}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.BLUE,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Consumer: ${transaction['consumerName']}',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  'Farmer: ${transaction['farmerName']}',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Date: ${transaction['date']}',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              'Total Amount: ₱${transaction['totalAmount'].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
          ],
        ),
      ),
    );
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
                ),
              ),
              // Transaction List or Loading Indicator
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _transactions.isEmpty
                        ? Center(
                            child: Text(
                              'No transactions found.',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.BLUE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _fetchTransactions,
                            child: ListView.builder(
                              itemCount: _transactions.length,
                              itemBuilder: (context, index) {
                                return _buildTransactionCard(
                                    _transactions[index]);
                              },
                            ),
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
